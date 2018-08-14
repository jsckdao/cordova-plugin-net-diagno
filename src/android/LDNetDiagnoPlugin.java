package com.mopgame.netdiagno;

import com.netease.LDNetDiagnoService.LDNetDiagnoListener;
import com.netease.LDNetDiagnoService.LDNetDiagnoService;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class LDNetDiagnoPlugin extends CordovaPlugin {

    volatile boolean isRun = false;

    LDNetDiagnoService _netDiagnoService;

    LDNetDiagnoListener theListener = new LDNetDiagnoListener() {
        @Override
        public void OnNetDiagnoFinished(String log) {
            LDNetDiagnoPlugin.this.sendFinishEvent(log);
            _netDiagnoService.stopNetDialogsis();
            _netDiagnoService = null;
            currentCallback = null;
            isRun = false;
        }

        @Override
        public void OnNetDiagnoUpdated(String log) {
            LDNetDiagnoPlugin.this.sendProgressEvent(log);
        }
    };

    CallbackContext currentCallback;

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if ("execRouteCheck".equals(action)) {

            if (isRun) {
                callbackContext.error("service has run!");
                return true;
            }


            String dormain = args.getString(0);
            CordovaPlugin self = this;
            currentCallback = callbackContext;
            isRun = true;

            this.sendStartEvent();

            _netDiagnoService = new LDNetDiagnoService(self.webView.getContext().getApplicationContext(),
                    "testDemo", "网络诊断应用", "1.0.0", "test@test.com",
                    "deviceID(option)", dormain, "carriname", "ISOCountyCode",
                    "MobilCountryCode", "MobileNetCode", theListener);

            //设置是否使用JNIC 完成traceroute
            _netDiagnoService.setIfUseJNICTrace(true);
            //_netDiagnoService.setIfUseJNICConn(true);
            _netDiagnoService.execute();

        }
        else {
            return false;
        }
        return true;
    }

    private void sendStartEvent() {
        if (!isRun) return;
        try {
            JSONObject r = new JSONObject();
            r.put("type", "start");
            PluginResult res = new PluginResult(PluginResult.Status.OK, r);
            res.setKeepCallback(true);
            this.currentCallback.sendPluginResult(res);
        } catch (JSONException e) {}
    }

    private void sendProgressEvent(String log) {
        if (!isRun) return;
        try {
            JSONObject r = new JSONObject();
            r.put("type", "step");
            r.put("out", log);
            PluginResult res = new PluginResult(PluginResult.Status.OK, r);
            res.setKeepCallback(true);
            this.currentCallback.sendPluginResult(res);
        } catch (JSONException e) {}
    }

    private void sendFinishEvent(String log) {
        if (!isRun) return;
        try {
            JSONObject r = new JSONObject();
            r.put("type", "finished");
            r.put("out", log);
            PluginResult res = new PluginResult(PluginResult.Status.OK, r);
            // res.setKeepCallback(true);
            this.currentCallback.sendPluginResult(res);
        } catch (JSONException e) {}
    }
}

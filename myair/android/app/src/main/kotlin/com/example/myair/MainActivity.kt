package com.example.myair
import androidx.annotation.NonNull
import io.flutter.Log
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.myair/homeWidget"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine){
        super.configureFlutterEngine(flutterEngine);

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
            call, result ->
            if (call.method == "updateHomeWidget") {
                val PM10 = call.argument<String>("PM10");
                val PM25 = call.argument<String>("PM2.5");
                val CO = call.argument<String>("CO");
                val AQI = call.argument<String>("AQI");
                //__android_log_print(ANDROID_LOG_DEBUG, "LOG_TAG", "Need to print :  %s", PM10);
                //result.success(PM10);
//Call method
                // if (batteryLevel != -1) {
                //    result.success(batteryLevel)
                //  } else {
                //       result.error("UNAVAILABLE", "Battery level not available.", null)
                //   }
            } else {
                result.notImplemented()
            }
        }

    }

   // private fun getBatteryLevel(): Int {
   //     val batteryLevel: Int
   //     if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
   //         val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
   //         batteryLevel = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
   //     } else {
   //         val intent = ContextWrapper(applicationContext).registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
    //        batteryLevel = intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1)
   //     }

    //    return batteryLevel
   // }
}

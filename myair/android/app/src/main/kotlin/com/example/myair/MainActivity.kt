package com.example.myair
import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.myair/homeWidget"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine){
        super.configureFlutterEngine(flutterEngine);

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            // Note: this method is invoked on the main thread.
            call, result ->
            if (call.method == "updateHomeWidget") {
                val PM10 = call.argument<String>("PM10")
                val PM25 = call.argument<String>("PM2.5")
                val CO = call.argument<String>("CO")
                val AQI = call.argument<String>("AQI")
                val intent = Intent(this, HomeWidgetProvider::class.java)
                intent.action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
                val ids: IntArray = AppWidgetManager.getInstance(application).getAppWidgetIds(ComponentName(getApplication(), HomeWidgetProvider::class.java))
                intent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, ids)
                if (PM10 != null) {
                    if (PM25 != null) {
                        if (CO != null) {
                            if (AQI != null) {

                                intent.putExtra("PM10", PM10.toInt())
                                intent.putExtra("PM25", PM25.toInt())
                                intent.putExtra("CO", CO.toInt())
                                intent.putExtra("AQI", AQI.toInt())
                            }
                        }
                    }
                }
                // Use an array and EXTRA_APPWIDGET_IDS instead of AppWidgetManager.EXTRA_APPWIDGET_ID,
                // since it seems the onUpdate() is only fired on that:
                // Use an array and EXTRA_APPWIDGET_IDS instead of AppWidgetManager.EXTRA_APPWIDGET_ID,
                // since it seems the onUpdate() is only fired on that:


                sendBroadcast(intent)

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

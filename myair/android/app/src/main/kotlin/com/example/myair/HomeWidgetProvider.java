package com.example.myair;

import android.app.PendingIntent;
import android.appwidget.AppWidgetManager;
import android.appwidget.AppWidgetProvider;
import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.widget.RemoteViews;

import static android.app.Notification.EXTRA_MESSAGES;

public class HomeWidgetProvider extends  AppWidgetProvider {
    int AQI;
    int PM10;
    int PM25;
    int CO;
    @Override
    public void onReceive(Context context, Intent intent) {


       AQI = intent.getIntExtra("AQI",10);

       PM10 = intent.getIntExtra("PM10",0);
       PM25 =intent.getIntExtra("PM25",0);
       CO = intent.getIntExtra("CO",0);

        super.onReceive(context, intent);
    }

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager, int[] appWidgetIds) {

        for(int appWidgetId : appWidgetIds){


            Intent intent = new Intent(context, HomeWidgetProvider.class);
            PendingIntent pendingIntent = PendingIntent.getBroadcast(context, 0, intent, 0);
            RemoteViews views = new RemoteViews(context.getPackageName(), R.layout.home_widget);
            views.setOnClickPendingIntent(R.id.home_widget, pendingIntent);
            views.setProgressBar(R.id.AQIprogressBar,500,AQI,false);
            views.setProgressBar(R.id.PM10progressBar,100,PM10,false);
            views.setProgressBar(R.id.progressBar,50,PM25,false);
            views.setProgressBar(R.id.COprogressBar,10,CO,false);
            appWidgetManager.updateAppWidget(appWidgetId, views);
        }
    }
}
/*
public class MyWidgetProvider extends AppWidgetProvider {

    private static final String ACTION_CLICK = "ACTION_CLICK";

    @Override
    public void onUpdate(Context context, AppWidgetManager appWidgetManager,  int[] appWidgetIds) {

        // Get all ids
        ComponentName thisWidget = new ComponentName(context,  MyWidgetProvider.class);
        int[] allWidgetIds = appWidgetManager.getAppWidgetIds(thisWidget);
        for (int widgetId : allWidgetIds) {
            // create some random data
            int number = (new Random().nextInt(100));

            RemoteViews remoteViews = new RemoteViews(context.getPackageName(),
                    R.layout.widget_layout);
            Log.w("WidgetExample", String.valueOf(number));
            // Set the text
            remoteViews.setTextViewText(R.id.update, String.valueOf(number));

            // Register an onClickListener
            Intent intent = new Intent(context, MyWidgetProvider.class);

            intent.setAction(AppWidgetManager.ACTION_APPWIDGET_UPDATE);
            intent.putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, appWidgetIds);

            PendingIntent pendingIntent = PendingIntent.getBroadcast(context,
                    0, intent, PendingIntent.FLAG_UPDATE_CURRENT);
            remoteViews.setOnClickPendingIntent(R.id.update, pendingIntent);
            appWidgetManager.updateAppWidget(widgetId, remoteViews);
        }
    }
}
* */
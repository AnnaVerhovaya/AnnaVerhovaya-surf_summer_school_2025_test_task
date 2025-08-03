package com.example.flutter_application_4

import android.app.Application
import com.yandex.mapkit.MapKitFactory

class MainApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        MapKitFactory.setApiKey("6d4cf8e7-24da-4d78-b58b-83da797f863d")
    }
}
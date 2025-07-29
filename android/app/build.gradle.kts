plugins {
    id("com.android.application")
    id("org.jetbrains.kotlin.android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services")
    id("com.onesignal.androidsdk.onesignal-gradle-plugin")
}

android {
    namespace = "com.example.found_soul_mobile_app" // ✅ Correct namespace for your app
    compileSdk = 35
    ndkVersion = "27.0.12077973"

    defaultConfig {
        applicationId = "com.example.found_soul_mobile_app"
        minSdk = 23
        targetSdk = 35
        versionCode = 1
        versionName = "1.0"

        manifestPlaceholders.putAll(
            mapOf(
                "onesignal_app_id" to "Ybb4fb296-3956-4d55-985e-fa52d9d4b795",
                "onesignal_google_project_number" to "REMOTE"
            )
        )
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

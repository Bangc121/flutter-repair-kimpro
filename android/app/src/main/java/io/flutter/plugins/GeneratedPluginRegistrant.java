package io.flutter.plugins;

import androidx.annotation.Keep;
import androidx.annotation.NonNull;
import io.flutter.Log;

import io.flutter.embedding.engine.FlutterEngine;

/**
 * Generated file. Do not edit.
 * This file is generated by the Flutter tool based on the
 * plugins that support the Android platform.
 */
@Keep
public final class GeneratedPluginRegistrant {
  private static final String TAG = "GeneratedPluginRegistrant";
  public static void registerWith(@NonNull FlutterEngine flutterEngine) {
    try {
      flutterEngine.getPlugins().add(new com.kholifanalfon.bs_flutter.BsFlutterPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin bs_flutter, com.kholifanalfon.bs_flutter.BsFlutterPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.bsflutter.alert.bs_flutter_alert.BsFlutterAlertPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin bs_flutter_alert, com.bsflutter.alert.bs_flutter_alert.BsFlutterAlertPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.example.bs_flutter_buttons.BsFlutterButtonsPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin bs_flutter_buttons, com.example.bs_flutter_buttons.BsFlutterButtonsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.bsflutter.card.bs_flutter_card.BsFlutterCardPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin bs_flutter_card, com.bsflutter.card.bs_flutter_card.BsFlutterCardPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.example.bs_flutter_datatable.BsFlutterDatatablePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin bs_flutter_datatable, com.example.bs_flutter_datatable.BsFlutterDatatablePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.example.bs_flutter_inputtext.BsFlutterInputtextPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin bs_flutter_inputtext, com.example.bs_flutter_inputtext.BsFlutterInputtextPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.bsflutter.modal.bs_flutter_modal.BsFlutterModalPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin bs_flutter_modal, com.bsflutter.modal.bs_flutter_modal.BsFlutterModalPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.bs.responsive.bs_flutter_responsive.BsFlutterResponsivePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin bs_flutter_responsive, com.bs.responsive.bs_flutter_responsive.BsFlutterResponsivePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.bsselectbox.bs_flutter_selectbox.BsFlutterSelectboxPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin bs_flutter_selectbox, com.bsselectbox.bs_flutter_selectbox.BsFlutterSelectboxPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new com.example.bs_flutter_utils.BsFlutterUtilsPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin bs_flutter_utils, com.example.bs_flutter_utils.BsFlutterUtilsPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.firestore.FlutterFirebaseFirestorePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin cloud_firestore, io.flutter.plugins.firebase.firestore.FlutterFirebaseFirestorePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new dev.fluttercommunity.plus.connectivity.ConnectivityPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin connectivity_plus, dev.fluttercommunity.plus.connectivity.ConnectivityPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_auth, io.flutter.plugins.firebase.auth.FlutterFirebaseAuthPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_core, io.flutter.plugins.firebase.core.FlutterFirebaseCorePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.firebase.storage.FlutterFirebaseStoragePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin firebase_storage, io.flutter.plugins.firebase.storage.FlutterFirebaseStoragePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin flutter_plugin_android_lifecycle, io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.imagepicker.ImagePickerPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin image_picker_android, io.flutter.plugins.imagepicker.ImagePickerPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.pathprovider.PathProviderPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin path_provider_android, io.flutter.plugins.pathprovider.PathProviderPlugin", e);
    }
    try {
      flutterEngine.getPlugins().add(new io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin());
    } catch(Exception e) {
      Log.e(TAG, "Error registering plugin shared_preferences_android, io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin", e);
    }
  }
}

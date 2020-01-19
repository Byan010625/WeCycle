package com.teamblnd.wecycle;


import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "com.teamblnd.wecycle/imgclassif";
  private static final String PROJECT_ID = "wecycle-c110c";
  private static final String MODEL_ID = "ICN7476692263016333312";

  @Override
  public void configureFlutterEngine(FlutterEngine flutterEngine) {
    GeneratedPluginRegistrant.registerWith(flutterEngine);
  }


  //TODO: GET API KEY  FROM LINUX

}

class Settings {

  Data settings;

  Settings(String _s) {
    try {
      settings = new Data();
      settings.load(_s);
      for (int i=0;i<settings.data.length;i++) {
        if (settings.data[i].equals("Mirror")) mirror = setBoolean(settings.data[i+1]);
        if (settings.data[i].equals("ShowSeparateWebCam")) usewebcam = setBoolean(settings.data[i+1]);
        if (settings.data[i].equals("WebCamWidth")) webcamWidth =setInt(settings.data[i+1]);
        if (settings.data[i].equals("WebCamHeight")) webcamHeight = setInt(settings.data[i+1]);
        if (settings.data[i].equals("TrackingScale")) trackingWindowScale = setFloat(settings.data[i+1]);
        
        if (settings.data[i].equals("WorldScale")) worldScale = setFloat(settings.data[i+1]);
        if (settings.data[i].equals("FPS")) fps = setInt(settings.data[i+1]);
        if (settings.data[i].equals("SendRotation")) sendrotation = setBoolean(settings.data[i+1]);
        if (settings.data[i].equals("ShowDepth")) showKinectDepth = setBoolean(settings.data[i+1]);
        if (settings.data[i].equals("ShowRGB")) showKinectRGB = setBoolean(settings.data[i+1]);
        if (settings.data[i].equals("HeadJoint")) headOSC = setString(settings.data[i+1]);
        if (settings.data[i].equals("NeckJoint")) neckOSC = setString(settings.data[i+1]);
        if (settings.data[i].equals("RShoulderJoint")) rshoulderOSC = setString(settings.data[i+1]);
        if (settings.data[i].equals("RElbowJoint")) relbowOSC = setString(settings.data[i+1]);
        if (settings.data[i].equals("RHandJoint")) rhandOSC = setString(settings.data[i+1]);
        if (settings.data[i].equals("LShoulderJoint")) lshoulderOSC = setString(settings.data[i+1]);
        if (settings.data[i].equals("LElbowJoint")) lelbowOSC = setString(settings.data[i+1]);
        if (settings.data[i].equals("LHandJoint")) lhandOSC = setString(settings.data[i+1]);
        if (settings.data[i].equals("BodyJoint")) bodyOSC = setString(settings.data[i+1]);
        if (settings.data[i].equals("RHipJoint")) rhipOSC = setString(settings.data[i+1]);
        if (settings.data[i].equals("RKneeJoint")) rkneeOSC = setString(settings.data[i+1]);
        if (settings.data[i].equals("RFootJoint")) rfootOSC = setString(settings.data[i+1]);
        if (settings.data[i].equals("LHipJoint")) lhipOSC = setString(settings.data[i+1]);
        if (settings.data[i].equals("LKneeJoint")) lkneeOSC = setString(settings.data[i+1]);
        if (settings.data[i].equals("LFootJoint")) lfootOSC = setString(settings.data[i+1]);
        
        if (settings.data[i].equals("SendToAddress")) sendToAddress = setString(settings.data[i+1]);
        if (settings.data[i].equals("SendToPort")) sendToPort = setInt(settings.data[i+1]);
        if (settings.data[i].equals("ReceivePort")) receiveAtPort = setInt(settings.data[i+1]);

       }
    } 
    catch(Exception e) {
      println("Couldn't load settings file. Using defaults.");
    }
  }

  int setInt(String _s) {
    return int(_s);
  }

  float setFloat(String _s) {
    return float(_s);
  }

  boolean setBoolean(String _s) {
    return boolean(_s);
  }
  
  String setString(String _s) {
    return ""+(_s);
  }
  
  String[] setStringArray(String _s) {
    int commaCounter=0;
    for(int j=0;j<_s.length();j++){
          if (_s.charAt(j)==char(',')){
            commaCounter++;
          }      
    }
    //println(commaCounter);
    String[] buildArray = new String[commaCounter+1];
    commaCounter=0;
    for(int k=0;k<buildArray.length;k++){
      buildArray[k] = "";
    }
    for (int i=0;i<_s.length();i++) {
        if (_s.charAt(i)!=char(' ') && _s.charAt(i)!=char('(') && _s.charAt(i)!=char(')') && _s.charAt(i)!=char('{') && _s.charAt(i)!=char('}') && _s.charAt(i)!=char('[') && _s.charAt(i)!=char(']')) {
          if (_s.charAt(i)==char(',')){
            commaCounter++;
          }else{
            buildArray[commaCounter] += _s.charAt(i);
         }
       }
     }
     println(buildArray);
     return buildArray;
  }

  color setColor(String _s) {
    color endColor = color(0);
    int commaCounter=0;
    String sr = "";
    String sg = "";
    String sb = "";
    String sa = "";
    int r = 0;
    int g = 0;
    int b = 0;
    int a = 0;

    for (int i=0;i<_s.length();i++) {
        if (_s.charAt(i)!=char(' ') && _s.charAt(i)!=char('(') && _s.charAt(i)!=char(')')) {
          if (_s.charAt(i)==char(',')){
            commaCounter++;
          }else{
          if (commaCounter==0) sr += _s.charAt(i);
          if (commaCounter==1) sg += _s.charAt(i);
          if (commaCounter==2) sb += _s.charAt(i); 
          if (commaCounter==3) sa += _s.charAt(i);
         }
       }
     }

    if (sr!="" && sg=="" && sb=="" && sa=="") {
      r = int(sr);
      endColor = color(r);
    }
    if (sr!="" && sg!="" && sb=="" && sa=="") {
      r = int(sr);
      g = int(sg);
      endColor = color(r, g);
    }
    if (sr!="" && sg!="" && sb!="" && sa=="") {
      r = int(sr);
      g = int(sg);
      b = int(sb);
      endColor = color(r, g, b);
    }
    if (sr!="" && sg!="" && sb!="" && sa!="") {
      r = int(sr);
      g = int(sg);
      b = int(sb);
      a = int(sa);
      endColor = color(r, g, b, a);
    }
      return endColor;
  }
  
  PVector setPVector(String _s){
    PVector endPVector = new PVector(0,0,0);
    int commaCounter=0;
    String sx = "";
    String sy = "";
    String sz = "";
    float x = 0;
    float y = 0;
    float z = 0;

    for (int i=0;i<_s.length();i++) {
        if (_s.charAt(i)!=char(' ') && _s.charAt(i)!=char('(') && _s.charAt(i)!=char(')')) {
          if (_s.charAt(i)==char(',')){
            commaCounter++;
          }else{
          if (commaCounter==0) sx += _s.charAt(i);
          if (commaCounter==1) sy += _s.charAt(i);
          if (commaCounter==2) sz += _s.charAt(i); 
         }
       }
     }

    if (sx!="" && sy=="" && sz=="") {
      x = float(sx);
      endPVector = new PVector(x,0);
    }
    if (sx!="" && sy!="" && sz=="") {
      x = float(sx);
      y = float(sy);
      endPVector = new PVector(x,y);
    }
    if (sx!="" && sy!="" && sz!="") {
      x = float(sx);
      y = float(sy);
      z = float(sz);
      endPVector = new PVector(x,y,z);
    }
      return endPVector;
  }
}


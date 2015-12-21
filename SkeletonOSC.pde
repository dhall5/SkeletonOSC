
/******************************
 //A sketch designed to produce compatible OSC output
 //for using in Blender via NI-Mates Official Free Addon
 // Author: Dan Hall
 // Email: dhall5@gmail.com
 
 //Feel free to do whatever you want with this
 ******************************/


import processing.video.*;
import SimpleOpenNI.*;


import toxi.geom.Quaternion;
import toxi.geom.Matrix4x4;

import oscP5.*;
import netP5.*;


OscP5 oscP5;
NetAddress myRemoteLocation;
Capture webcam;
int receiveAtPort = 7001;
int sendToPort = 7000;  
String sendToAddress="127.0.0.1";


SimpleOpenNI  kinect;
PImage kinectImg;
PGraphics kinectBG;
int windowWidth=640;
int windowHeight=480;

int webcamWidth=640;
int webcamHeight=480;
float trackingWindowScale = .25;
boolean mirror = true;
boolean showKinectDepth = false;
boolean showKinectRGB = false;
boolean sendrotation = true;
boolean multiThread = true;
boolean usewebcam = true;

int trackinguserID=1;
float worldScale=-.5;
float fps=15;
String headOSC="Head";
String neckOSC="Neck";
String bodyOSC="Body";
String rshoulderOSC="Shoulder_R";
String relbowOSC="Elbow_R";
String rhandOSC="Hand_R";
String lshoulderOSC="Shoulder_L";
String lelbowOSC="Elbow_L";
String lhandOSC="Hand_L";
String rhipOSC="Hip_R";
String rkneeOSC="Knee_R";
String rfootOSC="Foot_R";
String lhipOSC="Hip_L";
String lkneeOSC="Knee_L";
String lfootOSC="Foot_L";
color userColor=color(255, 255, 0);


void pickCamera() {
  String[] cameras = Capture.list();
  /*for (int i = 0; i < cameras.length; i++) {
   print(cameras[i]);
   }*/
  //webcam=new Capture(this,windowWidth,windowHeight);
  // Or, the settings can be defined based on the text in the list
  webcam = new Capture(this, webcamWidth, webcamHeight, "", 30);
  webcam.start();
}


void setup()
{
  Settings settings = new Settings(dataPath("settings.txt"));
  if (usewebcam) {
    windowWidth=webcamWidth;
    windowHeight=webcamHeight;
    pickCamera();
    // webcam = new Capture(this,windowWidth,windowHeight);
    //webcam.start(); 
    // size(windowWidth*2, windowHeight);
  }
  size(windowWidth, windowHeight);
  if (showKinectDepth) {
    userColor=color(255, 0, 0);
  }


  kinect = new SimpleOpenNI(this, SimpleOpenNI.RUN_MODE_MULTI_THREADED);
  kinect.setMirror(mirror);
  kinect.enableDepth();
  kinect.enableUser();
  if (showKinectRGB) {
    kinect.enableRGB();
    kinect.alternativeViewPointDepthToImage();
  }

  strokeWeight(3);
  frameRate(fps);
  kinectBG=createGraphics(640, 480);
  kinectBG.beginDraw();
  kinectBG.background(100);
  kinectBG.endDraw();

  oscP5 = new OscP5(this, receiveAtPort);
  myRemoteLocation = new NetAddress(sendToAddress, sendToPort);
} 

//The kinect area of the window will be gray until a skeleton is being tracked
//Once you see a yellow or red stick figure, you know you're tracked and that you are broadcasting
//the OSC message.
void draw() {
  if (usewebcam && webcam.available()==true) {
    webcam.read();
    if (mirror) {
      scale(-1, 1); 
      image(webcam, -width, 0);
      scale(-1, 1);
    } else {
      
      set(0, 0, webcam);
    }
  }  
  kinect.update();
  if (showKinectDepth) {
    kinectImg = kinect.depthImage();
  } else if (showKinectRGB) {
    kinectImg = kinect.rgbImage();
  } else {
    kinectImg = kinectBG;
  }

  if (usewebcam) {
    scale(trackingWindowScale);
    image(kinectImg, 0, 0);
  } else {
    set(0, 0, kinectImg);
  }
  drawUser();
} 




PVector depthToWorld(float x, float y, float z) { 
  //http://nicolas.burrus.name/index.php/Research/KinectCalibration
  final double fx_d = 5.9421434211923247e+02; 
  final double fy_d =  5.9104053696870778e+02; 
  final double cx_d = 3.3930780975300314e+02; 
  final double cy_d = 2.4273913761751615e+02; 

  PVector result = new PVector(); 
  double depth =   ((double)(z) * -0.0030711016 + 3.3309495161);

  result.x = .5*(float)((x - cx_d) * depth / fx_d); 
  result.y = -.5*(float)((y - cy_d) * depth / fy_d); 
  result.z = worldScale*(float)(depth);
  // result.mult(worldScale);
  return result;
}




void drawUser() {
  if (kinect.isTrackingSkeleton(trackinguserID)) {
    stroke(userColor);
    fill(userColor);
    drawSkeleton(trackinguserID); 
    sendOSC(trackinguserID);
  }
}


void drawSkeleton(int userId) {

  PVector headPosition = new PVector();
  float distanceScalar;
  float headSize = 200;

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, headPosition);
  kinect.convertRealWorldToProjective(headPosition, headPosition);
  distanceScalar = (525/headPosition.z);
  ellipse(headPosition.x, headPosition.y, distanceScalar*headSize, distanceScalar*headSize);

  kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);
} 

int setUserID() {
  int i=1;
  for (i=1; i<=6; i=i+1) {
    if (kinect.isTrackingSkeleton(i)) {
      return i;
    }
  }
  return 1;
}


void onNewUser(SimpleOpenNI curContext, int userId) {
  println("New User Detected - userId: " + userId);
  // start tracking of user id
  trackinguserID=setUserID();
  curContext.startTrackingSkeleton(trackinguserID);
} //void onNewUser(SimpleOpenNI curContext, int userId)


void onLostUser(SimpleOpenNI curContext, int userId) {
  // print user lost and user id
  println("User Lost - userId: " + userId);
  trackinguserID=setUserID();
  curContext.startTrackingSkeleton(trackinguserID);
} //void onLostUser(SimpleOpenNI curContext, int userId)


void onVisibleUser(SimpleOpenNI curContext, int userId) {
  //println("User Visible - userId: " + userId);
  //trackinguserID=setUserID();
  trackinguserID=userId;
} //void onVisibleUser(SimpleOpenNI curContext, int userId)


void onOutOfSceneUser(SimpleOpenNI curContext, int userId)
{
  println("onOutOfSceneUserUser - userId: " + userId);
  trackinguserID=setUserID();
}


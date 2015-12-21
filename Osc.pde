
void sendOSC(int userId) {
  sendJointMsg(headOSC, userId, SimpleOpenNI.SKEL_HEAD);
  sendJointMsg(neckOSC, userId, SimpleOpenNI.SKEL_NECK);
  sendJointMsg(bodyOSC, userId, SimpleOpenNI.SKEL_TORSO);

  if (mirror) {
    sendJointMsg(rshoulderOSC, userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
    sendJointMsg(relbowOSC, userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
    sendJointMsg(rhandOSC, userId, SimpleOpenNI.SKEL_LEFT_HAND);

    sendJointMsg(lshoulderOSC, userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
    sendJointMsg(lelbowOSC, userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
    sendJointMsg(lhandOSC, userId, SimpleOpenNI.SKEL_RIGHT_HAND);

    sendJointMsg(rhipOSC, userId, SimpleOpenNI.SKEL_LEFT_HIP);
    sendJointMsg(rkneeOSC, userId, SimpleOpenNI.SKEL_LEFT_KNEE);
    sendJointMsg(rfootOSC, userId, SimpleOpenNI.SKEL_LEFT_FOOT);

    sendJointMsg(lhipOSC, userId, SimpleOpenNI.SKEL_RIGHT_HIP);
    sendJointMsg(lkneeOSC, userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
    sendJointMsg(lfootOSC, userId, SimpleOpenNI.SKEL_RIGHT_FOOT);
  } else {
    sendJointMsg(lshoulderOSC, userId, SimpleOpenNI.SKEL_LEFT_SHOULDER);
    sendJointMsg(lelbowOSC, userId, SimpleOpenNI.SKEL_LEFT_ELBOW);
    sendJointMsg(lhandOSC, userId, SimpleOpenNI.SKEL_LEFT_HAND);

    sendJointMsg(rshoulderOSC, userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
    sendJointMsg(relbowOSC, userId, SimpleOpenNI.SKEL_RIGHT_ELBOW);
    sendJointMsg(rhandOSC, userId, SimpleOpenNI.SKEL_RIGHT_HAND);

    sendJointMsg(lhipOSC, userId, SimpleOpenNI.SKEL_LEFT_HIP);
    sendJointMsg(lkneeOSC, userId, SimpleOpenNI.SKEL_LEFT_KNEE);
    sendJointMsg(lfootOSC, userId, SimpleOpenNI.SKEL_LEFT_FOOT);

    sendJointMsg(rhipOSC, userId, SimpleOpenNI.SKEL_RIGHT_HIP);
    sendJointMsg(rkneeOSC, userId, SimpleOpenNI.SKEL_RIGHT_KNEE);
    sendJointMsg(rfootOSC, userId, SimpleOpenNI.SKEL_RIGHT_FOOT);
  }
}



void sendJointMsg(String name, int userId, int joint) {
  PVector jointPosition = new PVector();
  kinect.getJointPositionSkeleton(userId, joint, jointPosition);
  jointPosition=depthToWorld(jointPosition.x, jointPosition.y, jointPosition.z);


  OscMessage myMessage = new OscMessage(name);
  myMessage.add(jointPosition.x); 
  myMessage.add(jointPosition.y);
  myMessage.add(jointPosition.z);

  float rotationConfidence; 
  PMatrix3D rotation = new PMatrix3D(); 
  rotationConfidence = kinect.getJointOrientationSkeleton(userId, joint, rotation); 
  if (sendrotation &&rotationConfidence>0.001) {
    Matrix4x4 mrot=new Matrix4x4(rotation.m00, rotation.m01, rotation.m02, rotation.m03, rotation.m10, rotation.m11, rotation.m12, rotation.m13, rotation.m20, rotation.m21, rotation.m22, rotation.m23, rotation.m30, rotation.m31, rotation.m32, rotation.m33);
    Quaternion q = Quaternion.createFromMatrix(mrot);
    if (mirror) {
      myMessage.add(-q.w);
      myMessage.add(-q.x);
    } else {
      myMessage.add(q.w);
      myMessage.add(q.x);
    }
    myMessage.add(q.y);
    myMessage.add(q.z);
  } 
  oscP5.send(myMessage, myRemoteLocation);
}



void oscEvent(OscIn oscIn) 
{
  // here you could process incoming OSC messages
  print(oscIn);
}


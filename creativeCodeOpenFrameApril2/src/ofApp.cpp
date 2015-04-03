#include "ofApp.h"


// here is the documentation:http://sites.bxmc.poly.edu/~nicholaspetrilla/creativecode/?p=34
//--------------------------------------------------------------
void ofApp::setup(){
	
	ofSetVerticalSync(true);
	ofSetCircleResolution(80);
	ofBackground(0, 0, 0);
	
	//video
	myPlayer.loadMovie("movies/guy_compressed.mp4");
	myPlayer.play();
	
	
	// 0 output channels,
	// 2 input channels
	// 44100 samples per second
	// 256 samples per buffer
	// 4 num buffers (latency)
	
	soundStream.listDevices();
	
	//if you want to set a different device id
	//soundStream.setDeviceID(0); //bear in mind the device id corresponds to all audio devices, including  input-only and output-only devices.
	
	int bufferSize = 256;
	
	
	left.assign(bufferSize, 0.0);
	right.assign(bufferSize, 0.0);
	volHistory.assign(400, 0.0);
	
	bufferCounter	= 0;
	drawCounter		= 0;
	smoothedVol     = 0.0;
	scaledVol		= 0.0;
	
	soundStream.setup(this, 0, 2, 44100, bufferSize, 4);
	
}

//--------------------------------------------------------------
void ofApp::update(){
	
	//video
	myPlayer.update(); // get all the new frames
	
	
	//lets scale the vol up to a 0-1 range
	scaledVol = ofMap(smoothedVol, 0.0, 0.17, 0.0, 1.0, true);
	
	//lets record the volume into an array
	volHistory.push_back( scaledVol );
	
	//if we are bigger the the size we want to record - lets drop the oldest value
	if( volHistory.size() >= 400 ){
		volHistory.erase(volHistory.begin(), volHistory.begin()+1);
		
		
	}
}

//--------------------------------------------------------------
void ofApp::draw(){
	
	
	
	//line 1
	ofNoFill();
	ofSetLineWidth(10);
	ofSetColor(25, 255, 135);
	ofBeginShape();
	
	for (unsigned int i = 0; i < left.size(); i++){
		ofVertex(i*4, 100 -left[i]*180.0f);
	}
	ofEndShape(false);

	//line 2
	ofSetColor(245, 58, 135);
	ofSetLineWidth(10);
	ofBeginShape();
	
	for (unsigned int i = 0; i < right.size(); i++){
		ofVertex(i*4, 200 -right[i]*180.0f);
	}
	ofEndShape(false);
	
	//line 3
	ofSetColor(25, 255, 135);
	ofSetLineWidth(10);
	ofBeginShape();
	
	for (unsigned int i = 0; i < left.size(); i++){
		ofVertex(i*4, 300 -left[i]*180.0f);
	}
	ofEndShape(false);
	
	//line 4
	ofSetColor(245, 58, 135);
	ofSetLineWidth(10);
	ofBeginShape();
	
	for (unsigned int i = 0; i < right.size(); i++){
		ofVertex(i*4, 400 -right[i]*180.0f);
	}
	ofEndShape(false);
	
	//line 5
	ofSetColor(25, 255, 135);
	ofSetLineWidth(10);
	ofBeginShape();
	
	for (unsigned int i = 0; i < left.size(); i++){
		ofVertex(i*4, 500 -left[i]*180.0f);
	}
	ofEndShape(false);
	
	//line 6
	ofSetColor(245, 58, 135);
	ofSetLineWidth(10);
	ofBeginShape();
	
	for (unsigned int i = 0; i < right.size(); i++){
		ofVertex(i*4, 600 -right[i]*180.0f);
	}
	ofEndShape(false);

	
	// draw circles of the average volume:

	ofSetColor(245, 58, 135);
	ofFill();
	ofCircle(500, 100, scaledVol * 290.0f);
	
	ofSetColor(245, 58, 135);
	ofFill();
	ofCircle(500, 300, scaledVol * 290.0f);
	
	ofSetColor(245, 58, 135);
	ofFill();
	ofCircle(500, 500, scaledVol * 290.0f);

	ofSetColor(25, 255, 135);
	ofFill();
	ofCircle(200, 200, scaledVol * 290.0f);
	
	ofSetColor(25, 255, 135);
	ofFill();
	ofCircle(200, 400, scaledVol * 290.0f);
	
	ofSetColor(25, 255, 135);
	ofFill();
	ofCircle(200, 600, scaledVol * 290.0f);
	
	ofSetColor(25, 255, 135);
	ofFill();
	ofCircle(800, 200, scaledVol * 290.0f);
	
	ofSetColor(25, 255, 135);
	ofFill();
	ofCircle(800, 400, scaledVol * 290.0f);
	
	ofSetColor(25, 255, 135);
	ofFill();
	ofCircle(800, 600, scaledVol * 290.0f);
	
	
	//video...uncomment if you want video to play on top of visualization
	
	ofSetHexColor(0xFFFFFF);
	
	myPlayer.draw(20,20);

}

//--------------------------------------------------------------
void ofApp::audioIn(float * input, int bufferSize, int nChannels){
	
	float curVol = 0.0;
	
	// samples are "interleaved"
	int numCounted = 0;
	
	//lets go through each sample and calculate the root mean square which is a rough way to calculate volume
	for (int i = 0; i < bufferSize; i++){
		left[i]		= input[i*2]*0.5;
		right[i]	= input[i*2+1]*0.5;
		
		curVol += left[i] * left[i];
		curVol += right[i] * right[i];
		numCounted+=2;
	}
	
	//this is how we get the mean of rms :)
	curVol /= (float)numCounted;
	
	// this is how we get the root of rms :)
	curVol = sqrt( curVol );
	
	smoothedVol *= 0.93;
	smoothedVol += 0.07 * curVol;
	
	bufferCounter++;
	
}

//--------------------------------------------------------------
void ofApp::keyPressed  (int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){
	
}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y ){
	
}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){
	
}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){
	
}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){
	
}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){
	
}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){
	
}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){
	
}


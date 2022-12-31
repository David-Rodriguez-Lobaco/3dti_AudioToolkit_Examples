/**
* \class ofApp
*
* \brief Declaration of example_4_interactive_basic_spatialisation_OF
* \details Example to handle deal with the 3DTI_Toolkit, using Openframeworks.
*
* \authors The author has been Paula García Jiménez. She has been supervised by Arcadio Reyes Lecuona (University of Malaga) with helped from Daniel Gonzalez Toledo.
* \b Contact: paulagarcianm@uma.es
*
* \b Copyright: University of Malaga
*
* \b Licence: This example of 3dti_AudioToolkit is licensed by MIT license.
*
*/

#include "ofApp.h"

int SAMPLERATE;
#define BUFFERSIZE 512
#define OVERS 10  //oversampling
using std::vector;
vector<float> ITD = {};
vector<float> az = {};
float escala = 0;
float mayor = 0;
float P = 0.30; //valor del umbral que se pasa
int FC = 3000; //valor de la frecuencia de corte del filtro

Common::TAudioStateStruct audioState;	    // Audio State struct declaration

template<typename T>  //Mostrar los elementos del vector
void printVectorElements(vector<T> &vec)
{
	for (auto i = 0; i < vec.size(); ++i) {
		cout << vec.at(i) << "; ";
	}
	cout << endl;
}

//--------------------------------------------------------------
void ofApp::setup(){
	
	ofSetVerticalSync(true);
	//Se obtiene la frecuencia del muestreo del archivo que se va a usar
	SAMPLERATE = HRTF::GetSampleRateFromSofa("H5_44K_16bit_256tap_FIR_SOFA.sofa");
	//SAMPLERATE = HRTF::GetSampleRateFromSofa("H3_44K_16bit_256tap_FIR_SOFA.sofa");
	//SAMPLERATE = HRTF::GetSampleRateFromSofa("ARI_NH2_hrtf_M_dtf 256.sofa");

	//Inicialización de las variables de la interfaz
	refreshButton.addListener(this, &ofApp::refreshButtonPressed);
	gui.setup(); // most of the time you don't need a name
	gui.add(azimut.setup("azimut", 0, 0, 359));
	center.setup("center", { ofGetWidth()*.5, ofGetHeight()*.5 }, { 0, 0 }, { ofGetWidth(), ofGetHeight() });
	quarter.setup("quarter", { ofGetWidth()*.5, ofGetHeight()*.28 }, { 0, 0 }, { ofGetWidth(), ofGetHeight() });
	threequarter.setup("threequarter", { ofGetWidth()*.5, ofGetHeight()*.66 }, { 0, 0 }, { ofGetWidth(), ofGetHeight() });
	//gui.add(color.setup("color", ofColor(100, 100, 140), ofColor(0, 0), ofColor(255, 255)));
	gui.add(color.setup("color", ofColor(0, 0, 0), ofColor(0, 0), ofColor(255, 255)));
	gui.add(color2.setup("color", ofColor(200, 0, 140), ofColor(0, 0), ofColor(255, 255)));
	gui.add(screenSize.setup("screen size", ofToString(ofGetWidth()) + "x" + ofToString(ofGetHeight())));
	gui.add(leyend.setup("UpView", ""));
	gui.add(Umbral.setup("Umbral", 0.3, 0.1, 0.7));
	gui.add(FrecCorte.setup("Frecuencia corte KHz", 3, 1, 10));
	gui.add(refreshButton.setup("Refresh"));

	// Core setup
	audioState.bufferSize = BUFFERSIZE;			// Setting buffer size 
	audioState.sampleRate = SAMPLERATE;			// Setting frame rate 
	myCore.SetAudioState(audioState);		    // Applying configuration to core
	myCore.SetHRTFResamplingStep(15);		    // Setting 15-degree resampling step for HRTF

	ERRORHANDLER3DTI.SetVerbosityMode(VERBOSITYMODE_ERRORSANDWARNINGS);
	ERRORHANDLER3DTI.SetErrorLogStream(&std::cout, true);


	// Inicialización del oyente
	listener = myCore.CreateListener();								 // First step is creating listener
	Common::CTransform listenerPosition = Common::CTransform();		 // Setting listener in (0,0,0)
	listenerPosition.SetPosition(Common::CVector3(ofGetWidth()*.5, ofGetHeight()*.28, 0));
	listener->SetListenerTransform(listenerPosition);
	listener->DisableCustomizedITD();								 // Disabling custom head radius

	// HRTF can be loaded in SOFA (more info in https://sofacoustics.org/) Some examples of HRTF files can be found in 3dti_AudioToolkit/resources/HRTF
	bool specifiedDelays;
	//bool sofaLoadResult = HRTF::CreateFromSofa("hrtf.sofa", listener, specifiedDelays);	
	bool sofaLoadResult = HRTF::CreateFromSofa("H5_44K_16bit_256tap_FIR_SOFA.sofa", listener, specifiedDelays);
	//bool sofaLoadResult = HRTF::CreateFromSofa("H3_44K_16bit_256tap_FIR_SOFA.sofa", listener, specifiedDelays);
	//bool sofaLoadResult = HRTF::CreateFromSofa("H3_48K_24bit_256tap_FIR_SOFA_0_151.sofa", listener, specifiedDelays); 
	//bool sofaLoadResult = HRTF::CreateFromSofa("D1_96K_24bit_512tap_FIR_SOFA.sofa", listener, specifiedDelays);
	//bool sofaLoadResult = HRTF::CreateFromSofa("ARI_NH2_hrtf_M_dtf 256.sofa", listener, specifiedDelays);

	if (!sofaLoadResult) {
		cout << "ERROR: Error trying to load the SOFA file" << endl << endl;
	}

	// Iicializacion de la fuente sonora
	source1DSP = myCore.CreateSingleSourceDSP();									// Creating audio source
	LoadWavFile(source1Wav, "speech_female.wav");											// Loading .wav file										   
	Common::CTransform source1Position = Common::CTransform();
	source1Position.SetPosition(Common::CVector3(ofGetWidth()*.5, ofGetHeight()*.28, 0));							//Set source position on the listener left side				 
	source1DSP->SetSourceTransform(source1Position);
	source1DSP->SetSpatializationMode(Binaural::TSpatializationMode::HighQuality);	// Choosing high quality mode for anechoic processing
	source1DSP->DisableNearFieldEffect();											// Audio source will not be close to listener, so we don't need near field effect
	source1DSP->EnableAnechoicProcess();											// Enable anechoic processing for this source
	source1DSP->DisableDistanceAttenuationAnechoic();								// Do not perform distance simulation

	T_HRTFTable hrtf_table = listener->GetHRTF()->GetRawHRTFTable();

	myCore.SetAudioState(audioState);
	LoadITDGraphic(hrtf_table);
	//AudioDevice Setup
	// Before getting the devices list for the second time, the strean must be closed. Otherwise,
	// the app crashes when systemSoundStream.start(); or stop() are called.
	systemSoundStream.close();
	SetDeviceAndAudio(audioState);

}

//--------------------------------------------------------------
void ofApp::update(){
	////Obtaining the actual source information
	Common::CTransform listenerTransform = listener->GetListenerTransform();		//Obtaining an object of the Transform class
	Common::CVector3 position = listenerTransform.GetPosition();					//Obtaining an object of the Vector class
	Common::CQuaternion orientation = listenerTransform.GetOrientation();			//Obtaining an object of the Vector class

	Common::CTransform sourceTransform1 = source1DSP->GetSourceTransform();		//Obtaining an object of the Transform class
	Common::CVector3 source1Position = sourceTransform1.GetPosition();			//Obtaining an object of the Vector class

	//Move the object to the new coordinate 
	sourceTransform1.SetPosition(Common::CVector3(position.x + 1.5 * cos(azimut*PI / 180), position.y - 1.5 * -sin(azimut*PI / 180), position.z));
	source1DSP->SetSourceTransform(sourceTransform1);
}

//--------------------------------------------------------------
void ofApp::draw(){
	//Preparing the background
	//ofBackground(ofColor::black);
	ofBackground(ofColor::gray);
	//ofBackgroundGradient(ofColor::white, ofColor::gray);

	//Preparing the enviroment
	ofPushMatrix();																//Saving the current coordinate system			
	ofNoFill();																	//Function for drawing shapes as outlines															//90º Rotation
	ofScale(1, 1, 1);

	//Obtaining the actual listener information
	Common::CTransform listenerTransform = listener->GetListenerTransform();	//Obtaining an object of the Transform class
	Common::CVector3 position = listenerTransform.GetPosition();				//Obtaining an object of the Vector class
	Common::CQuaternion orientation = listenerTransform.GetOrientation();		//Obtaining an object of the Quaternion class

	//Getting the Quaternion angles
	float yaw, pitch, roll;														//Initializing the angles
	orientation.ToYawPitchRoll(yaw, pitch, roll);								//Obtaning the angles of the sources
	yaw = yaw * 180 / PI;															//Conversion radians to degrees
	int radio = 25;																//Initializing a radius for the listener circle


	//Changing the coordinate system to have the center (0,0,0) in the center of the head
	ofPushMatrix();																//Saving the current coordinate system
	ofTranslate(position.x, position.y, 0);										//Translation to the head center

	ofPopMatrix();																//Restoring the pior coordinate system

	////Obtaining the actual source information
	Common::CTransform sourceTransform1 = source1DSP->GetSourceTransform();		//Obtaining an object of the Transform class
	Common::CVector3 source1Position = sourceTransform1.GetPosition();			//Obtaining an object of the Vector class


	ofSetCircleResolution(10000);
	ofSetColor(color2);
	ofFill();//Setting the color of the shapes

	ofDrawCircle(position.x + 100 * -sin(azimut*PI / 180), position.y - 100 * cos(azimut*PI / 180), 8);						//Drawing the source 1


	ofSetColor(color);

	ofFill();
	ofSetCircleResolution(3);
	ofDrawTriangle(quarter->x, quarter->y - 35, quarter->x - 20, quarter->y, quarter->x + 20, quarter->y);


	ofSetCircleResolution(10000);
	ofDrawCircle(quarter, 25); //cabeza
	ofDrawCircle(quarter->x + 23, quarter->y, 8); //orejas
	ofDrawCircle(quarter->x - 23, quarter->y, 8);
	ofNoFill();
	ofDrawCircle(quarter, 100);


	ofSetColor(color2);

	ofFill();

	ofSetColor(175, 255, 0);
	ofDrawLine(threequarter->x - 180, threequarter->y - 100, threequarter->x - 180, threequarter->y + 100); //barra vertival
	ofDrawLine(threequarter->x - 181, threequarter->y - 100, threequarter->x - 181, threequarter->y + 100);
	ofDrawLine(threequarter->x - 182, threequarter->y - 100, threequarter->x - 182, threequarter->y + 100);
	ofDrawLine(threequarter->x - 180, threequarter->y, threequarter->x + 180, threequarter->y);			  //barra horizontal

	ofSetColor(color2);
	//Point moveTo(threequarter->x+az[0], threequarter->y+ITD[0]);
	for (int g = 1; g < ITD.size(); g++)
	{
		ofDrawLine(threequarter->x + az[g - 1] - 180, threequarter->y - ITD[g - 1] * escala, threequarter->x + az[g] - 180, threequarter->y - ITD[g] * escala);
	}

	ofSetColor(0, 0, 200);
	ofDrawLine(threequarter->x - 180 + azimut, threequarter->y - 100, threequarter->x - 180 + azimut, threequarter->y + 100);

	gui.draw();
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
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

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

/// Read de audio the list of devices of the user computer, allowing the user to select which device to use. Configure the Audio using openFramework
void ofApp::SetDeviceAndAudio(Common::TAudioStateStruct audioState) {
	// This call could block the app when the motu audio interface is unplugged
	// It gives the message: 
	// RtApiAsio::getDeviceInfo: error (Hardware input or output is not present or available).
	// initializing driver (Focusrite USB 2.0 Audio Driver).
	deviceList = systemSoundStream.getDeviceList();


	for (int c = deviceList.size() - 1; c >= 0; c--)
	{
		if (deviceList[c].outputChannels == 0)
			deviceList.erase(deviceList.begin() + c);
	}

	//Show list of devices and return the one selected by the user
	int deviceId = GetAudioDeviceIndex(deviceList);

	if (deviceId >= 0)
	{
		systemSoundStream.setDevice(deviceList[deviceId]);

		ofSoundDevice &dev = deviceList[deviceId];

		//Setup Aduio
		systemSoundStream.setup(this,		// Pointer to ofApp so that audioOut is called									  
			2,								//dev.outputChannels, // Number of output channels reported
			0,								// Number of input channels
			audioState.sampleRate,			// sample rate, e.g. 44100 
			audioState.bufferSize,			// Buffer size, e.g. 512
			4   // -> Is the number of buffers that your system will create and swap out.The more buffers, 
			   // the faster your computer will write information into the buffer, but the more memory it 
			  // will take up.You should probably use two for each channel that you’re using.Here’s an 
			 // example call : ofSoundStreamSetup(2, 0, 44100, 256, 4);
			//     http://openframeworks.cc/documentation/sound/ofSoundStream/
		);
		cout << "Device selected : " << "ID: " << dev.deviceID << "  Name: " << dev.name << endl;

	}
	else
	{
		cout << "Could not find any usable sound Device" << endl;
	}
}

/// Ask the user to select the audio device to be used and return the index of the selected device
int ofApp::GetAudioDeviceIndex(std::vector<ofSoundDevice> list)
{
	//Show in the console the Audio device list
	int numberOfAudioDevices = list.size(); 
	cout << "     List of available audio outputs" << endl;
	cout << "----------------------------------------" << endl;
	for (int i = 0; i < numberOfAudioDevices; i++) {
		cout << "ID: " << i << "-" << list[i].name << endl;
	}
	int selectedAudioDevice;

	do {
		cout << "Please choose which audio output you wish to use: ";
		cin >> selectedAudioDevice;
		cin.clear();
		cin.ignore(INT_MAX, '\n');
	} while (!(selectedAudioDevice > -1 && selectedAudioDevice <= numberOfAudioDevices));

	// First, we try to retrieve the <Conf.audioInterfaceIndex> th suitable device in the list:
	for (int c = 0; c < numberOfAudioDevices; c++)
	{
		ofSoundDevice &dev = list[c];

		if ((dev.outputChannels >= 0) && c == selectedAudioDevice)
			return c;
	}

	// Otherwise, we try to get the defult device
	for (int c = 0; c < numberOfAudioDevices; c++)
	{
		ofSoundDevice &dev = list[c];

		// dev.isDefaultOutput is not really the same that windows report
		// TODO: update to latest openFrameworks that really can report all drivers present
		// via ofSoundStream::getDevicesByApi 
		//if ((dev.outputChannels >= NUMBER_OF_SPEAKERS) && dev.isDefaultOutput)
		if ((dev.outputChannels >= 0) && dev.isDefaultOutput)
			return c;
	}
	return -1;
}


/// Audio output management by openFramework
void ofApp::audioOut(float * output, int bufferSize, int nChannels) {

	// The requested frame size is not allways supported by the audio driver:
	if (myCore.GetAudioState().bufferSize != bufferSize)
		return;

	// Prepare output chunk
	Common::CEarPair<CMonoBuffer<float>> bOutput;
	bOutput.left.resize(bufferSize);
	bOutput.right.resize(bufferSize);
	
	// Process audio
	audioProcess(bOutput, bufferSize);
	// Build float array from output buffer
	int i = 0;
	CStereoBuffer<float> iOutput;
	iOutput.Interlace(bOutput.left, bOutput.right);
	for (auto it = iOutput.begin(); it != iOutput.end(); it++)
	{
		float s = *it;
		output[i++] = s;
	}
}

/// Process audio using the 3DTI Toolkit methods
void ofApp::audioProcess(Common::CEarPair<CMonoBuffer<float>> & bufferOutput, int uiBufferSize)
{
	// Declaration, initialization and filling mono buffers
	CMonoBuffer<float> source1(uiBufferSize);
	source1Wav.FillBuffer(source1);
	//CMonoBuffer<float> source2(uiBufferSize);
	//source2Wav.FillBuffer(source2);

	// Declaration of stereo buffer
	Common::CEarPair<CMonoBuffer<float>> bufferProcessed;
	// Anechoic process of first source
	source1DSP->SetBuffer(source1);
	source1DSP->ProcessAnechoic(bufferProcessed.left, bufferProcessed.right);
	// Adding anechoic processed first source to the output mix
	bufferOutput.left += bufferProcessed.left;
	bufferOutput.right += bufferProcessed.right;
	// Anechoic process of second source
	//source2DSP->SetBuffer(source2);
	//source2DSP->ProcessAnechoic(bufferProcessed.left, bufferProcessed.right);
	// Adding anechoic processed second source to the output mix
	//bufferOutput.left += bufferProcessed.left;
	//bufferOutput.right += bufferProcessed.right;
}



void ofApp::LoadWavFile(SoundSource & source, const char* filePath)
{	
	if (!source.LoadWav(filePath)) {
		cout << "ERROR: file " << filePath << " doesn't exist." << endl<<endl;
	}
}


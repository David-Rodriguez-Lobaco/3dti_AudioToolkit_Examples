#include "ofApp.h"

#define SAMPLERATE 44100
#define BUFFERSIZE 512

//--------------------------------------------------------------
void ofApp::setup(){
	
	// Core setup
	Common::TAudioStateStruct audioState;	    // Audio State struct declaration
	audioState.bufferSize = BUFFERSIZE;			// Setting buffer size 
	audioState.sampleRate = SAMPLERATE;			// Setting frame rate 
	myCore.SetAudioState(audioState);		    // Applying configuration to core
	myCore.SetHRTFResamplingStep(15);		    // Setting 15-degree resampling step for HRTF


	// Listener setup
	listener = myCore.CreateListener();								 // First step is creating listener
	Common::CTransform listenerPosition = Common::CTransform();		 // Setting listener in (0,0,0)
	listenerPosition.SetPosition(Common::CVector3(0, 0, 0));
	listener->SetListenerTransform(listenerPosition);
	listener->DisableCustomizedITD();								 // Disabling custom head radius

	/* HRTF can be loaded in either SOFA (more info in https://sofacoustics.org/) or 3dti-hrtf format.
	These HRTF files are provided with 3DTI Audio Toolkit. They can be found in 3dti_AudioToolkit/resources/HRTF */
	bool specifiedDelays;
	bool sofaLoadResult = HRTF::CreateFromSofa("hrtf.sofa", listener, specifiedDelays);			// Comment this line and uncomment next lines to load the default HRTF in 3dti-hrtf format instead of in SOFA format
	
	if (!sofaLoadResult) { 
		cout << "ERROR: Error trying to load the SOFA file" << endl<<endl;
	}																			
	//HRTF::CreateFrom3dti("hrtf.3dti-hrtf", listener);		

	// Source 1 setup
	source1DSP = myCore.CreateSingleSourceDSP();	// Creating audio source
	LoadWavFile(source1Wav, "speech.wav");			// Loading .wav file										   // Loading .wav file
	Common::CTransform source1Position = Common::CTransform();
	source1Position.SetPosition(Common::CVector3(0, 2, 0));						 
	source1DSP->SetSourceTransform(source1Position);
	source1DSP->SetSpatializationMode(Binaural::TSpatializationMode::HighQuality);		 // Choosing high quality mode for anechoic processing
	source1DSP->DisableNearFieldEffect();												 // Audio source will not be close to listener, so we don't need near field effect
	source1DSP->EnableAnechoicProcess();												   // Setting anechoic and reverb processing for this source
	source1DSP->EnableDistanceAttenuationAnechoic();

	// Source 2 setup
	source2DSP = myCore.CreateSingleSourceDSP();	// Creating audio source
	LoadWavFile(source2Wav, "steps.wav");			// Loading .wav file										   // Loading .wav file
	Common::CTransform source2Position = Common::CTransform();
	source2Position.SetPosition(Common::CVector3(0, -2, 0));						
	source2DSP->SetSourceTransform(source2Position);
	source2DSP->SetSpatializationMode(Binaural::TSpatializationMode::HighQuality);		 // Choosing high quality mode for anechoic processing
	source2DSP->DisableNearFieldEffect();												 // Audio source will not be close to listener, so we don't need near field effect
	source2DSP->EnableAnechoicProcess();												   // Setting anechoic and reverb processing for this source
	source2DSP->EnableDistanceAttenuationAnechoic();

	//AudioDevice Setup
	//// Before getting the devices list for the second time, the strean must be closed. Otherwise,
	//// the app crashes when systemSoundStream.start(); or stop() are called.
	systemSoundStream.close();
	SetAudioDevice(audioState);

}

//--------------------------------------------------------------
void ofApp::update(){
	//CMonoBuffer<float> speechInput(BUFFERSIZE);
	//source1.FillBuffer(speechInput);

	/*cout << endl;
	for (int i = 0; i < speechInput.size(); i++) {
		cout << speechInput[i] << " ,";
	}
	cout << endl;*/
}

//--------------------------------------------------------------
void ofApp::draw(){

}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

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

int ofApp::GetAudioDeviceIndex(std::vector<ofSoundDevice> list)
{
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

void ofApp::SetAudioDevice(Common::TAudioStateStruct audioState) {
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

	////Show list of devices
	//string devicesMessage = "\nList of devices availables: \n\n";
	//for (auto dev : deviceList) { devicesMessage = devicesMessage + ("ID: " + std::to_string(dev.deviceID) + " Name: " + dev.name + "\n"); }
	//ofLogVerbose() << devicesMessage << "\n";

	int deviceId = GetAudioDeviceIndex(deviceList);

	if (deviceId >= 0)
	{
		systemSoundStream.setDevice(deviceList[deviceId]);

		ofSoundDevice &dev = deviceList[deviceId];

		//if (dev.sampleRates.size() == 0)
		//	cout << "Please, select an active audio interface in the setting section"<<endl;
		//// Warn if sampleRate is not supported by default device. 
		//else if (std::find(dev.sampleRates.begin(), dev.sampleRates.end(), Conf.sampleRate) == dev.sampleRates.end())
		//	cout<< "Sample rate of " + ofToString(Conf.sampleRate) + "apparently not supported by default\n\noutput device " + dev.name<<endl;

		systemSoundStream.setup(this,  // Pointer to ofApp so that audioOut is called
									   //dev.outputChannels, // Number of output channels reported
			2,
			// BIG FIX ME: make app actually use this number (everywhere is supposedly 2). 
			0,    // Number of input channels
			audioState.sampleRate, // sample rate, e.g. 44100 
			audioState.bufferSize, // Buffer size, e.g. 512
			4   // -> Is the number of buffers that your system will create and swap out.The more buffers, 
			   // the faster your computer will write information into the buffer, but the more memory it 
			  // will take up.You should probably use two for each channel that you�re using.Here�s an 
			 // example call : ofSoundStreamSetup(2, 0, 44100, 256, 4);
			//     http://openframeworks.cc/documentation/sound/ofSoundStream/
		);
		cout << "Device selected : " << "ID: " << dev.deviceID << "  Name: " << dev.name << endl;

		//systemSoundStream_Started = true;
	}
	else
	{
		//dialog.Launch_OkMessage(DIALOGS_TITLE, "Could not find any usable sound Device.\n\nPlease select the appropiate one in the settings section.");
		//systemSoundStream_Started = false;
	}
}

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
void ofApp::audioProcess(Common::CEarPair<CMonoBuffer<float>> & bufferOutput, int uiBufferSize)
{
	// Declaration, initialization and filling mono buffers
	CMonoBuffer<float> source1(uiBufferSize);
	source1Wav.FillBuffer(source1);
	CMonoBuffer<float> source2(uiBufferSize);
	source2Wav.FillBuffer(source2);

	// Declaration of stereo buffer
	Common::CEarPair<CMonoBuffer<float>> bufferProcessed;
	// Anechoic process of first source
	source1DSP->SetBuffer(source1);
	source1DSP->ProcessAnechoic(bufferProcessed.left, bufferProcessed.right);
	// Adding anechoic processed speech source to the output mix
	bufferOutput.left += bufferProcessed.left;
	bufferOutput.right += bufferProcessed.right;
	// Anechoic process of second source
	source2DSP->SetBuffer(source2);
	source2DSP->ProcessAnechoic(bufferProcessed.left, bufferProcessed.right);
	// Adding anechoic processed steps source to the output mix
	bufferOutput.left += bufferProcessed.left;
	bufferOutput.right += bufferProcessed.right;
}



void ofApp::LoadWavFile(SoundSource & source, const char* filePath)
{	
	if (!source.LoadWav(filePath)) {
		cout << "ERROR: file " << filePath << " doesn't exist." << endl<<endl;
	}
}

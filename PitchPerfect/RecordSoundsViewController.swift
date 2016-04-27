//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Raghav Mangrola on 4/23/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController , AVAudioRecorderDelegate {
  
  @IBOutlet weak var recordingLabel: UILabel!
  @IBOutlet weak var recordButton: UIButton!
  @IBOutlet weak var stopRecordingButton: UIButton!
  
  var audioRecorder:AVAudioRecorder!
  
  override func viewWillAppear(animated: Bool) {
    stopRecordingButton.enabled = false
  }
  
  @IBAction func recordAudio(sender: AnyObject) {
    configureUI(recording: true)
    
    let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask, true)[0] as String
    let recordingName = "recordedVoice.wav"
    let pathArray = [dirPath, recordingName]
    let filePath = NSURL.fileURLWithPathComponents(pathArray)
    
    let session = AVAudioSession.sharedInstance()
    try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, withOptions: AVAudioSessionCategoryOptions.DefaultToSpeaker)
    
    try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
    audioRecorder.delegate = self
    audioRecorder.meteringEnabled = true
    audioRecorder.prepareToRecord()
    audioRecorder.record()
  }

  @IBAction func stopRecording(sender: UIButton) {
    configureUI(recording: false)
    
    audioRecorder.stop()
    let audioSession = AVAudioSession.sharedInstance()
    try! audioSession.setActive(false)
  }
  
  func configureUI(recording recording: Bool) {
    recordButton.enabled = recording ? false : true
    stopRecordingButton.enabled = recording ? true : false
    recordingLabel.text = recording ? "Recording in Progress" : "Tap to record"
  }
  
  func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
    
    if (flag) {
      self.performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
    } else {
      print("Saving of recording failed")
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if (segue.identifier == "stopRecording") {
      let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
      let recordedAudioURL = sender as! NSURL
      playSoundsVC.recordedAudioURL = recordedAudioURL
    }
  }
}


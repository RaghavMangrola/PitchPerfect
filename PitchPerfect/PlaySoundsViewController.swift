//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Raghav Mangrola on 4/25/16.
//  Copyright © 2016 Raghav Mangrola. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
  
  @IBOutlet weak var snailButton: UIButton!
  @IBOutlet weak var chipmunkButton: UIButton!
  @IBOutlet weak var rabbitButton: UIButton!
  @IBOutlet weak var vaderButton: UIButton!
  @IBOutlet weak var echoButton: UIButton!
  @IBOutlet weak var reverbButton: UIButton!
  @IBOutlet weak var stopButton: UIButton!
  @IBOutlet weak var audioDurationLabel: UILabel!
  @IBOutlet var buttons: [UIButton]!
 
  
  var recordedAudioURL: NSURL!
  var audioFile: AVAudioFile!
  var audioEngine: AVAudioEngine!
  var audioPlayerNode: AVAudioPlayerNode!
  var stopTimer: NSTimer!
  var audioPlayer: AVAudioPlayer!
  
  enum ButtonType: Int { case Slow = 0, Fast, Chipmunk, Vader, Echo, Reverb }
  
  @IBAction func playSoundForButton(sender: UIButton) {
    switch(ButtonType(rawValue: sender.tag)!) {
    case .Slow:
      playSound(rate: 0.5)
    case .Fast:
      playSound(rate: 1.5)
    case .Chipmunk:
      playSound(pitch: 1000)
    case .Vader:
      playSound(pitch: -1000)
    case .Echo:
      playSound(echo: true)
    case .Reverb:
      playSound(reverb: true)
    }
    
    configureUI(.Playing)
  }
  
  @IBAction func stopButtonPressed(sender: UIButton) {
    stopAudio()
    stopTimer.invalidate()
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAudio()
    setContentMode()
    
  }
  
  override func viewWillAppear(animated: Bool) {
    configureUI(.NotPlaying)
  }
  

  override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
  }
  
  func setContentMode() {
    for button in buttons {
      button.imageView!.contentMode = .ScaleAspectFit
    }
  }

}

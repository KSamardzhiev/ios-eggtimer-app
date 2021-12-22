//
//  ViewController.swift
//  EggTimer
//
//  Created by Kostadin Samardzhiev on 22.12.21.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var softEggImageView: UIImageView!
    @IBOutlet weak var mediumEggImageView: UIImageView!
    @IBOutlet weak var hardEggImageView: UIImageView!
    
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var progressView: UIProgressView!
    var timer:Timer?
    var totalTime:Int = 0
    var totalTimeSelected:Int = 0
    let totalTimeSoftEgg = 180
    let totalTimeMediumEgg = 300
    let totalTimeHardEgg = 420
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.totalTime = totalTimeSoftEgg
        self.totalTimeSelected = totalTimeSoftEgg
    }

    @IBAction func eggSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            self.totalTime = totalTimeSoftEgg
            self.totalTimeSelected = totalTimeSoftEgg
            self.timerLabel.text = self.timeFormatted(self.totalTime)
            self.softEggImageView.alpha = 1
            self.mediumEggImageView.alpha = 0.5
            self.hardEggImageView.alpha = 0.5
        } else if sender.selectedSegmentIndex == 1 {
            self.totalTime = totalTimeMediumEgg
            self.totalTimeSelected = totalTimeMediumEgg
            self.timerLabel.text = self.timeFormatted(self.totalTime)
            self.softEggImageView.alpha = 0.5
            self.mediumEggImageView.alpha = 1
            self.hardEggImageView.alpha = 0.5
        } else if sender.selectedSegmentIndex == 2 {
            self.totalTime = totalTimeHardEgg
            self.totalTimeSelected = totalTimeHardEgg
            self.timerLabel.text = self.timeFormatted(self.totalTime)
            self.softEggImageView.alpha = 0.5
            self.mediumEggImageView.alpha = 0.5
            self.hardEggImageView.alpha = 1
        }
    }
    
    @IBAction func startStopButtonPressed(_ sender: UIButton) {
        if sender.titleLabel?.text == "Start" {
            self.startStopButton.setTitle("Stop", for: .normal)
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        } else if sender.titleLabel?.text == "Stop" {
            self.startStopButton.setTitle("Start", for: .normal)
            self.timer?.invalidate()
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc func updateTimer() {
        self.timerLabel.text = self.timeFormatted(self.totalTime)
        if totalTime != 0 {
            totalTime -= 1
            progressView.progress = Float(totalTimeSelected - totalTime) / Float(totalTimeSelected)
            print(progressView.progress)
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            }
        }
    }
    
}


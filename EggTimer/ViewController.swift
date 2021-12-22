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
    let totalTimeSoftEgg = 5 * 60
    let totalTimeMediumEgg = 7 * 60
    let totalTimeHardEgg = 12 * 60

    override func viewDidLoad() {
        super.viewDidLoad()
        self.totalTime = totalTimeSoftEgg
        self.totalTimeSelected = totalTimeSoftEgg
    }

    @IBAction func eggSegment(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.prepareUIBasedOnSegment(hardness: totalTimeSoftEgg)
            self.softEggImageView.alpha = 1
            self.mediumEggImageView.alpha = 0.5
            self.hardEggImageView.alpha = 0.5
        case 1:
            self.prepareUIBasedOnSegment(hardness: totalTimeMediumEgg)
            self.softEggImageView.alpha = 0.5
            self.mediumEggImageView.alpha = 1
            self.hardEggImageView.alpha = 0.5
        case 2:
            self.prepareUIBasedOnSegment(hardness: totalTimeHardEgg)
            self.softEggImageView.alpha = 0.5
            self.mediumEggImageView.alpha = 0.5
            self.hardEggImageView.alpha = 1
        default:
            print("Not available option!")
        }
    }
    
    func prepareUIBasedOnSegment(hardness:Int) {
        self.totalTime = hardness
        self.totalTimeSelected = hardness
        self.timerLabel.text = self.timeFormatted(self.totalTime)
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
        return String(format: "%02d:%02d min", minutes, seconds)
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


//
//  ViewController.swift
//  SliderAVPlayer
//
//  Created by Togami Yuki on 2019/01/08.
//  Copyright © 2019 Togami Yuki. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var playSlider: UISlider!
    @IBOutlet weak var playBtn: UIButton!
    
    //var player:AVPlayer?
    //var playerItem:AVPlayerItem?
    
    var player2:AVAudioPlayer!
    
    var currentTimer:Float = 0
    
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //再生する音楽
        let url = URL(string: "https://s3.amazonaws.com/kargopolov/kukushka.mp3")
        //let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        //player = AVPlayer(playerItem: playerItem)
        do {
            try player2 = AVAudioPlayer(contentsOf: url!)
            playSlider.maximumValue = Float(player2.duration)
        }catch{
            
        }
        
        //スライダー
        playSlider.minimumValue = 0
        playSlider.value = 0
        playSlider.isContinuous = false
        
        //音楽の秒数
        //let duration : CMTime = playerItem.asset.duration
        //let seconds : Float64 = CMTimeGetSeconds(duration)
        //print("memo:音楽の秒数",seconds)
    }

    //音楽再生ボタン
    @IBAction func playMusic(_ sender: UIButton) {
        
        if player2?.rate == 0{
            player2!.play()
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.timerUpdate), userInfo: nil, repeats: true)
        }else{
            player2!.pause()
            self.timer!.invalidate()
        }
    }
    
    @IBAction func timeSlider(_ sender: UISlider) {
        print("memo:",sender.value)
        //self.timer!.invalidate()
        player2!.currentTime = TimeInterval(sender.value)
        
    }
    
    @objc func timerUpdate(){
        print("memo:currentTimer",currentTimer)
        currentTimer = Float((player2?.currentTime)!)
        playSlider.value = currentTimer
    }
}


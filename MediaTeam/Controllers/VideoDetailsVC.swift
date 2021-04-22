//
//  VideoDetailsVC.swift
//  MediaTeam
//
//  Created by Abdur Rauf on 21/04/2021.
//  Copyright © 2021 Abdur Rauf. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer

class VideoDetailsVC: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var dismissView: UIView!
    @IBOutlet weak var progressView: DesignableView!
    @IBOutlet weak var videoView: UIView!
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer!
    var array = [String]()
    var video = ""
    let playerViewController = AVPlayerViewController()
    var count = 0
    var count1 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        addVideo()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        // Do any additional setup after loading the view.
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        playerLayer?.frame = view.bounds
    }
    @objc func playerItemDidReachEnd(notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
            player.play()
        }
    }
    func addVideo(){
        guard let path = Bundle.main.path(forResource: video, ofType:"mp4") else {
            debugPrint("video.m4v not found")
            return
        }
        playerViewController.view.frame = self.view.frame
        playerViewController.view.sizeToFit()
        playerViewController.showsPlaybackControls = true
        self.view.addSubview(playerViewController.view)
        playerViewController.view.frame = view.bounds
        self.player = AVPlayer(url: URL(fileURLWithPath: path))
        playerViewController.player = player
        playerViewController.player?.play()
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
    @objc func handleSwipes(_ sender: UISwipeGestureRecognizer)
    {
        if sender.direction == .left
        {
            count1 += 1
            if count1 >= array.count{
                count1 = array.count - 1
                return
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.view.alpha = 0
            }, completion: { _ in
                guard let path = Bundle.main.path(forResource: self.array[self.count1], ofType:"mp4") else {
                    debugPrint("video.m4v not found")
                    return
                }
                self.player.pause()
                self.player = nil
                self.playerViewController.view.frame = self.view.frame
                self.playerViewController.view.sizeToFit()
                self.playerViewController.showsPlaybackControls = true
                self.view.addSubview(self.playerViewController.view)
                self.player = AVPlayer(url: URL(fileURLWithPath: path))
                self.playerViewController.player = self.player
                self.playerViewController.player?.play()
                NotificationCenter.default.addObserver(self,
                                                       selector: #selector(self.playerItemDidReachEnd(notification:)),
                                                       name: .AVPlayerItemDidPlayToEndTime,
                                                       object: self.player.currentItem)
                
                UIView.animate(withDuration: 0.5) {
                    self.view.alpha = 1
                }
            })
            
            print("Swipe left")
            
        }
        if sender.direction == .right
        {
            count1 -= 1
            if count1 < 0{
                count1 = 0
                return
                // show the view from the left side
            }else if count1 == 0{
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.alpha = 0
                }, completion: { _ in
                    guard let path = Bundle.main.path(forResource: self.video, ofType:"mp4") else {
                        debugPrint("video.m4v not found")
                        return
                    }
                    
                    self.player.pause()
                    self.player = nil
                    self.playerViewController.view.frame = self.view.frame
                    self.playerViewController.view.sizeToFit()
                    self.playerViewController.showsPlaybackControls = true
                    self.view.addSubview(self.playerViewController.view)
                    self.player = AVPlayer(url: URL(fileURLWithPath: path))
                    self.playerViewController.player = self.player
                    self.playerViewController.player?.play()
                    NotificationCenter.default.addObserver(self,
                                                           selector: #selector(self.playerItemDidReachEnd(notification:)),
                                                           name: .AVPlayerItemDidPlayToEndTime,
                                                           object: self.player.currentItem)
                    
                    UIView.animate(withDuration: 0.5) {
                        self.view.alpha = 1
                    }
                })
            }
            else{
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.alpha = 0
                }, completion: { _ in
                    guard let path = Bundle.main.path(forResource: self.array[self.count1], ofType:"mp4") else {
                        debugPrint("video.m4v not found")
                        return
                    }
                    
                    self.player.pause()
                    self.player = nil
                    self.playerViewController.view.frame = self.view.frame
                    self.playerViewController.view.sizeToFit()
                    self.playerViewController.showsPlaybackControls = true
                    self.view.addSubview(self.playerViewController.view)
                    self.player = AVPlayer(url: URL(fileURLWithPath: path))
                    self.playerViewController.player = self.player
                    self.playerViewController.player?.play()
                    NotificationCenter.default.addObserver(self,
                                                           selector: #selector(self.playerItemDidReachEnd(notification:)),
                                                           name: .AVPlayerItemDidPlayToEndTime,
                                                           object: self.player.currentItem)
                    
                    UIView.animate(withDuration: 0.5) {
                        self.view.alpha = 1
                    }
                })
            }
        }
    }
    
    
}


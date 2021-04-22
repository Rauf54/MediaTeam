//
//  HomeVC.swift
//  MediaTeam
//
//  Created by Abdur Rauf on 21/04/2021.
//  Copyright © 2021 Abdur Rauf. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class HomeVC: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    let playerViewController = AVPlayerViewController()
    var imgArray = ["This Week","Camera 1","Camera 2","Camera 3","Camera 4","Camera 5","Camera 6","Camera 7"]
    var cam1 = ["Cam 1 Speaker", "Cam 1 Worship"]
    var cam2 = ["Cam 2 #8 Zoom Out Left", "Cam 2 #2 Zoom in Left","Cam 2 #3 Zoom In Right","Cam 2 #4 Zoom In Down","Cam 2 #6 Zoom Out","Cam 2 #7 Zoom Out Right","Cam 2 #8 Zoom Out Left","Cam 2 #10 Zoom Out Down","Cam 2 #11 Pan Left to Right","Cam 2 #12 Pan Right to Left","Cam 2 #13 Wide Tilt Down","Cam 2 #14 After Video Sermon Push In","Cam 2 #15 Standard Sermon Shot"]
    var cam3 = ["Camera 3.1", "Camera 3.2","Camera 3.3","Camera 3.4","Camera 3.5","Camera 3.6","Camera 3.7","Camera 3.8","Camera 3.9","Camera 3.10","Camera 3.11","Camera 3.12","Camera 3.13","Camera 3.14","Camera 3.15","Camera 3.16","Camera 3.17","Camera 3.18","Camera 3.19"]
    var cam4 = ["Camera 4.1", "Camera 4.2","Camera 4.3","Camera 4.4","Camera 4.5","Camera 4.6","Camera 4.7","Camera 4.8","Camera 4.9","Camera 4.10","Camera 4.11","Camera 4.12","Camera 4.13"]
    var cam5 = ["Camera 5"]
    var cam6 = ["Camera 6"]
    var cam7 = ["Camera 7"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialization()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.collectionView.removeObserver(self, forKeyPath: "contentSize")
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize"
        {
            if let newvalue = change?[.newKey]{
                let newsize = newvalue as! CGSize
                self.collectionViewHeight.constant = newsize.height
            }
            
        }
    }
}


//MARK:- Initialization

extension HomeVC{
    func initialization(){
        self.navigationController?.isNavigationBarHidden = false
        playerViewController.view.isUserInteractionEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
}



//MARK:- CollectionView DataSource And Delegate

extension HomeVC : UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath as IndexPath) as? CustomCell
        cell?.img.image = UIImage(named: imgArray[indexPath.row])
        return cell ?? UICollectionViewCell()
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let vc = WebViewVC.instantiate(fromAppStoryboard: .Main)
            show(vc, sender: self)
        }
        else if indexPath.row == 1{
            let vc = VideoDetailsVC.instantiate(fromAppStoryboard: .Main)
            vc.video = cam1[0]
            vc.array = cam1
            show(vc, sender: self)
        }else if indexPath.row == 2{
            let vc = VideoDetailsVC.instantiate(fromAppStoryboard: .Main)
            vc.video = cam2[0]
            vc.array = cam2
            show(vc, sender: self)
        }else if indexPath.row == 3{
            let vc = VideoDetailsVC.instantiate(fromAppStoryboard: .Main)
            vc.video = cam3[0]
            vc.array = cam3
            show(vc, sender: self)
            
        }else if indexPath.row == 4{
            let vc = VideoDetailsVC.instantiate(fromAppStoryboard: .Main)
            vc.video = cam4[0]
            vc.array = cam4
            show(vc, sender: self)
            
        }else if indexPath.row == 5{
            let vc = VideoDetailsVC.instantiate(fromAppStoryboard: .Main)
            vc.video = cam5[0]
            vc.array = cam5
            show(vc, sender: self)
            
        }else if indexPath.row == 6{
            let vc = VideoDetailsVC.instantiate(fromAppStoryboard: .Main)
            vc.video = cam6[0]
            vc.array = cam6
            show(vc, sender: self)
            
        }else if indexPath.row == 7{
            let vc = VideoDetailsVC.instantiate(fromAppStoryboard: .Main)
            vc.video = cam7[0]
            vc.array = cam7
            show(vc, sender: self)
            
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.view.frame.size.width/2.16) - 16, height: (self.view.frame.size.width/2.5) )
    }
    
}
extension AVPlayerViewController {
    func disableGestureRecognition() {
        let contentView = view.value(forKey: "contentView") as? UIView
        contentView?.gestureRecognizers = contentView?.gestureRecognizers?.filter { $0 is UITapGestureRecognizer }
    }
}

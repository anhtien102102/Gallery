//
//  PreviewViewController.swift
//  Gallery-iOS
//
//  Created by trinh huu tien on 2/4/21.
//  Copyright © 2021 Hyper Interaktiv AS. All rights reserved.
//

import UIKit
import Photos
class PreviewViewController: UIViewController {

    var imageView: UIImageView?
    var closeButton: UIButton?
    var asset: PHAsset?
    
    public required init(asset: PHAsset) {
      self.asset = asset
      super.init(nibName: nil, bundle: nil)
      
    }

    public required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingView()
        if let _asset = asset{
            self.configure(_asset)
        }
    }
    
    func configure(_ asset: PHAsset) {
        imageView?.layoutIfNeeded()
        imageView?.g_loadImage(asset)
    }
    
    @objc func dismissClick() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func settingView(){
        self.view.backgroundColor = UIColor.black
        imageView = UIImageView(frame: .zero)
        imageView?.contentMode = .scaleAspectFit
        self.view.addSubview(imageView!)
        self.imageView?.translatesAutoresizingMaskIntoConstraints = false
        self.imageView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.imageView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.imageView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.imageView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(dismissClick))
        pan.maximumNumberOfTouches = 1
        self.imageView?.addGestureRecognizer(pan)
        self.imageView?.isUserInteractionEnabled = true
        
        self.closeButton = UIButton(frame: .zero)
        self.view.addSubview(self.closeButton!)
        self.closeButton?.translatesAutoresizingMaskIntoConstraints = false
        self.closeButton?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.closeButton?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.closeButton?.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.closeButton?.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.closeButton?.addTarget(self, action: #selector(dismissClick), for: UIControl.Event.touchUpInside)
        self.closeButton?.setImage(GalleryBundle.image("gallery_close")?.withRenderingMode(.alwaysTemplate), for: UIControl.State.normal)
        self.closeButton?.tintColor = Config.Grid.CloseButton.tintColor

    }

}




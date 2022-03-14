//
//  FeedController.swift
//  TwiterClone
//
//  Created by Vitor Henrique Barreiro Marinho on 14/03/22.
//

import UIKit



class FeedController:UIViewController {
    
    
    
    override func viewDidLoad() {
        
        configureUI()
        
        
    }
    
    
    
    
    
    func configureUI () {
        
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
        
    }
    
    
    
}

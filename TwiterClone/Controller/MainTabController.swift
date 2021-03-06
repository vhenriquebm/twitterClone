//
//  MainTabController.swift
//  TwiterClone
//
//  Created by Vitor Henrique Barreiro Marinho on 14/03/22.
//

import UIKit
import Firebase


class MainTabController: UITabBarController {
    
    
    //MARK: - Properties
    
    var actionButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        //logUserOut()
        authenticateUerAndConfigUI()
        
    }
    
    
    //MARK: - API
    
    func fetchUser () {
        UserService.shared.fetchUser()
        
    }
    
    
    func authenticateUerAndConfigUI () {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
                
            }
            
            print ("DEBUG: User is NOT logged in")
        } else {
            
            configureUI()
            configureViewControllers()
            fetchUser()
            
            
            print ("DEBUG: User is logged in")
        }
        
    }
    
    
    
    func logUserOut () {
        
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
        
        
    }
    
    
    
    
    
    //MARK: - Selectors
    
    @objc func actionButtonTapped () {
        
        print ("Funcionando")
        
    }
    
    
    
    //MARK: - Helpers
    
    func configureUI () {
        
        view.addSubview(actionButton)
        
        actionButton.anchor( bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        
        actionButton.layer.cornerRadius = 56/2
        
    }
    
    
    
    func configureViewControllers () {
        
        let feed = FeedController()
        let nav1 = templateViewController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        
        let explore = ExploreController()
        let nav2 = templateViewController(image: UIImage(named: "search_unselected"), rootViewController: explore)
        
        
        let conversations = ConversationsController()
        let nav3 = templateViewController(image: UIImage(named: "like_unselected"), rootViewController: conversations)
        
        
        let notifications = NotificationsController ()
        let nav4 = templateViewController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: notifications)
        
        viewControllers = [nav1,nav2,nav3,nav4]
    }
    
    
    func templateViewController (image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.barTintColor = .white
        
        return nav
        
    }
    
    
    
}

//
//  LoginController.swift
//  TwiterClone
//
//  Created by Vitor Henrique Barreiro Marinho on 14/03/22.
//

import UIKit



class LoginController: UIViewController {
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        configureUI()
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        
    }
    
    
    // MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "TwitterLogo")
        return iv
        
    }()
    
    
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextfield)
        return view
    }()
    
    
    private lazy var passWordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passWordTextfield)
        return view
    }()
    
    
    private let emailTextfield: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Email")
        
        return tf
        
    }()
    
    private let passWordTextfield: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Password")
        tf.isSecureTextEntry = true
        
        return tf
    }()
    
    
    
    private let loginButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handlerLogin), for: .touchUpInside)
        return button
        
        
    }()
    
    
    
    private let dontHaveAccountButton: UIButton = {
        
        let button = Utilities().attributedButton(firstPart: "Don't have an account?", secondPart: " Sign Up")
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    
    // MARK: - Selectors
    
    @objc func handlerLogin () {
        
        guard let email = emailTextfield.text else { return}
        guard let password = passWordTextfield.text else {return}
        
        
        AuthService.shared.logUserIn(withEmail: email, password: password) { (result, error) in
            
            if let error = error {
                
                print("DEBUG: Error logging in \(error.localizedDescription)")
                
                return
            }
            
            
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {
                return
            }
            
            guard let tab = window.rootViewController as? MainTabController else {return}
            
            tab.authenticateUerAndConfigUI()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    @objc func handleShowSignUp () {
        
        
        let controller = RegistrationController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    

    // MARK: - Helpers
    
    func configureUI () {
        view.backgroundColor = .twitterBlue
        
        view.addSubview(logoImageView)
        logoImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        logoImageView.setDimensions(width: 150, height: 150)
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passWordContainerView,loginButton])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top:logoImageView.bottomAnchor,left: view.leftAnchor, right: view.rightAnchor, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
        
    }
    
    
    
}

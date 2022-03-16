//
//  RegistrationController.swift
//  TwiterClone
//
//  Created by Vitor Henrique Barreiro Marinho on 14/03/22.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {
    
    
    
    //MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        
        configureUI()
        
    }
    
    
    // MARK: - Properties
    
    private let imagePicker = UIImagePickerController ()
    private var profileImage: UIImage?
    
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlerAddProfile), for: .touchUpInside)
        
        return button
        
    }()
    
    
    private let alreadyHaveAccountButton: UIButton = {
        
        let button = Utilities().attributedButton(firstPart: "Already have an account?", secondPart: " Log in")
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        
        return button
    }()
    
    
    
    private lazy var emailContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: emailTextfield)
        return view
    }()
    
    
    private lazy var passWordContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: passwordTextfield)
        return view
    }()
    
    
    private lazy var fullNameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_mail_outline_white_2x-1")
        let view = Utilities().inputContainerView(withImage: image, textField: fullNameTextfield)
        return view
    }()
    
    
    private lazy var userNameContainerView: UIView = {
        let image = #imageLiteral(resourceName: "ic_lock_outline_white_2x")
        let view = Utilities().inputContainerView(withImage: image, textField: userNameTextfield)
        return view
    }()
    
    
    private let emailTextfield: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Email")
        
        return tf
        
    }()
    
    private let passwordTextfield: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "password")
        tf.isSecureTextEntry = true
        
        return tf
        
    }()
    
    
    private let fullNameTextfield: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "Full name")
        
        return tf
        
    }()
    
    private let userNameTextfield: UITextField = {
        let tf = Utilities().textField(withPlaceHolder: "User Name")
        
        
        return tf
    }()
    
    
    private let registrationButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(handleRegistration), for: .touchUpInside)
        return button
        
        
    }()
    
    
    
    
    // MARK: - Selectors
    
    @objc func handleShowLogin () {
        
        
        navigationController?.popViewController(animated: true)
        
        
    }
    
    
    @objc func handlerAddProfile () {
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @objc func   handleRegistration () {
        
        guard let image = profileImage else {
            print("DEBUG: Please select a profile image")
            return
            
        }
        
        guard let email = emailTextfield.text else {return}
        guard let password = passwordTextfield.text else {return}
        guard let fullname = fullNameTextfield.text else {return}
        guard let userName = userNameTextfield.text else {return}
        
        let credentials = AuthCredentials(email: email, password: password, fullName: fullname, userName: userName, profileImage: image)
        AuthService.shared.registerUser(credentials: credentials) { (error, ref) in
            
            
            guard let window = UIApplication.shared.windows.first(where: {$0.isKeyWindow}) else {
                return
            }
            
            guard let tab = window.rootViewController as? MainTabController else {return}
            
            tab.authenticateUerAndConfigUI()
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        
    }
    
    
    
    
    
    
    // MARK: - Helpers
    
    func configureUI () {
        view.backgroundColor = .twitterBlue
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor)
        plusPhotoButton.setDimensions(width: 128, height: 128)
        let stack = UIStackView(arrangedSubviews: [emailContainerView, passWordContainerView, fullNameContainerView, userNameContainerView, registrationButton])
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        view.addSubview(stack)
        stack.anchor(top:plusPhotoButton.bottomAnchor,left: view.leftAnchor, right: view.rightAnchor,paddingTop: 32, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingRight: 40)
        
    }
    
}


extension RegistrationController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let profileImage = info[.editedImage] as? UIImage else {return}
        self.profileImage = profileImage
        
        
        plusPhotoButton.layer.cornerRadius = 128 / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.imageView?.contentMode = .scaleAspectFill
        plusPhotoButton.imageView?.clipsToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 3
        
        
        
        self.plusPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
}

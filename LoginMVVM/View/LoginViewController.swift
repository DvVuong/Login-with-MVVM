//
//  ViewController.swift
//  LoginMVVM
//
//  Created by admin on 10/10/2022.
//

import UIKit
import Combine
import CoreData

class LoginViewController: UIViewController, UITextViewDelegate  {
    @IBOutlet weak var userNameTextFiled: UITextField!
    @IBOutlet weak var passwordTextFiled: UITextField!
    @IBOutlet weak var btLogin: UIButton!
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var passworkError: UILabel!
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var emailError: UILabel!
    
    private var subscriptions = Set<AnyCancellable>()

    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        onBind()
        setupBtLogin()
    }
    private func setupUI() {
        userNameTextFiled.addTarget(self, action: #selector(didChangeTextFiled(_:)), for: .editingChanged)
        passwordTextFiled.addTarget(self, action: #selector(didChangeTextFiled(_:)), for: .editingChanged)
        emailTextFiled.addTarget(self, action: #selector(didChangeTextFiled(_:)), for: .editingChanged)
        nameError.textColor = .red
        nameError.isHidden = true
        passworkError.isHidden = true
        passworkError.textColor = .red
        emailError.isHidden = true
        emailError.textColor = .red
    }
    
    private func onBind() {
        // subscription
//        viewModel.onNameErrorListener = { [unowned self] in
//            self.nameError.text = $0
//        }
        
        viewModel.nameErrorPublisher.assign(to: \.text, on: nameError).store(in: &subscriptions)
        nameError.isHidden = false
        viewModel.emailErrorPublisher.assign(to: \.text, on: emailError).store(in: &subscriptions)
        emailError.isHidden = false
        viewModel.passErrorPublisher.assign(to: \.text, on: passworkError).store(in: &subscriptions)
        passworkError.isHidden = false
        // Button
        Publishers.CombineLatest3(viewModel.nameErrorPublisher.map { $0 == nil },
                                  viewModel.passErrorPublisher.map { $0 == nil },
                                  viewModel.emailErrorPublisher.map { $0 == nil })
        .map { $0.0 && $0.1 && $0.2 }
        .assign(to: \.isEnabled, on: btLogin)
        .store(in: &subscriptions)
    }
    
    @objc private func didChangeTextFiled(_ textField: UITextField) {
        if textField === userNameTextFiled {
            viewModel.usernamePublisher.send(textField.text ?? "")
        }
        else if textField === passwordTextFiled {
             viewModel.passwordPublisher.send(textField.text ?? "")
        }
       else if textField === emailTextFiled {
           viewModel.emailPublisher.send(textField.text ?? "")
        }
    }
    private func setupBtLogin() {
        btLogin.isEnabled = false
        btLogin.addTarget(self, action: #selector(didTapLogin), for: .touchUpInside)
    }
   
    @objc private func didTapLogin() {
       print("abc")
    }

    
    

}



//
//  LoginViewModel.swift
//  LoginMVVM
//
//  Created by admin on 10/10/2022.
//

import Foundation
import Combine
final class LoginViewModel {
    
    var onNameErrorListener: ((String?) -> Void)?
    
    // publsher
    let nameErrorPublisher = CurrentValueSubject<String?, Never>("")
    let passErrorPublisher = CurrentValueSubject<String?, Never>("")
    let emailErrorPublisher = CurrentValueSubject<String?, Never>("")
    //let massagerErrorPublisher = CurrentValueSubject<String?, Never>(nil)
   
   // Pubsher validate
    let usernamePublisher = PassthroughSubject<String, Never>()
    let passwordPublisher = PassthroughSubject<String, Never>()
    let emailPublisher = PassthroughSubject<String, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        //
        usernamePublisher.map{self.validUserName($0) }.sink { valiPair in
            self.nameErrorPublisher.value = valiPair.message
//            self.onNameErrorListener?(valiPair.message)
        }.store(in: &subscriptions)
        
        passwordPublisher.map {self.validPassword($0)}.sink { valPair in
            self.passErrorPublisher.value = valPair.1
        }.store(in: &subscriptions)
        
        emailPublisher.map {self.validEmail($0)}.sink { valPair in
            self.emailErrorPublisher.value = valPair.1
        }.store(in: &subscriptions)
        
//        usernamePublisher.sink { username in
//            print("vuongdv","name", username)
//        }.store(in: &subscriptions)
//        
//        passwordPublisher.sink { password in
//            print("vuongdv","password", password)
//        }
//        .store(in: &subscriptions)
//        
//        emailPublisher.sink { email in
//            print("vuongdv","email", email)
//        }.store(in: &subscriptions)
        
    }
    private func validUserName(_ username: String) -> (isValid: Bool, message: String?) {
        if username.isEmpty {
            return (false, "Username khong dc de trong")
        }
        if username == "vuongdv" {
            return (true, "Correct user")
        }
        return (true, nil)
    }
    private func validEmail(_ email: String) -> (Bool, String?) {
        if email.isEmpty {
            return (false, "Email can't emty")
        }
//        if email == "email@gmail.com" {
//            return (true, "Correct Email")
       // }
        if !isEmail(email) {
            return (false, "Khong dung dinh dang")
        }
        return (true , nil)
    }
    private func validPassword(_ password: String) -> (Bool, String?) {
        if password.isEmpty {
            return (false, "Password cant't emty")
        }
        if password.contains(" ") {
            return (false, " Password must not contain spaces" )
        }
        if password.count < 8  {
            return (false, "Password so short")
        }
//        if password == "password123" {
//            return (true, "Correct password")
//        }
        return (true, nil)
    }

    private func isEmail(_ text: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: text)
    }
}

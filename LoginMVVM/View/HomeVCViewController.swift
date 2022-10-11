//
//  HomeVCViewController.swift
//  LoginMVVM
//
//  Created by admin on 10/10/2022.
//

import UIKit
import Combine

class HomeVCViewController: UIViewController {
    static func instance() -> HomeVCViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeScreen") as! HomeVCViewController
        return vc
    }
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPassword: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    
    var countPublisher = PassthroughSubject<String?, Never>()// Punlisher 
   
    @Published var name: String = " "
    
    var callback: String = " " {
        didSet {
            countPublisher.send(callback)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabName()
    }
    private func setupLabName() {
        lbName.text = name
       
    }

    @IBAction func didTapDone(_ sender: Any) {
        guard let value = textField.text  else { return }
        callback = value
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

//
//  ViewController.swift
//  combineLatest
//
//  Created by Kaushik on 23/11/23.
//

import UIKit
import Combine

class ViewController: UIViewController
{
    @IBOutlet weak var txtUName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var TCSwithc: UISwitch!
    @IBOutlet weak var BTNLogin: UIButton!
    
    
    @Published private var isTCAccepted : Bool = false
    @Published private var uNameStr : String = ""
    @Published private var passwordSTR : String = ""
    
    private var subscriptions: Set<AnyCancellable> = Set<AnyCancellable>()
    
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.signupValidaitonPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isEnabled, on: BTNLogin)
            .store(in: &subscriptions)
    }

    private var signupValidaitonPublisher: AnyPublisher<Bool, Never>
    {
        return Publishers.CombineLatest3($isTCAccepted, $uNameStr, $passwordSTR)
            .map
            {
                isTCAccepted, uNameStr, passwordSTR in
                isTCAccepted && !uNameStr.isEmpty && !passwordSTR.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    @IBAction func actionSwithc(_ sender: UISwitch)
    {
        isTCAccepted = sender.isOn
    }
    
    @IBAction func didchangeUName(_ sender: UITextField)
    {
        uNameStr = sender.text ?? ""
    }
    
    @IBAction func didchangePassword(_ sender: UITextField)
    {
        passwordSTR = sender.text ?? ""
    }
    
    @IBAction func loginAction(_ sender: Any)
    {
        let home = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeVC")
        self.navigationController?.pushViewController(home, animated: true)
    }
    
}


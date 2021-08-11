//
//  ViewController.swift
//  LoveCalculator
//
//  Created by Barış Can Akkaya on 8.08.2021.
//

import UIKit
import Lottie
import Material
import SnapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var partnerTextField: TextField!
    @IBOutlet weak var userTextField: TextField!
    var loveAnimationView: AnimationView?
    var raisedButton: RaisedButton?
    var mainScreenAnimationView: AnimationView?
    var width: CGFloat?
    var height: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        width = view.frame.size.width
        height = view.frame.size.height
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        showAnimation()
        prepareUserField()
        preparePartnerField()
        generateLayout()
        
    }
}

extension ViewController {
    
    func showAnimation() {
        mainScreenAnimationView?.isHidden = true
        raisedButton?.isHidden = true
        partnerTextField.isHidden = true
        userTextField.isHidden = true
        loveAnimationView = AnimationView(name: "love")
        loveAnimationView?.loopMode = .loop
        loveAnimationView?.animationSpeed = 0.8
        loveAnimationView?.frame = self.view.bounds
        view.addSubview(loveAnimationView!)
        loveAnimationView?.play()
        Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(self.destroyAnimation), userInfo: nil, repeats: false)
        
    }
    
    @objc func destroyAnimation() {
        loveAnimationView?.stop()
        loveAnimationView?.removeFromSuperview()
        userTextField.isHidden = false
        partnerTextField.isHidden = false
        mainScreenAnimationView?.isHidden = false
        raisedButton?.isHidden = false
    }
    
    
    func prepareUserField() {
        userTextField.delegate = self
        userTextField.isHidden = true
        userTextField.placeholder = "Your Name"
        userTextField.detail = "Only english letters!"
        userTextField.clearButtonMode = .whileEditing
        userTextField.isClearIconButtonEnabled = true
        userTextField.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.width.equalTo(width! * 0.75)
            maker.top.equalTo(width! * 0.9)
        }
    }
    
    func preparePartnerField() {
        partnerTextField.delegate = self
        partnerTextField.isHidden = true
        partnerTextField.placeholder = "Your Partner's Name"
        partnerTextField.detail = "Only english letters!"
        partnerTextField.clearButtonMode = .whileEditing
        partnerTextField.isClearIconButtonEnabled = true
        partnerTextField.snp.makeConstraints { maker in
            maker.centerX.equalToSuperview()
            maker.width.equalTo(width! * 0.75)
            maker.top.equalTo(width! * 1.2)
        }
        
    }
    
    func generateLayout() {
        raisedButton = RaisedButton(title: "Calculate", titleColor: .white)
        raisedButton?.addTarget(self, action: #selector(self.buttonAction), for: .touchUpInside)
        raisedButton?.pulseColor = .white
        raisedButton?.backgroundColor = UIColor.systemPink
        raisedButton?.layer.cornerRadius = 10
        view.addSubview(raisedButton!)
        raisedButton?.snp.makeConstraints({ maker in
            maker.top.equalTo(width! * 1.5)
            maker.width.equalTo(width! * 0.6)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(height! * 0.1)
        })
        raisedButton?.isHidden = true
        

        mainScreenAnimationView = AnimationView(name: "love-loading")
        view.addSubview(mainScreenAnimationView!)
        mainScreenAnimationView?.snp.makeConstraints { (maker) -> Void in
            maker.top.equalTo(self.view.safeAreaLayoutGuide).offset(0)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(width! * 0.75)
            maker.height.equalTo(width! * 0.75)
        }
        mainScreenAnimationView?.loopMode = .loop
        mainScreenAnimationView?.play()
        mainScreenAnimationView?.isHidden = true
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let VC = segue.destination as? ResultViewController {
            VC.user1 = partnerTextField.text
            VC.user2 = userTextField.text
        }
        
    }
    
    @objc func buttonAction(_ sender:UIButton!)
    {
        performSegue(withIdentifier: "goToResultPage", sender: self)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
}

extension ViewController: TextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        (textField as? ErrorTextField)?.isErrorRevealed = false
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = false
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        (textField as? ErrorTextField)?.isErrorRevealed = true
        textField.endEditing(true)
        return true
    }
}


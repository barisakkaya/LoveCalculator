//
//  ResultViewController.swift
//  LoveCalculator
//
//  Created by Barış Can Akkaya on 9.08.2021.
//

import UIKit
import Lottie
import Material
import SnapKit

class ResultViewController: UIViewController {
    
    var label: UILabel!
    var resultAnimation: AnimationView!
    
    var user1: String?
    var user2: String?
    var loveViewModel: LoveViewModel?
    var url: URL?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        showResult()
        
        
        
    }
    
    
    func createLayout() {
        label = UILabel()
        label?.textAlignment = .center
        label?.font = UIFont.systemFont(ofSize: 28, weight: .medium)
        label.backgroundColor = .systemPink
        label?.textColor = .white
        //view.backgroundColor = UIColor.systemPink
        view.addSubview(label!)
        label?.snp.makeConstraints({ maker in
            maker.width.equalTo(view.frame.width)
            maker.centerX.equalToSuperview()
            maker.height.equalTo(view.frame.height / 10)
            maker.top.equalTo(view.safeAreaLayoutGuide).offset(view.frame.height/7.5)
        })
        label?.text = "Result"
        
        let result = UILabel()
        result.text = loveViewModel!.yuzde + "%"
        result.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        result.textColor = .systemRed
        result.textAlignment = .center
        view.addSubview(result)
        result.snp.makeConstraints { maker in
            maker.top.equalTo(label.snp.bottom).offset(view.frame.height/10)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(view.frame.width)
        }
        let info = UILabel()
        info.text = loveViewModel!.info
        info.numberOfLines = 2
        info.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        info.textColor = .systemRed
        info.textAlignment = .center
        view.addSubview(info)
        info.snp.makeConstraints { maker in
            maker.top.equalTo(result.snp.bottom).offset(view.frame.height/20)
            maker.centerX.equalToSuperview()
            maker.width.equalTo(view.frame.width)
        }
        
        
        resultAnimation = AnimationView(name: "explosion")
        view.addSubview(resultAnimation!)
        resultAnimation?.snp.makeConstraints({ maker in
            maker.width.equalTo(view.frame.width * 0.66)
            maker.height.equalTo(view.frame.width * 0.66)
            maker.top.equalTo(info.snp.bottom).offset(view.frame.height/50)
            maker.centerX.equalTo(view)
        })
        resultAnimation.backgroundColor = .white
        resultAnimation.loopMode = .loop
        resultAnimation.play()
        
    }
    
    func getURL(user: String, partner: String) -> URL {
        return URL(string: "https://love-calculator.p.rapidapi.com/getPercentage?fname=\(user)&sname=\(partner)")!
    }
    
    func showResult() {
        
        url = getURL(user: user1!, partner: user2!)
        LoveService().getLoveScore(url: url!) { loveModel in
            if let loveModel = loveModel {
                self.loveViewModel = LoveViewModel(loveModel: loveModel)
                DispatchQueue.main.async {
                    self.createLayout()
                }
            }
        }
    }
}

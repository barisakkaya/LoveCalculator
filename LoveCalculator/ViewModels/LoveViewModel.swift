//
//  LoveViewModel.swift
//  LoveCalculator
//
//  Created by Barış Can Akkaya on 9.08.2021.
//

import Foundation


struct LoveViewModel {
    let loveModel: LoveModel?
    
    init(loveModel: LoveModel) {
        self.loveModel = loveModel
    }
}


extension LoveViewModel {
    var info: String {
        if let model = loveModel {
            return model.result
        }
        
        return ""
    }
    
    var yuzde: String {
        if let model = loveModel {
            return model.percentage
        }
        return ""
    }
    
    
}

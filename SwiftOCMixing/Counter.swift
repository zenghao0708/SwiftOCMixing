//
//  Counter.swift
//  SwiftOCMixing
//
//  Created by zenghao on 2017/1/7.
//  Copyright © 2017年 zenghao0708. All rights reserved.
//

import Foundation

class Counter: NSObject {
    private var num = 0
    
    init(num: Int = 0) {
        self.num = num
    }
    
    func increase() {
        num = num + 1
    }
    
    func decrease() {
        num = num - 1
    }
    
    override var description: String {
        get {
            return "\(num)"
        }
    }
    
}

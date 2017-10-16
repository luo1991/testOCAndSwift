//
//  hdtest.swift
//  testhd
//
//  Created by admin on 17/9/26.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

import UIKit

class hdtest: NSObject{
    // 实例方法
    func sayHello(greeting:String,WithName name:String)->String{
        var sayString = "Hi," + name
        
        sayString += greeting
        
        return sayString
        
    }
    
    func sayHi(name:String) -> String {
        let greeting = "Hello," + name + "!"
        return greeting
    }
    //  类方法
    class func hhh(number:Int)->Int {
        
        var a = 0
        for i in 1...number {
            a += i
//            print("测试的\(a)")
        }
       
        return a
    }
    
}

//class SwiftClass: NSObject {
//    func sayHello(name:String) -> String {
//        let greeting = "Hello" + name + "!"
//        return greeting
//    }
//    
//}

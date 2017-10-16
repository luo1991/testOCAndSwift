//
//  hdViewController.swift
//  testhd
//
//  Created by admin on 17/9/26.
//  Copyright © 2017年 com.test.hd. All rights reserved.
//

import UIKit
//import OtherViewController

 let ID = "hdcell"

class hdViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
   
    var titleNameLabel:UILabel!
    var txtPassword:UITextField!
    var btnLogin:UIButton!
      var datas:NSMutableArray = ["1","2","3","4","5","6"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
       self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "3"), forBarMetrics: .Default)
        
        var tableView = UITableView()
      
        

        tableView = UITableView(frame: CGRectMake(0, 0, view.frame.size.width, view.frame.size.height), style: UITableViewStyle.Plain)
        tableView.dataSource = self
        tableView.delegate = self

//        print("这都是什么 ");
        
        self.view.addSubview(tableView)
        
        tableView.registerClass(UITableViewCell().classForCoder, forCellReuseIdentifier: ID)

        // Do any additional setup after loading the view.
    }
  
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 获得cell
        let cell = tableView.dequeueReusableCellWithIdentifier(ID, forIndexPath: indexPath)
 
//        配置cell
        cell.textLabel?.text = "假数据-\(datas[indexPath.row])"
        return cell
        
    }
   
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
     
        self.navigationController?.popViewControllerAnimated(true)
        
//        var test:hdtest;
        
        let test = hdtest()
//        hdtest.hhh()
        test.sayHi("Li ming")
        
     let helloStr = test.sayHello("你好", WithName: "罗先生")
        if helloStr.isEmpty{
           
        }else{
           print(helloStr)  
        }
        print(helloStr + test.sayHi("Li ming"))
        
//        hdtest.hhh(10)
        print(hdtest.hhh(10))
//        let oterVC:OtherViewController = OtherViewController()
//        self.navigationController?.pushViewController(oterVC, animated: true)
        
//        self.tabBarController?.selectedIndex = 1
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

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
        self.view.backgroundColor = UIColor.white
//       self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "3"), forBarMetrics: .default)
        
//         self.navigationController?.navigationBar.setBackgroundImage(UIImage, for: UIBarMetrics)
        
        
       let  tableView = UITableView()
      
        

        tableView.frame = self.view.frame
       

//        print("这都是什么 ");
        
        self.view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
//        tableView.register(UITableViewCell(), forCellReuseIdentifier: ID)

        // Do any additional setup after loading the view.
    }
  
  
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
            return datas.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 获得cell
        
        let identifier="identtifier";
        var cell=tableView.dequeueReusableCell(withIdentifier: identifier)
        if(cell == nil){
            cell=UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: identifier);
        }
        
//        cell?.textLabel?.text = itemStringArr[indexPath.row];
        cell?.detailTextLabel?.text = "待添加内容";
        cell?.detailTextLabel?.font = UIFont .systemFont(ofSize: CGFloat(13))
        cell?.accessoryType=UITableViewCellAccessoryType.disclosureIndicator
        
        return cell!
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
         let oterVC:KVOViewController = KVOViewController()
        
        self.navigationController?.pushViewController(oterVC, animated: true)
        
//        self.navigationController?.popViewController(animated: true)
       
        
        
    }
//        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//
//
//
//
//            //        var test:hdtest;
//
//            //        let test = hdtest()
//            ////        hdtest.hhh()
//            //        test.sayHi("Li ming")
//            //
//            //     let helloStr = test.sayHello("你好", WithName: "罗先生")
//            //        if helloStr.isEmpty{
//            //
//            //        }else{
//            //           print(helloStr)
//            //        }
//            //        print(helloStr + test.sayHi("Li ming"))
//            //
//            ////        hdtest.hhh(10)
//            //        print(hdtest.hhh(10))
//            //        let oterVC:OtherViewController = OtherViewController()
//            //        self.navigationController?.pushViewController(oterVC, animated: true)
//
//            //        self.tabBarController?.selectedIndex = 1
//        }
//

        
    
    
    
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

//
//  ApplyViewController.swift
//  Launch
//
//  Created by Leo on 2017/8/23.
//  Copyright © 2017年 com.USSwiftCoda. All rights reserved.
//

import UIKit
    


class ApplyViewController: UIViewController
{
    //設定一個讓下一個頁面可以返回到此的Seque（當點選儲存時）
    @IBAction func unwindApplyViewController(for unwindSegue: UIStoryboardSegue) {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

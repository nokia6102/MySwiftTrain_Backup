//
//  QAViewController.swift
//  Launch
//
//  Created by Leo on 2017/8/16.
//  Copyright © 2017年 com.USSwiftCoda. All rights reserved.
//

import UIKit

class QAViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //直接在Navigation Bar產生標題
        //title = "提出問題2"

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

    //MARK: Action Button
    //回上頁
    @IBAction func btnCancel(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }

    
    


}

//
//  SearchViewController.swift
//  Launch
//
//  Created by Leon Cheng on 2018/6/25.
//  Copyright © 2018年 com.USSwiftCoda. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var txtSearch: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

  //MARK: - Navigation

 //    In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        print("轉換到其他頁")
        
        if segue.identifier == "sgSearch"
        {
            print ("發動sgSearch")
            let secondVC = segue.destination as! MainViewController
            secondVC.upVC = self
           
        }
    
    }
    

}

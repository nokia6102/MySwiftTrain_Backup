//
//  ClassListViewController.swift
//  Launch
//
//  Created by Leo on 2017/8/14.
//  Copyright © 2017年 com.USSwiftCoda. All rights reserved.
//

import UIKit

class ClassListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    //建立要顯示的資料，存在陣列裡面
    let animalArray = ["cat", "dog", "elephant", "rabbit", "lion", "tiger"]
    
    //要顯示幾個section
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    //section裡面要顯示的列數
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return animalArray.count
    }
    
    //每一列TableViewCell要顯示的資料
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //先產出Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //設定Cell的文字
        cell.textLabel?.text = animalArray[indexPath.row]
        //設定儲存格右邊箭頭
//        cell.accessoryType = .checkmark
        return cell
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

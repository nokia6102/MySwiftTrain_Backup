//
//  ClassListViewController.swift
//  Launch
//
//  Created by Leo on 2017/8/14.
//  Copyright © 2017年 com.USSwiftCoda. All rights reserved.
//

import UIKit
//import AVFoundation
//import AVKit
import WebKit

class ClassListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var videoView: UIWebView!
    
    
    //建立要顯示的資料，存在陣列裡面
    let noArray = ["1", "2", "3", "4", "5", "6"]
    let titleArray = ["cat", "dog", "elephant", "rabbit", "lion", "tiger"]
    let timeArray = ["00:30 ", "01:30 ", "02:00 ", "02:30 ", "03:00 ", "03:30 "]
    
    //要顯示幾個section
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    //section裡面要顯示的列數
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return noArray.count
    }
    
    //每一列TableViewCell要顯示的資料
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //先產出Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //Cell的contentView的subview是一個陣列
        //第0項拿到storyboard設定的cellText1，第1項拿到storyboard設定的cellText2，第3項拿到storyboard設定的cellText3
        let cellText1 = cell.contentView.subviews[0] as! UILabel
        let cellText2 = cell.contentView.subviews[1] as! UILabel
        let cellText3 = cell.contentView.subviews[2] as! UILabel
        
        //設定label的文字
        cellText1.text = noArray[indexPath.row]
        cellText2.text = titleArray[indexPath.row]
        cellText3.text = "視頻- " + timeArray[indexPath.row] + " 分鐘"
        
        //設定儲存格右邊箭頭
        cell.accessoryType = .checkmark
        return cell
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        //<方法一>讀取網頁的影片位置
//        let address = "https://youtu.be/k-gSySYQCx0"
//        let addressURL = URL(string: address)
//        if let url = addressURL
//        {
//            let request = URLRequest(url: url)
//            videoView.loadRequest(request)
//        }
        
        //<方法二>讀取本地端的影片位置
//        let videoPath = Bundle.main.path(forResource: "HipHop", ofType: "mp4")
//        let url = URL(fileURLWithPath: videoPath!)
//        videoView.loadRequest(URLRequest(url: url))
        
        //<方法三>使用WKWebView，讀取網頁的影片位置
        let wkWebViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 266)
        let videoView = WKWebView(frame: wkWebViewFrame)
        let webAddress = "https://youtu.be/k-gSySYQCx0"
        let webURL = URL(string: webAddress)
        if let url = webURL
        {
            let request = URLRequest(url: url)
            videoView.load(request)
        }
        view.addSubview(videoView)
        
        //<方法四>使用WKWebView，讀取本地端的影片位置
//        let wkWebViewFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 266)
//        let videoView = WKWebView(frame: wkWebViewFrame)
//        let videoPath = Bundle.main.path(forResource: "HipHop", ofType: "mp4")
//        let url = URL(fileURLWithPath: videoPath!)
//        videoView.load(URLRequest(url: url))
//        view.addSubview(videoView)
        
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
    @IBAction func btnMovie(_ sender: UIButton)
    {
//        let videoURL = Bundle.main.url(forResource: "HipHop", withExtension: "mp4")
//        let videoPlayer = AVPlayer(url: videoURL!)
//        let videoPlayController = AVPlayerViewController()
//        videoPlayController.player = videoPlayer
//        present(videoPlayController, animated: true, completion: nil)
//        videoPlayer.play()
        
        
    }
    
    

}

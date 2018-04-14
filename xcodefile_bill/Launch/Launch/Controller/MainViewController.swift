import UIKit
import youtube_ios_player_helper
import Firebase
import FirebaseDatabase
import PKHUD
import FirebaseAuth

class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var ref,refQCount : DatabaseReference!
    var arrTable = [[String:Any]]()
    var tableOk = false
    var selectLession = 1
    var loaded = false
  @IBOutlet weak var btnAnswer: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //iOS; 上的离线功能
        Database.database().isPersistenceEnabled = true

      //---網路逾時的偵測
        Timer.scheduledTimer(withTimeInterval: 7.5, repeats: false) { (timer) in
            PKHUD.sharedHUD.hide() { success in
                self.loaded = true
               if (self.arrTable.count == 0)
                {
                    PKHUD.sharedHUD.contentView = PKHUDErrorView(title: "網路逾時", subtitle: "請檢抓不到到網路資料哦\n查網路是否被防火牆擋")
                    PKHUD.sharedHUD.show()
                    self.loaded = false
                }
            }
        }
      //---
        ref = Database.database().reference(fromURL: "https://trainforswift-f4067.firebaseio.com/Lesson")
        refQCount = Database.database().reference(fromURL: "https://trainforswift-f4067.firebaseio.com/Counter")

        self.readLessionList()
        self.readCounter()

    }

    override func viewDidAppear(_ animated: Bool) {
        if !loaded
        {
            PKHUD.sharedHUD.contentView = PKHUDProgressView()
            PKHUD.sharedHUD.show()
            self.loaded = true
        }
    }
    

    @IBAction func goBack(_ sender: UIButton)
    {
       
        performSegue(withIdentifier: "goBackMenu", sender: sender)

        
//        self.dismiss(animated: true) {
//            print ("** 回上一頁 有登入的按鍵畫面")
//            PKHUD.sharedHUD.hide() { success in
//
//            }
//        }
    }
    
    
    
    func readLessionList()
    {
        
        ref.observe(.value, with: { (snapshot) in
            
           self.arrTable.removeAll()
            for child in snapshot.children
            {
                let Value:DataSnapshot = child as! DataSnapshot
                
                let  myValue = Value.value!
                
                if let dictionary  = myValue as? [String : Any]
                {
                    self.arrTable.append(dictionary)
                }
            }
            self.tableOk = true
            self.tableView.reloadData()
            self.loaded = true
            
          //選擇在第一行
          let selIndexPath = IndexPath(row: 0 , section: 0)
          self.tableView.selectRow(at: selIndexPath, animated: true, scrollPosition: .middle)
            print("all:\(self.arrTable)")
            print("count:\(self.arrTable.count)")

        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  func readCounter()
  {
    refQCount.observe(.value, with: { (snapshot) in
      
        let postDict = snapshot.value as? [String : AnyObject] ?? [:]
        print ("postDict: \(postDict)")
        let pNum = postDict["Qcount"] as! Int
        print ("pNum \(pNum)")
        let p = "問答 (\(pNum))"
      self.btnAnswer.setTitle( p, for: .normal)
        
        PKHUD.sharedHUD.hide() { success in
            self.loaded = true
        }

    })
    
  }

  
    @IBAction func unwindToMainVC(segue:UIStoryboardSegue) { print ("回來MainView") }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
        cell.lblNo.text = arrTable[indexPath.row]["lid"] as? String
        cell.lblTitle.text = arrTable[indexPath.row]["title"] as? String
        cell.lblDescription.text = arrTable[indexPath.row]["desc"] as? String
      return cell
    }

  @IBAction func tapPlay(_ sender: UIButton)
  {
    selectLession = tableView.indexPathForSelectedRow!.row
    performSegue(withIdentifier: "sgPlay", sender: self)
  }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectLession = indexPath.row
         print ("s0:\(selectLession)")
        performSegue(withIdentifier: "sgPlay", sender: self)
  
 
    }
    
//     // MARK: - Navigation
//     
//     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destinationViewController.
//     // Pass the selected object to the new view controller.
//             selectLession = 1
//        
//     }
    
    //當由轉換線進行換頁時，會呼叫此方法
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        print("轉換到其他頁")
        
        if segue.identifier == "sgPlay"
        {
             print ("發動sgPlay")
             let secondVC = segue.destination as! PlayerController
             secondVC.firstVC = self
             print ("s1:\(selectLession)")
             secondVC.selectVideo = selectLession
        }
        else if segue.identifier == "sgPlayFrist1"
        {
            print ("發動sgPlay")
            let secondVC = segue.destination as! PlayerController
            secondVC.firstVC = self
            print ("s1:\(selectLession)")
            secondVC.selectVideo = 0
        }
        
//
//            selectLession = (tableView.indexPathForSelectedRow?.row)!
//            print ("select Lession:\(selectLession)")
//            //從轉換線取得下一頁的執行實體（此時是UIViewController的視角），並進行SecondViewController的型別轉換
//            let secondVC = segue.destination as! PlayerController
//            //進行傳遞資訊到下一頁（填入下一頁的屬性值）<值型別傳遞>
////            secondVC.str = "hello"
//            //把自己這一頁的引用傳給下一頁<引用型別傳遞>
//            secondVC.firstVC = self
//        }
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

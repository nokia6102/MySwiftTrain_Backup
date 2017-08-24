import UIKit
import youtube_ios_player_helper
import Firebase
import FirebaseDatabase


class MainViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var ref : DatabaseReference!
    var arrTable = [[String:Any]]()
    var tableOk = false
    var selectLession = 1
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(fromURL: "https://trainforswift-f4067.firebaseio.com/Lesson")

     
        readLessionList()
    }

    
    
    func readLessionList()
    {
        
        ref.observe(.value, with: { (snapshot) in
            
            
            for child in snapshot.children
            {
                let Value:DataSnapshot = child as! DataSnapshot
                
                let  myValue = Value.value!
                
                if var dictionary  = myValue as? [String : Any]
                {
                    self.arrTable.append(dictionary)
                }
            }
            self.tableOk = true
            self.tableView.reloadData()
            print("all:\(self.arrTable)")
            print("count:\(self.arrTable.count)")
        
            
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMainVC(segue:UIStoryboardSegue) { print ("回來") }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
            cell.lblTitle.text = arrTable[indexPath.row]["title"] as? String
      return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectLession = indexPath.row + 1
        
         print ("s0:\(selectLession)")
        
        performSegue(withIdentifier: "sgPlay", sender: self)
       //  prepare(for: <#T##UIStoryboardSegue#>, sender: <#T##Any?#>)
 
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

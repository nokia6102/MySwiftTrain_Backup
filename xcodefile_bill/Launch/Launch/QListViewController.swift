import UIKit
import Firebase
import FirebaseDatabase

class QListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var ref ,refQ ,refA: DatabaseReference!
    var arrTable = [[String:Any]]()
    var arrQTable = [[String:Any]]()
    var tableOk = false
    var selectQ = 2
    var firstVC : QAViewController?
  
  @IBOutlet weak var lblTimestamp: UILabel!
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var totalReponse: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      ref = Database.database().reference(fromURL: "https://trainforswift-f4067.firebaseio.com")
      refQ = ref.child("Q")
      refA = ref.child("A")
      
      
        readQList()
        readAList()
        
        
      
        //透明NavigationBar背景
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
  
  func readQList()
  {
    
    refQ.observe(.value, with: { (snapshot) in
      
      self.arrQTable.removeAll()
      for child in snapshot.children
      {
        let Value:DataSnapshot = child as! DataSnapshot
        
        let  myValue = Value.value!
        
        if let dictionary  = myValue as? [String : Any]
        {
//          if (dictionary["lid"] as! NSString).integerValue == self.selectQ
            if (dictionary["lid"] as? Int)! == self.selectQ
          {
            self.arrQTable.append(dictionary)
          }
        }
      }
  
      print("Qall:\(self.arrQTable)")
      print("Qcount:\(self.arrQTable.count)")
      self.lblTitle.text = self.arrQTable.first?["Title"] as? String
      self.lblDesc.text = self.arrQTable.first?["Descrition"] as? String
      self.lblTimestamp.text = self.arrQTable.first?["TimeStamp"] as? String
      
    })
    
  }
  
    func readAList()
    {
      
        refA.observe(.value, with: { (snapshot) in
          
            self.arrTable.removeAll()
            for child in snapshot.children
            {
                let Value:DataSnapshot = child as! DataSnapshot
                
                let  myValue = Value.value!
                
                if let dictionary  = myValue as? [String : Any]
                {
                    if dictionary["QNoId"] as! Int == self.selectQ
                    {
                        self.arrTable.append(dictionary)
                    }
                }
            }
            self.tableOk = true
            self.tableView.reloadData()
            //選擇在第一行
 
//            self.tableView.selectRow(at: selIndexPath, animated: true, scrollPosition: .middle)
            print("all:\(self.arrTable)")
            print("count:\(self.arrTable.count)")
            self.totalReponse.text = "回應 \(self.arrTable.count)"
            
        })
        
    }
    
    
    @IBAction func unwindToQlistVC(segue:UIStoryboardSegue) { print ("回來Qlist VC") }
  
  
    @IBAction func tagRightButton(_ sender: Any)
    {
        print("按了")
        self.dismiss(animated: true, completion: nil)
    }
    
 
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "QACell", for: indexPath) as! QATableViewCell
        if (tableOk)
        {
//        cell.lblTitle.text = arrTable[indexPath.row]["Category"] as? String
            cell.lblDescription.text = arrTable[indexPath.row]["ResponseText"] as? String
        }
        return cell
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

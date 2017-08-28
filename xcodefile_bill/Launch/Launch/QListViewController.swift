import UIKit
import Firebase
import FirebaseDatabase

class QListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var ref : DatabaseReference!
    var arrTable = [[String:Any]]()
    var tableOk = false
    var selectQ = 2
    
    @IBOutlet weak var totalReponse: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
            ref = Database.database().reference(fromURL: "https://trainforswift-f4067.firebaseio.com/A")
        
        readQList()
        
        
      
        //透明NavigationBar背景
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    
    func readQList()
    {
        
        ref.observe(.value, with: { (snapshot) in
            
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

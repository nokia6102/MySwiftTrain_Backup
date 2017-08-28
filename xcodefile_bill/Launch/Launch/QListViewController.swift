import UIKit
import Firebase
import FirebaseDatabase

class QListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var aDic : [[String:Any]] = []
    var ref : DatabaseReference!
    var arrTable = [[String:Any]]()
    var tableOk = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
            ref = Database.database().reference(fromURL: "https://trainforswift-f4067.firebaseio.com/Q")
        
        readQList()
        
        
//        for i in 1 ... 50
//        {
//            let d  = ["Title":"標題\(i)","Lecture":"講座 \(i)", "Response":"回應\(i)"]
//            aDic.append(d)
//        }
//        print(aDic)
        
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
                    self.arrTable.append(dictionary)
                }
            }
            self.tableOk = true
//            self.tableView.reloadData()
            //選擇在第一行
            let selIndexPath = IndexPath(row: 0 , section: 0)
//            self.tableView.selectRow(at: selIndexPath, animated: true, scrollPosition: .middle)
            print("all:\(self.arrTable)")
            print("count:\(self.arrTable.count)")
            
            
        })
        
    }
    
    
    
    @IBAction func tagRightButton(_ sender: Any)
    {
        print("按了")
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aDic.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QACell", for: indexPath) as! QATableViewCell
        cell.lblTitle.text = aDic[indexPath.row]["Title"] as? String
        cell.lblDescription.text = "\(aDic[indexPath.row]["Lecture"] ?? "0") / \(aDic[indexPath.row]["Response"] ?? "0")"
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

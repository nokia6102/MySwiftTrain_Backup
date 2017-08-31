import UIKit
import Firebase
import FirebaseDatabase


class QAViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var aDic : [[String:Any]] = []
    var ref : DatabaseReference!
//    var arrTable = [[String:Any]]()
    var tableOk = false
    var selectQ = 0
    
    @IBOutlet weak var tableView: UITableView!
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference(fromURL: "https://trainforswift-f4067.firebaseio.com/QA")
        
        readQAList()
//
//        let d1  = ["Title":"SWift直通車:Swift&Objective-C混用","Lecture":"講座 1", "Response":"回應0"]
//        aDic.append(d1)
//        for i in 2 ... 99
//        {
//          let d  = ["Title":"SWift直通車:第\(i)天","Lecture":"講座 10\(i)", "Response":"回應0"]
//          aDic.append(d)
//        }
        print(aDic)
 
        //透明NavigationBar背景
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
    }
    

    func readQAList()
    {
        
        ref.observe(.value, with: { (snapshot) in
            
            self.aDic.removeAll()
            print ("=====")
            for child in snapshot.children
            {
                let Value:DataSnapshot = child as! DataSnapshot
                
                let  myValue = Value.value!
                
                if let dictionary  = myValue as? [String : Any]
                {
                    self.aDic.append(dictionary)
                }
            }
            self.tableOk = true
            self.tableView.reloadData()
 
            
            
        })
        
    }
    
    
    @IBAction func jumpToQA(_ sender: Any)
    {
        //強跳
        if let vc = storyboard?.instantiateViewController(withIdentifier: "sbPlayer")
        {
            present(vc, animated: true, completion: nil)
//            show(vc, sender: self)
        }
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        print ("aDic:\(aDic)")
        selectQ = (aDic[indexPath.row]["QAid"] as? Int)!
        print ("sQ:\(selectQ)")
         performSegue(withIdentifier: "sgQlist", sender: self)
        
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

    
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
      print("轉換到其他頁")
      
      if segue.identifier == "sgQlist"
      {
        print ("發動sgQlist")
        let nextVC = segue.destination as! QListViewController
        nextVC.firstVC = self
        print ("s1:\(self.selectQ)")
        nextVC.selectQ = self.selectQ
      }
      
    }
  

}

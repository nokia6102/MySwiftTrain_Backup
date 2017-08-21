
import UIKit


class QAViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var aDic : [[String:Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        for i in 1 ... 5
        {
          let d  = ["Title":"標題\(i)","Lecture":"講座 10\(i)", "Response":"回應\(i)"]
          aDic.append(d)
        }
        
        print(aDic)
 
  
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

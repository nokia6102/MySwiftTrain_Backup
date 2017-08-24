
import UIKit


class QAViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    var aDic : [[String:Any]] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let d1  = ["Title":"SWift直通車:Swift&Objective-C混用","Lecture":"講座 1", "Response":"回應0"]
        aDic.append(d1)
        for i in 2 ... 99
        {
          let d  = ["Title":"SWift直通車:第\(i)天","Lecture":"講座 10\(i)", "Response":"回應0"]
          aDic.append(d)
        }
        print(aDic)
 
        //透明NavigationBar背景
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
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



import UIKit

class AViewController: UIViewController {

  var preVC : QListViewController?
  
  @IBOutlet weak var txtName: UITextField!
  
  @IBOutlet weak var lblTimeStamp: UILabel!
  
  @IBOutlet weak var lblTitle: UILabel!
  
  @IBOutlet weak var lblDesc: UILabel!
 
  
    override func viewDidLoad() {
        super.viewDidLoad()

      txtName.text =  "some body"
      lblTimeStamp.text = preVC?.lblTimestamp.text
      lblTitle.text = preVC?.lblTitle.text
      lblDesc.text = preVC?.lblDesc.text
      
  }

  @IBAction func closeButton(_ sender: Any)
  {
    print("按了close")
    self.dismiss(animated: true, completion: nil)
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

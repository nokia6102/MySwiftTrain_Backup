import UIKit
import Firebase


class AViewController: UIViewController {

  var preVC : QListViewController?
  
  var ref,refA : DatabaseReference!
  @IBOutlet weak var txtName: UITextField!
  @IBOutlet weak var lblTimeStamp: UILabel!
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblDesc: UILabel!
  @IBOutlet weak var txtResponse: UITextView!
  var lid:Int?
    override func viewDidLoad() {
        super.viewDidLoad()

      txtName.text =  "some body"
      lblTimeStamp.text = preVC?.lblTimestamp.text
      lblTitle.text = preVC?.lblTitle.text
      lblDesc.text = preVC?.lblDesc.text
      lid = preVC?.lid
      print ("*lid :\(lid)")
      ref = Database.database().reference(fromURL: "https://trainforswift-f4067.firebaseio.com")
      refA = ref.child("A")
      
  }

  @IBAction func closeButton(_ sender: Any)
  {
    print("按了close")
    self.dismiss(animated: true, completion: nil)
  }

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      let refADic = refA.childByAutoId()
      let postInfo = [
                      "ResponseUserName": txtName.text!,
                      "ResponseText":txtResponse.text!,
                      "QNoId" : self.lid,
                      "Id" : self.lid ,
                      "Title": lblTitle.text!,
                      "TimeStamp": ServerValue.timestamp() ] as [String : Any]
      
      refADic.setValue(postInfo)
  
  
  }
  

}

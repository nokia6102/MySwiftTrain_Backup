import UIKit
import Firebase
import FirebaseDatabase

class TQViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
  
  
  @IBOutlet weak var txtInputQ:UITextView!
  @IBOutlet weak var pickView: UIPickerView!
  
  
    var ref ,refQ,refLesson : DatabaseReference!
    var arrTable = [[String:Any]]()
 
    var pickerOK = false
    var selectedValue:String = ""
    var selectL = 0
    override func viewDidLoad() {
        super.viewDidLoad()
     
      ref = Database.database().reference(fromURL: "https://trainforswift-f4067.firebaseio.com")
      refQ = ref.child("Q")
      refLesson = ref.child("Lesson")
      
      

        readLessionList()
      setDoneOnKeyboard()
    }

  @IBAction func unwindToTQVC(segue:UIStoryboardSegue) { print ("回來QTVC") }
  
  
  func readLessionList()
  {
    
    refLesson.observe(.value, with: { (snapshot) in
      
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
      self.pickerOK = true
      self.pickView.reloadAllComponents()
//      self.pick.reloadData()
      //選擇在第一行
//      let selIndexPath = IndexPath(row: 0 , section: 0)
//      self.tableView.selectRow(at: selIndexPath, animated: true, scrollPosition: .middle)
      print("all:\(self.arrTable)")
      print("count:\(self.arrTable.count)")
      
      
    })
    
  }

//  @IBAction func ss(_ sender: Any?) {
//    selectedValue = arrTable[pickView.selectedRow(inComponent: 0)]["title"] as! String
//  }
//  
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       selectedValue = arrTable[pickView.selectedRow(inComponent: 0)]["title"] as! String
       selectL = row
  }
  
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  arrTable.count
    }
  
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
      
      selectedValue = arrTable[pickView.selectedRow(inComponent: 0)]["title"] as! String

        return arrTable[row]["title"] as? String
    }
  
  func setDoneOnKeyboard() {
    let keyboardToolbar = UIToolbar()
    keyboardToolbar.sizeToFit()
    let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.dismissKeyboard))
    keyboardToolbar.items = [flexBarButton, doneBarButton]
    self.txtInputQ.inputAccessoryView = keyboardToolbar
  }
  
@IBAction  func dismissKeyboard() {
  print ("縮了鍵盤")
 //
//    
//    let childautoID = ref.key
//    print("childautoID:\(childautoID)資料已建立" )
    view.endEditing(true)
//    //do-to: 程式轉場
//    self.performSegue(withIdentifier: "content", sender: nil)
  
//  dismiss(animated: true, completion: nil)
 // self.performSegue(withIdentifier: "retQ", sender: self)
  }

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
      let refQlist = refQ.childByAutoId()
      
      let postInfo = ["Category" : "D1",
                      
                      "uid": "輸入者",
                      "Description":txtInputQ.text!,
                      "lid": selectL + 1,
                      "Id" : 5,
                      "Title": selectedValue,
                      "TimeStamp": ServerValue.timestamp() ] as [String : Any]
      
      refQlist.setValue(postInfo)

      dismissKeyboard()
      }
  

}

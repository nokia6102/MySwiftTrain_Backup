
import UIKit

class TQViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    var list1 = [String]()      //此處書上原為let，必須改為var，否則無法加入陣列元素
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //準備第一個陣列元素
        list1.append("課程:Swift&Objective-C混用")
        list1.append("除錯問題")
        list1.append("一般式問題")
        list1.append("程式問題")
        list1.append("觀念問題")
        list1.append("課程釋疑")
        list1.append("其他")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return  list1.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list1[row]
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

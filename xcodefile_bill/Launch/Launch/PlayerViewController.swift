import UIKit
import youtube_ios_player_helper
import Firebase
import FirebaseDatabase

class PlayerController: UIViewController,UITableViewDelegate,UITableViewDataSource,YTPlayerViewDelegate{
    
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var durtionTime: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var durntionTime: UILabel!
   
    @IBOutlet weak var playerTitle: UILabel!
    
//    weak var firstVC:UIViewController!
    weak var firstVC:MainViewController?
    var tableOk = false
    var ref : DatabaseReference!
    private var arrTable = [[String:Any]]()
    var playvideCode = "3AaTfGSfBmw"
    var selectVideo = 0
//    var cc = "0"
    var ccFlag = false
                                        //   加uiview中文放                     字幕                  放完不放連結 //                                            一用就會出現youtube水印
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
//        ccFlag = cc == "1"
        ref = Database.database().reference(fromURL: "https://trainforswift-f4067.firebaseio.com/SubTitle").child("101")
//        let playerVars: [AnyHashable: Any]  = [ "playsinline": 1 ,"cc_load_policy":1 ,"rel":0,"showinfo":1,"modestbranding":1 , "autoplay":1 ]
//        self.playerView.load(withVideoId: "3AaTfGSfBmw", playerVars: ["playsinline": 1])
       
        print ("trustfer selectVide : \(self.selectVideo)")
        let playCode = self.firstVC?.arrTable[selectVideo]["videocode"] as! String
        ccFlag = (self.firstVC?.arrTable[selectVideo]["cc"] as! String ) == "1"
        playerTitle.text = self.firstVC?.arrTable[selectVideo]["title"] as? String
        
        self.playerView.load(withVideoId: playCode,playerVars: ["playsinline": 1])
        self.playerView.delegate = self
       
   
        if ccFlag
        {
            readDic()
        }
        else
        {
            let endDic : Dictionary = ["totalStartTime": Float(self.playerView.duration()), "number": 1, "startTime": "00:00:03,670", "stopTime": "00:00:11,929", "text": "* 無字幕 *"
                ] as [String : Any]
            
            self.arrTable.append(endDic)
        }
    }
    
 
    
    func readDic()
    {
        
        ref.observe(.value, with: { (snapshot) in
            
            self.arrTable.removeAll()
            for child in snapshot.children
            {
                let Value:DataSnapshot = child as! DataSnapshot
                
                let  myValue = Value.value!
                
                if var dictionary  = myValue as? [String : Any]
                {
                    print(dictionary["number"] ?? "x")
                    let sourceTime = dictionary["startTime"] as! String
//                    print("s:\(sourceTime)")
                    let index = sourceTime.index(sourceTime.startIndex, offsetBy: 8)
                    let time  =  sourceTime.substring(to: index)
//                    print ("t:\(time)")
                    let partsTime = time.components(separatedBy: ":")
//                    print("p:\(partsTime)")
                    let totalTime = Int(partsTime[0])! * 3600 + Int(partsTime[1])! * 60 + Int(partsTime[2])!
                    print ("t:\(totalTime)")
                    dictionary["totalStartTime"] = Float(totalTime)
                    self.arrTable.append(dictionary)
                }
            }
            let endDic : Dictionary = ["totalStartTime": Float(self.playerView.duration()), "number": 1, "startTime": "00:00:03,670", "stopTime": "00:00:11,929", "text": "* 本片結束 *"
            ] as [String : Any]
            
            self.arrTable.append(endDic)
            
            print("all:\(self.arrTable)")
            print("count:\(self.arrTable.count)")
            self.tableView.reloadData()
            self.tableOk = true
            
         
            
            //選擇在第一行
            let selIndexPath = IndexPath(row: 0 , section: 0)
            self.tableView.selectRow(at: selIndexPath, animated: true, scrollPosition: .middle)
         
        })
     
    }

        
    @IBAction func tapPlay(_ sender: UIButton)
    {
        playerView.playVideo()
    }
    

    @IBAction func unwindToPlayerVC(segue:UIStoryboardSegue) { print ("回來") }
    
    //Mark:- YTPLayerViewDelegate
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
        print ("playTime :\(playTime)")
        
        if (tableOk && ccFlag)
        {
            let lastNumberOfSections = self.tableView.numberOfRows(inSection: 0)
            print ("lst:\(lastNumberOfSections)")
        
            let selectedIndexPath = tableView.indexPathForSelectedRow!.row
    
            print ("sel:\(selectedIndexPath)")
            if selectedIndexPath < lastNumberOfSections
            {
                print ("自動slip:\(selectedIndexPath)")
                let nextTime = arrTable[selectedIndexPath+1]["totalStartTime"] as! Float
                print ("nextTime:\(nextTime)")
             
                if playTime >= nextTime
                {
                    let indexPath = IndexPath(row: selectedIndexPath+1 , section: 0)
                    self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
                    self.tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
                }
            }
        }
     
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
         self.playerView.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {

        case .ended:
            self.playerView.stopVideo()
            break
        default:
             break
        }
        
    }
    
    //Mark:- tableView Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTable.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerTableViewCell
        cell.lblSubtitle.text = arrTable[indexPath.row]["text"] as? String
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if tableOk && ccFlag
        {
            if indexPath.row == arrTable.count - 1
            {
             self.playerView.stopVideo()
                let indexPath = IndexPath(row: 0 , section: 0)
                self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
            }
        }
        let toTime : Float = arrTable[indexPath.row]["totalStartTime"] as! Float
        playerView.seek(toSeconds: toTime, allowSeekAhead: true)
        let indexPath = IndexPath(row: indexPath.row , section: 0)
        self.tableView.scrollToRow(at: indexPath, at: UITableViewScrollPosition.middle, animated: true)
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

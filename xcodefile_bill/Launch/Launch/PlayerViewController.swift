
import UIKit
import youtube_ios_player_helper
class PlayerController: UIViewController,UITableViewDelegate,UITableViewDataSource,YTPlayerViewDelegate{
    
 
    @IBOutlet weak var playerView: YTPlayerView!
    
    @IBOutlet weak var btnPlay: UIButton!
//    let playerVars = ["playsinline": 1]
                                        //   加uiview中文放                     字幕                  放完不放連結
      let playerVars: [AnyHashable: Any]  = [ "playsinline": 1, "autoplay": 1 ,"cc_load_policy":1 ,"rel":0,
//                                            一用就會出現youtube水印
                                                 "showinfo":1,
    "modestbranding":1 ]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.playerView.load(withVideoId: "S9xzKII9yRw", playerVars: playerVars)
        self.playerView.delegate = self
    }
    
    @IBAction func tapPlay(_ sender: UIButton)
    {
        playerView.playVideo()
        btnPlay.isHidden = true
    }
    
    @IBAction func btnLoadList(_ sender: UIButton)
    {
        self.playerView.load(withPlaylistId: "PLNimSq2k6r46NtbwbHLjl9pjVidMPiTQ7", playerVars: playerVars)
        self.playerView.playVideo()
    }
    
    @IBAction func btnPrev(_ sender: Any)
    {
        self.playerView.previousVideo()
    }
    
    @IBAction func btnNext(_ sender: UIButton)
    {
        self.playerView.nextVideo()
    }
    
    //YTPLayerViewDelegate
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
        print ("playTime :\(playTime)")
      
        
        
        if Int(playTime) >= Int (playerView.duration())
        {
              btnPlay.isHidden = false
        }
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .ended:
             btnPlay.isHidden = false
        default:
             break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)
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

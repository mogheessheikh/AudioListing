//
//  AudioTableCell.swift
//  AudioListing
//
//  Created by Moghees on 14/07/2022.
//

import UIKit
import AVFoundation

class AudioTableCell: UITableViewCell {

    @IBOutlet weak var audioSlider: UISlider!
    @IBOutlet weak var btnPlayPause: UIButton!
    @IBOutlet weak var lblDuration: UILabel!
    var player:AVPlayer!
    var playerItem:AVPlayerItem?
    var identifier = "AudioTableCell"
   
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func configureAudio(url:URL){
       playAudio(url)
       
        
    }
    func playAudio(_ url:URL) {
        print("playing \(url)")
        audioSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(self.finishedPlaying(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerItem)
        do {
            playerItem = AVPlayerItem(url: url)
            let duration : CMTime = playerItem!.asset.duration
            let seconds : Float64 = CMTimeGetSeconds(duration)
            lblDuration.text = self.stringFromTimeInterval(interval: seconds)
            audioSlider.maximumValue = Float(seconds)
            audioSlider.isContinuous = true
            
            player = AVPlayer(playerItem: playerItem)
            player.volume = 1.0
            
            player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
            if self.player!.currentItem?.status == .readyToPlay {
            let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
            self.audioSlider.value = Float ( time );
            self.lblDuration.text = self.stringFromTimeInterval(interval: time)
            }
            let playbackLikelyToKeepUp = self.player?.currentItem?.isPlaybackLikelyToKeepUp
            if playbackLikelyToKeepUp == false{
            print("IsBuffering")
           
            }
            }
        } catch let error as NSError {
            self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func finishedPlaying( _ myNotification:NSNotification) {
        
    btnPlayPause.setImage(UIImage(named: "ic_play"), for: UIControl.State.normal)
    
    }
    @objc func sliderValueChanged(_ slider:UISlider) {
    let seconds : Int64 = Int64(slider.value)
    let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
    player!.seek(to: targetTime)
    if player!.rate == 0 {
    player?.play()
     }
    }

    @IBAction func didTapPlayPause(_ sender: Any) {
       // state.toggle()
        //btnPlayPause.setImage(state.icon, for: .normal)
    }
    
    func stringFromTimeInterval(interval: TimeInterval) -> String {
    let interval = Int(interval)
    let seconds = interval % 60
    let minutes = (interval / 60) % 60
    let hours = (interval / 3600)
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

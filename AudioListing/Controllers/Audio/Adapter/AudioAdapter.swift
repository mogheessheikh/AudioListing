//
//  AudioAdapter.swift
//  AudioListing
//
//  Created by Moghees on 14/07/2022.
//

import UIKit
import AVFoundation
class AudioAdapter: NSObject {
    
    weak var tableView: UITableView!
    var parent: AudioListController
    var audios = [URL]()
    var player: AVPlayer!
    var playerItem:AVPlayerItem?
    
    var state = PlayerState.stopped {
        didSet {
            switch state {
            case .playing: player.play()
            case .stopped: player.pause()
            }
        }
    }
    
    
    init(tableView:UITableView,parent: AudioListController){
        
        
        self.tableView = tableView
        self.parent = parent
        super.init()
        self.configure()
    }
    
    func configure() {
        let nib = UINib(nibName: "AudioTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: AudioTableCell().identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
   
    
    @objc func didTapPlayPause(sender: UIButton){
        
        player.volume = 1.0
        playerItem = AVPlayerItem(url:  audios[sender.tag])
        player = AVPlayer(playerItem: playerItem)
        player!.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main) { (CMTime) -> Void in
        if self.player!.currentItem?.status == .readyToPlay {
        let time : Float64 = CMTimeGetSeconds(self.player!.currentTime());
            
        let cell = self.tableView.cellForRow(at: IndexPath(item: sender.tag, section: 0)) as! AudioTableCell
        cell.audioSlider.value = Float ( time );
        cell.lblDuration.text = self.stringFromTimeInterval(interval: time)
        }
            
        let playbackLikelyToKeepUp = self.player?.currentItem?.isPlaybackLikelyToKeepUp
        if playbackLikelyToKeepUp == false{
        print("IsBuffering")
    }
        }
        self.state.toggle()
        sender.setImage(state.icon, for: .normal)
    }
    
    @objc func sliderValueChanged(_ slider:UISlider) {
    let seconds : Int64 = Int64(slider.value)
    let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
    player!.seek(to: targetTime)
    if player!.rate == 0 {
    player?.play()
     }
    }
    func stringFromTimeInterval(interval: TimeInterval) -> String {
    let interval = Int(interval)
    let seconds = interval % 60
    let minutes = (interval / 60) % 60
    let hours = (interval / 3600)
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

}

extension AudioAdapter : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audios.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AudioTableCell().identifier, for: indexPath) as! AudioTableCell
        playerItem = AVPlayerItem(url:  audios[indexPath.row])
        player = AVPlayer(playerItem: playerItem)
        cell.btnPlayPause.tag = indexPath.row
        cell.audioSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        cell.btnPlayPause.addTarget(self, action: #selector(didTapPlayPause(sender:)), for: .touchUpInside)
        let duration : CMTime = playerItem!.asset.duration
        let seconds : Float64 = CMTimeGetSeconds(duration)
        cell.lblDuration.text = self.stringFromTimeInterval(interval: seconds)
        cell.audioSlider.maximumValue = Float(seconds)
        cell.audioSlider.isContinuous = true
        //cell.configureAudio(url: audios[indexPath.row],player: player, playerItem: playerItem!)
        return cell
    }
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        let cell = tableView.dequeueReusableCell(withIdentifier: AudioTableCell().identifier, for: indexPath) as! AudioTableCell
        if player.rate != 0{
            self.state.toggle()
            cell.btnPlayPause.setImage(state.icon, for: .normal)
            
        }
    }
}


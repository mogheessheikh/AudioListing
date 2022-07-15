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
  
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   

    @IBAction func didTapPlayPause(_ sender: Any) {
       
    }

}

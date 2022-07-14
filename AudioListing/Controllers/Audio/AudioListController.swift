//
//  AudioListController.swift
//  AudioListing
//
//  Created by Moghees on 14/07/2022.
//

import UIKit
import MediaPlayer

class AudioListController: UIViewController,MPMediaPickerControllerDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func uploadAudioTapped(_ sender: UIButton) {
        
        let controller = MPMediaPickerController(mediaTypes: .music)
           controller.allowsPickingMultipleItems = true
           controller.popoverPresentationController?.sourceView = sender
           controller.delegate = self
           present(controller, animated: true)
    }
    
  

}

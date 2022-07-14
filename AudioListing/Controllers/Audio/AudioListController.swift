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
    var adapter:AudioAdapter!
    var audios = [URL]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adapter = AudioAdapter(tableView: tableView, parent: self)

    }
    
    @IBAction func uploadAudioTapped(_ sender: UIButton) {
        getAudioList()
    }
    
  
    func getAudioList() {

        AudioPicker.shared.open(from: self) { (url) in
            self.audios.append(url)
            self.adapter.audios = self.audios
            self.tableView.reloadData()
        
        }
}
}

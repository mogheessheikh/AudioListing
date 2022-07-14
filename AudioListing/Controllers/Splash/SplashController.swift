//
//  SplashController.swift
//  AudioListing
//
//  Created by Moghees on 14/07/2022.
//

import UIKit

class SplashController: UIViewController {

    @IBOutlet weak var lblVersion: UILabel!
    let versionNumber = Bundle.main.releaseVersionNumber
    let buildNumber = Bundle.main.buildVersionNumber
    weak var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()

        lblVersion.text = "Version \(versionNumber ?? "")(\(buildNumber ?? ""))"
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(showAudioListController(_:)), userInfo: nil, repeats: true)
    }
    
    @objc func showAudioListController(_ timer: Timer){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AudioListController") as! AudioListController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
}

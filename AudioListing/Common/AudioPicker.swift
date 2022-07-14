//
//  AudioPicker.swift
//  AudioListing
//
//  Created by Moghees on 14/07/2022.
//

import UIKit
import MobileCoreServices
import UniformTypeIdentifiers

class AudioPicker: NSObject {
    static let shared = AudioPicker()
    
    var completion: ((_ fileUrl: URL) -> Void)?
    
    func open(from controller: UIViewController, completion: @escaping (_ fileUrl: URL) -> Void) {
        
        self.completion = completion
        let audioPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.audio])
        audioPicker.delegate = self
        audioPicker.allowsMultipleSelection = true
        controller.present(audioPicker, animated: true, completion: nil)
        
    }
    
}
extension AudioPicker: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let url = urls.first {
            completion?(url)
        }
    }
}

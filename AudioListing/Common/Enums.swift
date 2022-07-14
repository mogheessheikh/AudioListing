//
//  Enums.swift
//  AudioListing
//
//  Created by Moghees on 14/07/2022.
//

import Foundation
import UIKit

enum PlayerState {
    case playing
    case stopped

    var icon: UIImage?{
        switch self{
            
        case .playing:
            return UIImage(named: "pause")
        case .stopped:
            return UIImage(named: "play")
        }
        
    }
    mutating func toggle() {
        switch self {
        case .playing: self = .stopped
        case .stopped: self = .playing
        }
    }
}

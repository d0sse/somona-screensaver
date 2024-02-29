//
//  SomonaScreenSaverView.swift
//  SomonaScreen
//
//  Created by d0sse Uribe on 28/02/24.
//  Copyright © 2024 d0sse. All rights reserved.
//

import Cocoa
import ScreenSaver
import AVKit

class SomonaScreenSaverView: ScreenSaverView {
    
    
    var player: AVPlayer?
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        initializePlayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializePlayer()
    }
    
    func initializePlayer() {
        guard let videoURL = Bundle(for: type(of: self)).url(forResource: "somona", withExtension: "mov") else {
            return
        }
        let playerItem = AVPlayerItem(url: videoURL)
        player = AVPlayer(playerItem: playerItem)
        
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.frame = bounds
        layer?.addSublayer(playerLayer)
        
        player?.play()
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: playerItem, queue: nil) { [weak self] _ in
            self?.player?.seek(to: .zero)
            self?.player?.play()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

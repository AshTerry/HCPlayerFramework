//
//  ViewController.swift
//  HCPlayerFramework
//
//  Created by hc on 10/27/2022.
//  Copyright (c) 2022 hc. All rights reserved.
//

import UIKit
import HCAudioPlayer

class ViewController: UIViewController {
    
    private let appid = "6635E33E5775ECAE"
    private let secret = "LlrjO93bv8a5L0HbP0BcedRB+Ex1iiNGXi2JCZl757k="
    
    private lazy var player = {
        let player = try? Player(appid, secret: secret)
        player?.delegate = self
        return player
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let noteName = Notification.Name(rawValue:HCPlayerNotification.TimeTickNotification.rawValue)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(listenTimeTick(note:)),
                                               name: noteName,
                                               object: nil)
        
        self.player?.clearCache()
        
        if let path = Bundle.main.path(forResource: "plan", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe),
           let str = String.init(data: data, encoding: .utf8) {
            self.player?.updateConfigure(str)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func listenTimeTick(note: Notification) {
        guard let userInfo = note.userInfo,
              let tick: Int = userInfo["tick"] as? Int  else {
            return
        }
         
        debugPrint("tick:\(tick)")
    }

}

extension ViewController : HCPlayerDelegate {
    
    func onPlayerStop(player: HCAudioPlayer.Player) {
        print(#function)
    }
    
    func onPlayerPaused(player: HCAudioPlayer.Player) {
        print(#function)

    }
    
    func onPlayerStarted(player: HCAudioPlayer.Player) {
        print(#function)

    }
    
    func onAllFileDidDownload(_ player: HCAudioPlayer.Player, succeed: Set<String>, failed: Set<String>) {
        print(#function)

        player.play()
    }
    
    func onSomeCacheDidFinish(_ player: HCAudioPlayer.Player) {
        print(#function)

    }
    
}

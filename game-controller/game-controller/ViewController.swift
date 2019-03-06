//
//  ViewController.swift
//  game-controller
//
//  Created by Atharva Patil on 04/03/2019.
//  Copyright © 2019 Atharva Patil. All rights reserved.
//

import UIKit
import WebKit

// include the Cocoa pod socket library
import Starscream

// direction commands
enum DirectionCode: String {
    case up = "0"
    case right = "1"
    case down = "2"
    case left = "3"
}

class ViewController: UIViewController, WebSocketDelegate, UITextFieldDelegate {
    
    // Object for managing the web socket.
    var socket: WebSocket?
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.149, green: 0.1961, blue: 0.2196, alpha: 1.0) /* #263238 */
        
        // Web socket setup
        // URL of the websocket server.
        let urlString = "wss://gameserver.mobilelabclass.com"
        // create the websocket
        socket = WebSocket(url: URL(string: urlString)!)
        // Assign WebSocket delegate to self
        socket?.delegate = self
        
        // Set up swipe gestures
        // swipe right
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        // swipe left
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        // swipe up
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        // swipe down
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        
        
    }
    
    @objc func respondToSwipe(gesture: UIGestureRecognizer){
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        webView.load(URLRequest(url: URL(string: "https://game.mobilelabclass.com/")!))
        
        
    }
    
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("✅ Connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("🛑 Disconnected:", error ?? "No message")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("⬇️ websocket did receive message:", text)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("<<< Received data:", data)
    }
    

}


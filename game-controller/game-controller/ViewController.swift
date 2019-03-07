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
    
    @IBOutlet weak var directionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.1294, green: 0.1294, blue: 0.1294, alpha: 1.0) /* #212121 */
        
        // Web socket setup
        // URL of the websocket server.
        let urlString = "wss://gameserver.mobilelabclass.com"
        // create the websocket
        socket = WebSocket(url: URL(string: urlString)!)
        // Assign WebSocket delegate to self
        socket?.delegate = self
        
        recogniseSwipe()
        
        // Connect.
        socket?.connect()
        
        
    }
    
    func recogniseSwipe(){
        
        // Setting up variables to detect swipe action
        
        // swipe right
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(changeDirection))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        // swipe left
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(changeDirection))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        
        // swipe up
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(changeDirection))
        swipeUp.direction = UISwipeGestureRecognizer.Direction.up
        self.view.addGestureRecognizer(swipeUp)
        
        // swipe down
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(changeDirection))
        swipeDown.direction = UISwipeGestureRecognizer.Direction.down
        self.view.addGestureRecognizer(swipeDown)
        
    }
    
    @objc func changeDirection(gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                
                // swipe right
                // print("Right")
                setDirectionMessage(.right)
                directionLabel.text = "right"
                
            case UISwipeGestureRecognizer.Direction.left:
                
                // swipe left
                // print("Left")
                setDirectionMessage(.left)
                directionLabel.text = "left"
                
            case UISwipeGestureRecognizer.Direction.up:
                
                // swipe up
                // print("Up")
                setDirectionMessage(.up)
                directionLabel.text = "up"
                
            case UISwipeGestureRecognizer.Direction.down:
                
                // swipe down
                // print("Swiped Down")
                setDirectionMessage(.down)
                directionLabel.text = "down"
                
            default:
                break
            }
        }
        
    }
    
    func setDirectionMessage(_ code: DirectionCode) {
        // Get the raw string value from the DirectionCode enum
        // that we created at the top of this program.
        sendMessage(code.rawValue)
    }
    
    // send message to the websocket
    func sendMessage(_ message: String){
        
        // Defining a valid player with a username
        let playerID = "atharva"
        
        // prepare server message
        let message = "\(playerID), \(message)"
        // send message to the websocket
        socket?.write(string: message){
            print("this message was send to the server:", message)
        }
        
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


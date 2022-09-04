//
//  SecondViewController.swift
//  MultithreadingGCDAsyncAfterConcurrentPerformInitiallyInactive
//
//  Created by Сергей Бей on 04.09.2022.
//

import UIKit

final class SecondViewController: UIViewController {
    override func viewDidLoad() {
//        for i in 0...2000000 {
//            print(i)
//        }
        
        let queue = DispatchQueue(label: "test", qos: .utility, attributes: .concurrent)
        queue.sync {
            DispatchQueue.concurrentPerform(iterations: 9000) {
                print("\($0) times")
                print(Thread.current)
            }
        }
        inactiveQueue()
    }
    
    
    func inactiveQueue() {
        let queue = DispatchQueue(label: "InactiveQueue", qos: .utility, attributes: [.concurrent, .initiallyInactive])
        queue.async {
            print("Done task!")
        }
        queue.activate()
        print("Activate!")
        queue.suspend()
        print("Pause!")
        queue.resume()
    }
    
}

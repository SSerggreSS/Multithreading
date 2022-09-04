//
//  ViewController.swift
//  MultithreadingGCDAsyncAfterConcurrentPerformInitiallyInactive
//
//  Created by Сергей Бей on 04.09.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        afterBlock(seconds: 4, queue: .main) {
//            self.showAlert()
//            print("Hello Thread")
//            print(Thread.current)
//        }
        
//        afterBlock(seconds: 3) {
//            print("Hello Thread")
//            print(Thread.current)
//        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Hello", message: "!!!!!!!!", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
            present(alert, animated: true)
    }
    
    private func afterBlock(
        seconds: Int,
        queue: DispatchQueue = DispatchQueue.global(),
        completion: @escaping () -> ()
    ) {
        queue.asyncAfter(deadline: .now() + .seconds(seconds)) {
            completion()
        }
    }


}


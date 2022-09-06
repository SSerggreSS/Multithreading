import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

final class DispatchWorkItem1 {
    private let queue = DispatchQueue(label: "DispatchWorkItem1", qos: .utility, attributes: .concurrent)
    
    func create() {
        
        let workItem = DispatchWorkItem {
            print(Thread.current)
            print("Start task")
        }
        
        workItem.notify(queue: .main) {
            print(Thread.current)
            print("Finish task")
        }
        
        queue.async(execute: workItem)
    }
}

//let workItem1 = DispatchWorkItem1()
//workItem1.create()

final class DispatchWorkItem2 {
    private let queue = DispatchQueue(label: "DispatchWorkItem2")
    
    func create() {
        queue.async {
            sleep(2)
            print(Thread.current)
            print("Task 1")
        }
        
        queue.async {
            sleep(2)
            print(Thread.current)
            print("Task 2")
        }
        
        let workItem = DispatchWorkItem {
            sleep(2)
            print(Thread.current)
            print("Start work tasks 3")
        }
        
        queue.async(execute: workItem)
        workItem.cancel()
        
    }
}

//let workItem2 = DispatchWorkItem2()
//workItem2.create()


let view = UIView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 800, height: 800))
imageView.backgroundColor = .orange
imageView.contentMode = .scaleAspectFit
view.addSubview(imageView)
PlaygroundPage.current.liveView = view

let url = URL(string: "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!

//classic

func fetchImage() {
    let queue = DispatchQueue.global(qos: .utility)
    
    queue.async {
        if let data = try? Data(contentsOf: url) {
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data)
            }
        }
    }
}

//fetchImage()


//DispatchWorkItem

func fetchImageWithWorkItem() {
    var data: Data?
    let queue = DispatchQueue.global(qos: .utility)
    
    let workItem = DispatchWorkItem(qos: .userInitiated) {
        print(Thread.current)
        data = try? Data(contentsOf: url)
    }
    
    queue.async(execute: workItem)
    
    workItem.notify(queue: .main) {
        if let imageData = data {
            print(Thread.current)
            imageView.image = UIImage(data: imageData)
        }
    }
}

//fetchImageWithWorkItem()


//URLSession

func fetchImageWithUrlSession() {
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        print(Thread.current)
        DispatchQueue.main.async {
            print(Thread.current)
            if let imageData = data {
                imageView.image = UIImage(data: imageData)
            }
        }
    }
    task.resume()
}

fetchImageWithUrlSession()

import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

final class DispatchGroupTest {
    private let serialQueue = DispatchQueue(label: "SerialQueue")
    private let redGroup = DispatchGroup()
    
    func loadInfo() {
        serialQueue.async(group: redGroup, qos: .utility) {
            sleep(1)
            print("1")
            print(Thread.current)
        }
        
        serialQueue.async(group: redGroup, qos: .utility) {
            sleep(1)
            print("2")
            print(Thread.current)
        }
        
        redGroup.notify(queue: .main) {
            print("redGroup finished")
            print(Thread.current)
        }
    }
}

let dispatchGroupTest = DispatchGroupTest()
//dispatchGroupTest.loadInfo()

final class DispatchGroupTest2 {
    private let concurrentQueue = DispatchQueue(label: "SerialQueue", attributes: .concurrent)
    private let redGroup = DispatchGroup()
    
    func loadInfo() {
        concurrentQueue.async(group: redGroup, qos: .utility) {
            Thread.sleep(forTimeInterval: 1)
            print("1")
            print(Thread.current)
        }
        
        concurrentQueue.async(group: redGroup, qos: .utility) {
            Thread.sleep(forTimeInterval: 1)
            print("2")
            print(Thread.current)
        }
        
        concurrentQueue.async(group: redGroup, qos: .utility) {
            Thread.sleep(forTimeInterval: 1)
            print("3")
            print(Thread.current)
        }
        
        concurrentQueue.async(group: redGroup, qos: .utility) {
            Thread.sleep(forTimeInterval: 1)
            print("4")
            print(Thread.current)
        }
        
        redGroup.notify(queue: .main) {
            print("redGroup finished")
            print(Thread.current)
        }
    }
}

let dispatchGroup2 = DispatchGroupTest2()
//dispatchGroup2.loadInfo()

final class DispatchGroupTest3 {
    private let concurrentQueue = DispatchQueue(label: "SerialQueue", attributes: .concurrent)
    private let blackGroup = DispatchGroup()
    
    func loadInfo() {
        blackGroup.enter()
        concurrentQueue.async {
            sleep(1)
            print(1)
            self.blackGroup.leave()
        }
        
        blackGroup.enter()
        concurrentQueue.async {
            sleep(2)
            print(2)
            self.blackGroup.leave()
        }
        
        blackGroup.enter()
        concurrentQueue.async {
            sleep(3)
            print(3)
            self.blackGroup.leave()
        }
        
        blackGroup.wait()
        
        print("Finish all")
        
        blackGroup.notify(queue: .main) {
            print("Notify main, finish all")
        }
    }
}

let dispatchGroupTest3 = DispatchGroupTest3()
//dispatchGroupTest3.loadInfo()

class ImagesView: UIView {
    var array = [UIImageView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        array.append(contentsOf: [
            UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 100)),
            UIImageView(frame: CGRect(x: 0, y: 100, width: 100, height: 100)),
            UIImageView(frame: CGRect(x: 100, y: 0, width: 100, height: 100)),
            UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100)),
            
            UIImageView(frame: CGRect(x: 0, y: 300, width: 100, height: 100)),
            UIImageView(frame: CGRect(x: 100, y: 300, width: 100, height: 100)),
            UIImageView(frame: CGRect(x: 0, y: 400, width: 100, height: 100)),
            UIImageView(frame: CGRect(x: 100, y: 400, width: 100, height: 100)),
        ])
        array.forEach { self.addSubview($0) }
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

let view = ImagesView(frame: CGRect(x: 0, y: 0, width: 600, height: 800))

PlaygroundPage.current.liveView = view

let imagesUrls = [
    "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",
    "http://bestkora.com/IosDeveloper/wp-content/uploads/2016/12/Screen-Shot-2017-01-17-at-9.33.52-PM.png",
    "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg",
    "http://bestkora.com/IosDeveloper/wp-content/uploads/2016/12/Screen-Shot-2017-01-17-at-9.33.52-PM.png"
]

func asyncGetImage(
    imageUrl: URL,
    runDispatchQueue: DispatchQueue,
    completionQueue: DispatchQueue,
    completion: @escaping (UIImage?, Error?) -> ()
) {
    runDispatchQueue.async {
        do {
            if let data = try? Data(contentsOf: imageUrl) {
                completionQueue.async {
                    completion(UIImage(data: data), nil)
                }
            }
        } catch let error {
            completionQueue.async {
                completion(nil, error)
            }
        }
    }
}
var images = [UIImage]()
func asyncGroup() {
    let group = DispatchGroup()
    for i in imagesUrls {
        group.enter()
        guard let url = URL(string: i) else { return }
        asyncGetImage(
            imageUrl: url,
            runDispatchQueue: .global(),
            completionQueue: .main
        ) { image, error in
            defer {
                group.leave()
            }
            guard let image = image else { return }
            images.append(image)
        }
    }
    
    group.notify(queue: .main) {
        for i in 0..<images.count {
            view.array[i].image = images[i]
        }
    }
}
//asyncGroup()

func getAsyncImageWithURLSession() {
    for (i,urlString) in imagesUrls.enumerated() {
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                sleep(1)
                DispatchQueue.main.async {
                    view.array[i].image = UIImage(data: data)
                }
            }
        }
        task.resume()
    }
}

//getAsyncImageWithURLSession()






















import UIKit
import PlaygroundSupport


final class CustomQueue {
    static let serialQueue = DispatchQueue(label: "serialQueue")
    static let cuncurrentQueue = DispatchQueue(label: "cuncurrentQueue", attributes: .concurrent)
}

final class SystemQueue {
    private let serialQueue = DispatchQueue.main
    private let globalQueue = DispatchQueue.global()
}

final class ViewController: UIViewController {
    
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initButton()
        self.title = "ViewController"
    }
    
    private func initButton() {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 60)
        button.center = view.center
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        button.setTitle("Press", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Pressed", for: .highlighted)
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func tapped() {
        print(#function)
        let vc = SecondViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

final class SecondViewController: UIViewController {
    
    private let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        loadImage()
    }
    
    private func loadImage() {
        guard let url = URL(string: "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")
        else { return }
        
        let queue = DispatchQueue.global(qos: .utility)
        let mainQueue = DispatchQueue.main
        
        queue.async {
            print(queue)
            if let data = try? Data(contentsOf: url) {
                mainQueue.async {
                    print("show image")
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.title = "SeconViewController"
        initImageView()
    }
    
    private func initImageView() {
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        imageView.center = view.center
    }
}

let vc = ViewController()
let navBar = UINavigationController(rootViewController: vc)

PlaygroundPage.current.liveView = navBar

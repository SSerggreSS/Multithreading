import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true
/*
let queue = DispatchQueue(label: "Queue", attributes: .concurrent)
let semaphore = DispatchSemaphore(value: 1)

queue.async {
    semaphore.wait() //-1
    sleep(2)
    print(Thread.current)
    print("Task 1")
    semaphore.signal() //+1
}

queue.async {
    semaphore.wait() //-1
    sleep(2)
    print(Thread.current)
    print("Task 2")
    semaphore.signal() //+1
}

queue.async {
    semaphore.wait() //-1
    sleep(2)
    print(Thread.current)
    print("Task 3")
    semaphore.signal() //+1
}

queue.async {
    semaphore.wait() //-1
    sleep(2)
    print(Thread.current)
    print("Task 4")
    semaphore.signal() //+1
}

let sem = DispatchSemaphore(value: 0)
sem.signal()
DispatchQueue.concurrentPerform(iterations: 11) { id in
    sem.wait(timeout: DispatchTime.distantFuture)
    sleep(1)
    print(Thread.current)
    print("Block:", String(id))
    sem.signal()
}
*/
final class SemaphoreTest {
    private let semaphore = DispatchSemaphore(value: 3)
    private var array = [Int]()
    
    private func methodWork(id: Int) {
        semaphore.wait() //-1
        
        array.append(id)
        print("Array:", array.count, array)
        Thread.sleep(forTimeInterval: 1)
        
        semaphore.signal() //+1
    }
    
    func startAllQueues() {
        DispatchQueue.global().async {
            self.methodWork(id: 0)
            print(Thread.current)
        }
       
        DispatchQueue.global().async {
            self.methodWork(id: 1)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(id: 2)
            print(Thread.current)
        }
        DispatchQueue.global().async {
            self.methodWork(id: 3)
            print(Thread.current)
        }
        
    }
}

let semaphoreTest = SemaphoreTest()
semaphoreTest.startAllQueues()

func anagramm(firstString: String, secondString: String) -> Bool {
    var firstDict = [Character: Int]()
    var secondDict = [Character: Int]()
    var firstCount = 0
    var secondCount = 0
    
    for i in firstString {
        if firstDict[i] == nil {
            firstDict[i] = 1
        } else {
            firstDict[i]! += 1
        }
    }
    for (_,v) in firstDict {
        firstCount += v
    }
    
    for i in secondString {
        if secondDict[i] == nil {
            secondDict[i] = 1
        } else {
            secondDict[i]! += 1
        }
    }
    for (_,v) in secondDict {
        secondCount += v
    }
    print(firstDict, firstCount)
    print(secondDict, secondCount)
    return false
}

anagramm(firstString: "heleloo", secondString: "olleh")


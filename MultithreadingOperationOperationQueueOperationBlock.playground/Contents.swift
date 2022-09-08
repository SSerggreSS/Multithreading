import Foundation
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

//let operationBlock = {
//    print("Start")
//    print(Thread.current)
//    print("Finished")
//}
//
//let operationQueue = OperationQueue()
//operationQueue.addOperation(operationBlock)

//print(Thread.current)
//
//let operationQueue = OperationQueue()
//var result: String?
//let concatOperation = BlockOperation {
//    result = "String" + "test" + "!!!"
//    print(Thread.current)
//}
//
//operationQueue.addOperation(concatOperation)

//print(Thread.current)
//
//var array = [Int]()
//
//let operationQueue = OperationQueue()
//let semaphore = DispatchSemaphore(value: 2)
//operationQueue.addOperation {
//    print(Thread.current)
//    array.append(0)
//    array.append(1)
//}
//
//operationQueue.addOperation {
//    print(Thread.current)
//    array.append(2)
//    array.append(3)
//
//}
//
//operationQueue.addOperation {
//    print(Thread.current)
//    array.append(4)
//    array.append(5)
//}

final class MyThread: Thread {
    override func main() {
        print(Thread.current)
        print("Test MyThread")
    }
}

final class MyOperation: Operation {
    override func main() {
        print(Thread.current)
        print("Test MyOperation")
    }
}

let myThread = MyThread()
myThread.start()

let myOperation = MyOperation()
myOperation.start()



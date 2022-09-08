import UIKit

var operationQueue = OperationQueue()

final class OperationCancel: Operation {
    override func main() {
        if isCancelled {
            print(isCancelled)
            return
        }
        print("Test 1")
        sleep(1)
        
        if isCancelled {
            print(isCancelled)
            return
        }
        print("Test 2")
        sleep(1)
    }
}

func cancelledOperation() {
    let operation = OperationCancel()
    operationQueue.addOperation(operation)
    operation.cancel()
}
//cancelledOperation()

final class WaitOperation{
    private let operationQueue = OperationQueue()
    func test() {
        operationQueue.addOperation {
            print(Thread.current)
            sleep(1)
            print("Test 1")
        }
        operationQueue.addOperation {
            print(Thread.current)
            sleep(2)
            print("Test 2")
        }
        operationQueue.waitUntilAllOperationsAreFinished()
        operationQueue.addOperation {
            print(Thread.current)
            print("Test 3")
        }
        operationQueue.addOperation {
            print(Thread.current)
            print("Test 4")
        }
    }
}

let waitOperation = WaitOperation()
//waitOperation.test()

final class WaitOperations {
    private let queue = OperationQueue()
    
    func test() {
        queue.maxConcurrentOperationCount = 1
        let operation1 = BlockOperation {
            print(Thread.current)
            sleep(1)
            print("Test 1")
        }
        let operation2 = BlockOperation {
            print(Thread.current)
            sleep(1)
            print("Test 2")
        }
        let operation3 = BlockOperation {
            print(Thread.current)
            sleep(1)
            print("Test 3")
        }
        queue.addOperations([operation1, operation2, operation3], waitUntilFinished: true)
        
        let operation4 = BlockOperation {
            print(Thread.current)
            sleep(1)
            print("Test 4")
        }
        let operation5 = BlockOperation {
            print(Thread.current)
            sleep(1)
            print("Test 5")
        }
        let operation6 = BlockOperation {
            print(Thread.current)
            sleep(1)
            print("Test 6")
        }
        
        queue.addOperations([operation4, operation5, operation6], waitUntilFinished: true)
    }
}

let waitOp = WaitOperations()
//waitOp.test()

final class CompletionBlock {
    private let queue = OperationQueue()
    
    func test() {
        let block = BlockOperation(block: {
            print("Some Task")
        })
        block.completionBlock = {
            print("Completion Block Finished")
        }
        queue.addOperation(block)
        let image = UIImage()
        image.images
    }
}

let completionBlock = CompletionBlock()
completionBlock.test()

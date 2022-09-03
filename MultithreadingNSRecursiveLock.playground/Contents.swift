import Foundation
//MARK: - C

final class RecursiveMutex {
    
    private var mutex = pthread_mutex_t()
    private var attribute = pthread_mutexattr_t()
    
    init() {
        pthread_mutexattr_init(&attribute)
        pthread_mutexattr_settype(&attribute, PTHREAD_MUTEX_RECURSIVE)
        pthread_mutex_init(&mutex, &attribute)
    }
    
    func firsTask() {
        defer {
            pthread_mutex_unlock(&mutex)
        }
        pthread_mutex_lock(&mutex)
        secondTask()
    }
    
    private func secondTask() {
        defer {
            pthread_mutex_unlock(&mutex)
        }
        pthread_mutex_lock(&mutex)
        print("Finish")
    }
}

let recursiveMutex = RecursiveMutex()
recursiveMutex.firsTask()


// MARK: - Swift

final class RecursiveThread: Thread {
    
    private let recursiveLock = NSRecursiveLock()
    
    override func main() {
        defer {
            recursiveLock.unlock()
            print("Exit main")
        }
        recursiveLock.lock()
        print("Thread is lock")
        task()
    }
    
    private func task() {
        defer {
            recursiveLock.unlock()
            print("Exit task")
        }
        recursiveLock.lock()
        print("Thread is lock")
    }
}

let recursiveThread = RecursiveThread()
recursiveThread.start()

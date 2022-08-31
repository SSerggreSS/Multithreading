import UIKit

// Thread
// Operation
// GCD

// Паралельный поток
//1Thread ------------
//2Thread ------------

// Последовательный поток - пока задача в первом потоке не закончится задача во втором потоке не начнется
//1Thread ---  --- - -
//2Thread    --   - - -

// Асинхронный поток
// Main    ----------
// 2Thread    -


//Unix - POSIX

var thread = pthread_t(bitPattern: 0) // create thread
var attribut = pthread_attr_t() // create attribut

pthread_attr_init(&attribut)

pthread_create(&thread, &attribut, { pointer in
    print("test hello from pthread_create(&thread, &attribut, { pointer in")
    return nil
}, nil)

// Thread

var nsThread = Thread {
    print("test Thread")
}
nsThread.threadPriority = 1
nsThread.start()
//nsThread.cancel()

var nsThread2 = Thread {
    print("test Thread")
}

nsThread2.threadPriority = 2
nsThread2.start()
//nsThread2.cancel()














































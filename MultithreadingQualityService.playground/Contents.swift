import UIKit

// C
var pthread = pthread_t(bitPattern: 0)
var attribute = pthread_attr_t()

pthread_attr_init(&attribute)
pthread_attr_set_qos_class_np(&attribute, QOS_CLASS_USER_INITIATED, 0)

pthread_create(&pthread, &attribute, { pointer in
    print("test")
    return nil
}, nil)

// Swift
var nsThread = Thread {
    print("test")
    print(qos_class_self())
}
nsThread.qualityOfService = .userInteractive
nsThread.start()

print(qos_class_main())


import UIKit
import Foundation

class SendOperation:Operation{
    
    var message:String?
    
    init(message:String){
        super.init()
        self.message = message
        print("SendOperation --->>init")
    }
    
    override func main() {
        print(self.message)
        print("main --->>init")
        sleep(3)
    }
}


func send(message:String){
    let oparationQue = OperationQueue()
    let sendOperation = SendOperation(message: message)
    var identifire:UIBackgroundTaskIdentifier!
    identifire = UIApplication.shared.beginBackgroundTask(expirationHandler: {
        print("expirationHandler")

        sendOperation.cancel()
        print("Message not sent, please resend")
    })
    
    sendOperation.completionBlock = {
        print("completionBlock")
        UIApplication.shared.endBackgroundTask(identifire)
    }
    oparationQue.addOperation(sendOperation)
}

//send(message: "hello world")

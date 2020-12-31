import SwiftUI

var timer : Timer? = nil
var counter = 0


func prozessTimer() {
    counter += 1
    print("This is a second ", counter)

}

func viewDidLoad() {
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: <#T##(Timer) -> Void#>)

}

print(viewDidLoad())

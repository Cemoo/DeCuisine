import Foundation
import UIKit

extension UINavigationController {
    
    /**
     Pops a view controller from navigation controller list.
     
     - Parameter animated: Default true
     
     ### Usage Example: ###
     ````
     navigationController.pop()
     navigationController.pop(false)
     ````
     
     - Returns: None.
     */
    func pop(_ animated: Bool = true) {
        _ = self.popViewController(animated: animated)
    }

    /**
     Pops to the root of navigation controller.
     
     - Parameter animated: Default true
     
     ### Usage Example: ###
     ````
     navigationController.popToRoot()
     navigationController.popToRoot(false)
     ````
     
     - Returns: None.
     */
    func popToRoot(_ animated: Bool = true) {
        _ = self.popToRootViewController(animated: animated)
    }
    
    /**
     Pops multiple view controllers from navigation controller list.
     
     - Parameter times: Decides how many controllers will be pop.
     - Parameter animated: Default true
     
     ### Usage Example: ###
     ````
     navigationController.popMulti(2)
     navigationController.popMulti(2, false)
     ````
     
     - Returns: None.
     */
    func popMulti(_ times: Int, animated: Bool = true) {
        let vcArr = self.viewControllers
        let indx = vcArr.count - (times + 1)
        self.popToViewController(vcArr[indx], animated: true)
    }
    
}

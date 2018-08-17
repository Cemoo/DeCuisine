
import UIKit

/// Loading class is a simple loader which will be used while service returns a value.
open class Loading: UIView {
    
    /// Custom superview
    fileprivate static weak var customSuperview: UIView? = nil
    /// Loading view will be used as transparent background
    let loadingView = UIView()
    /// An activity indicator to show user the app has no crash or freeze sitution.
    let actInd = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
    
    /// Loading Singleton
    open class var shared: Loading {
        /// Singleton struct
        struct Singleton {
            /// Loading instance has the same frame with device screen
            static let instance = Loading(frame: CGRect(x: 0 ,y: 0, width: getWidth(), height: getHeight()))
        }
        return Singleton.instance
    }
    
    // InitX
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.alpha = 0.0
        loadingView.backgroundColor = .black
        loadingView.alpha = 0.6
        addSubview(loadingView)
        actInd.center = loadingView.center
        actInd.startAnimating()
        addSubview(actInd)
        UIView.animate(withDuration: 0.4, animations: {
            self.alpha = 1.0
        })
    }
    
    /**
     Shows Loading view
     
     - Returns: None.
     */
    open class func show() {
        DispatchQueue.main.async {
            UIApplication.shared.keyWindow?.addSubview(loadingInstance)
        }
    }
    /**
     Hides Loading view
     
     - Returns: None.
     */
    open class func hide() {
        loadingInstance.removeFromSuperview()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("fataaal error coder fln")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if let containerView = Loading.containerView() {
            Loading.shared.frame = containerView.bounds
            self.loadingView.frame = containerView.frame
            self.actInd.center = containerView.center
        }
        
    }
    
    /**
     Custom view / Key window
     
     - Returns: UIView
     */
    fileprivate static func containerView() -> UIView? {
        return customSuperview ?? UIApplication.shared.keyWindow
    }
    
}

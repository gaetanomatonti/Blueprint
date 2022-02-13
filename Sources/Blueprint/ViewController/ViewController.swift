#if canImport(UIKit)
import UIKit
#endif

/// A `UIViewController` that manages a `ModellableView`.
open class ViewController<V: ModellableView>: UIViewController {
  /// The view model of the `rootView`.
  public var viewModel: V.VM? {
    didSet {
      rootView.viewModel = viewModel
    }
  }
  
  /// The root view of the view controller.
  public var rootView: V {
    guard let view = view as? V else {
      fatalError("View could not be downcasted to \(String(describing: V.self))")
    }
    
    return view
  }
  
  // MARK: - Lifecycle
  
  open override func loadView() {
    let _view = V()

    if let _view = _view as? any ViewControllerModellableView {
      _view.viewController = self
    }

    _view.setup()
    _view.style()
        
    view = _view
    
    if let rootView = rootView as? ConstraintBasedView {
      rootView.layout()
    }
  }
  
  open override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    if let rootView = rootView as? CustomNavigationStyle {
      rootView.styleNavigationBar()
    }

    if let rootView = rootView as? CustomTabBarStyle {
      rootView.styleTabBar()
    }
  }
}

import Foundation
#if canImport(UIKit)
import UIKit
#endif

private var viewControllerKey = "modellableview_view_controller_key"

/// A protocol that defines requirements for a `ModellableView` managed by a `ViewController`.
public protocol ViewControllerModellableView: ViewControllerView, ModellableView {}

/// A protocol that defines requirements for a `UIView` managed by a `ViewController`
public protocol ViewControllerView: UIView {}

extension ViewControllerView {
  /// The `UINavigationBar` of the view.
  public var navigationBar: UINavigationBar? {
    viewController?.navigationController?.navigationBar
  }

  /// The `UINavigationItem` of the view.
  public var navigationItem: UINavigationItem? {
    viewController?.navigationItem
  }
    
  /// The `ViewController` that is managing this view.
  public var viewController: UIViewController? {
    get {
      return objc_getAssociatedObject(self, &viewControllerKey) as? UIViewController
    }

    set {
      objc_setAssociatedObject(
        self,
        &viewControllerKey,
        newValue,
        .OBJC_ASSOCIATION_ASSIGN
      )
    }
  }
}

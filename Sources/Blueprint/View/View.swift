#if canImport(UIKit)
import UIKit
#endif

/// A protocol defining requirements for a view.
public protocol View: UIView {
  /// Sets up the view. Use this method to add subviews and basic view setup.
  func setup()
  
  /// Styles the view and its subviews.
  func style()
}

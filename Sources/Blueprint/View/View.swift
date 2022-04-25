#if canImport(UIKit)
import UIKit
#endif

/// A protocol defining requirements for a view.
public protocol View: UIView {
  /// Sets up the view. Use this method to add subviews and basic view setup.
  func setup()
  
  /// Styles the view and its subviews.
  func style()
  
  /// Sets the layout of the view.
  /// Implement all your constraints in this function.
  func layout()
}

public extension View {
  func layout() {}
}

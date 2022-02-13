#if canImport(UIKit)
import UIKit
#endif

/// A protocol that defines requirements for a View with constraint based layout.
public protocol ConstraintBasedView: View {
  /// Sets the layout of the view.
  /// Implement all your constraints in this function.
  func layout()
}

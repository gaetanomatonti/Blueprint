import Foundation
#if canImport(UIKit)
import UIKit
#endif

/// A protocol that defines requirements for a view with `ViewModel`.
public protocol ModellableView: View {
  associatedtype VM: ViewModel
  
  /// The `ViewModel` of the view.
  var viewModel: VM? { get set }
  
  /// Updates the view with its new instance of `ViewModel`.
  /// - Note: This method should not be called directly.
  func update(oldViewModel: VM?)
}

private var modelWrapperKey = "modellableview_model_wrapper_key"

/// implementation detail, wrapper of the model to work with the associatedObject mechanism.
private final class ViewModelWrapper<VM: ViewModel> {
  var viewModel: VM?

  init(viewModel: VM?) {
    self.viewModel = viewModel
  }
}

/// model update logic implementation.
extension ModellableView {
  private var modelWrapper: ViewModelWrapper<VM> {
    get {
      if let modelWrapper = objc_getAssociatedObject(self, &modelWrapperKey) as? ViewModelWrapper<VM> {
        return modelWrapper
      }
      let newWrapper = ViewModelWrapper<VM>(viewModel: nil)
      self.modelWrapper = newWrapper
      return newWrapper
    }

    set {
      objc_setAssociatedObject(
        self,
        &modelWrapperKey,
        newValue,
        .OBJC_ASSOCIATION_RETAIN_NONATOMIC
      )
    }
  }

  /// The ViewModel of the View. Once changed, the `update(oldModel: VM?)` will be called.
  /// The model variable is automatically created for you once you conform to the ModellableView protocol.
  /// Swift is inferring the Type through the `oldViewModel` parameter of the `update(oldViewModelModel: ViewModel?)` method
  /// and we are adding the var exploiting a feature of the Objective-C runtime called
  /// [Associated Objects](http://nshipster.com/associated-objects/).
  public var viewModel: VM? {
    get {
      modelWrapper.viewModel
    }

    set {
      let oldValue = viewModel
      modelWrapper.viewModel = newValue

      update(oldViewModel: oldValue)
    }
  }
}

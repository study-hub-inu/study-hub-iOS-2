import UIKit

import SnapKit

final class PopupViewController: UIViewController {
  private let popupView: PopupView
  var check: Bool?
  
  init(title: String, desc: String) {
    self.popupView = PopupView(title: title, desc: desc)
    super.init(nibName: nil, bundle: nil)
      
    self.view.backgroundColor = .lightGray.withAlphaComponent(0.8)
    
    self.view.addSubview(self.popupView)
    self.setupConstraints()
    
    self.popupView.leftButtonAction = { [weak self] in
      guard let self = self else { return }
      
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupConstraints() {
    self.popupView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
  
}

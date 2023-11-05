import UIKit

import SnapKit

final class StudyViewController: UIViewController {
  
  private let headerStackView: UIStackView = {
    let headerStackView = UIStackView()
    headerStackView.axis = .horizontal
    headerStackView.alignment = .center
    headerStackView.spacing = 8
    return headerStackView
  }()
  
  private let studyHubLabel: UILabel = {
    let studyHubLabel = UILabel()
    studyHubLabel.text = "스터디"
    studyHubLabel.font = UIFont.boldSystemFont(ofSize: 18)
    studyHubLabel.textColor = .white
    return studyHubLabel
  }()
  
  lazy var magnifyingglassButton: UIButton = {
    let magnifyingglassButton = UIButton(type: .system)
    magnifyingglassButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
    magnifyingglassButton.tintColor = .white
    return magnifyingglassButton
  }()
  
  lazy var bellButton: UIButton = {
    let bellButton = UIButton(type: .system)
    bellButton.setImage(UIImage(systemName: "bell"), for: .normal)
    bellButton.tintColor = .white
    return bellButton
  }()
  
  private let spacerView: UIView = {
    let spacerView = UIView()
    spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
    return spacerView
  }()
  
  lazy var headerContentStackView: UIStackView = {
    let headerContentStackView = UIStackView()
    headerContentStackView.axis = .vertical
    headerContentStackView.spacing = 16
    return headerContentStackView
  }()
  
  lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    
    scrollView.addSubview(headerContentStackView)
    scrollView.backgroundColor = .white
    return scrollView
  }()
  
  private let verticalGrayLine: UIView = {
    let verticalGrayLine = UIView()
    verticalGrayLine.backgroundColor = UIColor(hexCode: "#D8DCDE")
    verticalGrayLine.widthAnchor.constraint(equalToConstant: 1).isActive = true
    return verticalGrayLine
  }()
  
  lazy var recentButton: UIButton = {
    let recentButton = UIButton()
    recentButton.setTitle("최신순", for: .normal)
    recentButton.setTitleColor(.gray, for: .normal)
    recentButton.translatesAutoresizingMaskIntoConstraints = false
    recentButton.addTarget(self, action: #selector(sortingButtonTapped(_:)), for: .touchUpInside)
    return recentButton
  }()
  
  lazy var popularButton: UIButton = {
    let popularButton = UIButton()
    popularButton.setTitle("인기순", for: .normal)
    popularButton.setTitleColor(.gray, for: .normal)
    popularButton.translatesAutoresizingMaskIntoConstraints = false
    popularButton.addTarget(self, action: #selector(sortingButtonTapped(_:)), for: .touchUpInside)
    return popularButton
  }()
  
  lazy var sortingButtonsStackView: UIStackView = {
    let sortingButtonsStackView = UIStackView(arrangedSubviews: [recentButton,
                                                                 verticalGrayLine,
                                                                 popularButton])
    sortingButtonsStackView.axis = .horizontal
    sortingButtonsStackView.spacing = 1
    sortingButtonsStackView.distribution = .fillEqually
    return sortingButtonsStackView
  }()
  
  private let sortingButtonsGrayLine: UIView = {
    let sortingButtonsGrayLine = UIView()
    sortingButtonsGrayLine.backgroundColor = UIColor(hexCode: "#F3F5F6")
    sortingButtonsGrayLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
    return sortingButtonsGrayLine
  }()
  
  private let centerImageView: UIImageView = {
    // Create a UIImageView for the center image
    let centerImageView = UIImageView()
    centerImageView.image = UIImage(named: "Image 5")
    centerImageView.contentMode = .scaleAspectFit
    return centerImageView
  }()
  
  lazy var addButton: UIButton = {
    // Create the "+" button
    let addButton = UIButton(type: .system)
    addButton.setTitle("+", for: .normal)
    addButton.setTitleColor(.white, for: .normal)
    addButton.backgroundColor = UIColor(hexCode: "FF5935")
    addButton.layer.cornerRadius = 30 // Increase the corner radius to make the button rounder
    addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
    addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
    return addButton
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .black
    
    
    headerStackView.addArrangedSubview(studyHubLabel)
    headerStackView.addArrangedSubview(spacerView)
    headerStackView.addArrangedSubview(magnifyingglassButton)
    headerStackView.addArrangedSubview(bellButton)
    
    view.addSubview(headerStackView)
    view.addSubview(scrollView)
    
    headerContentStackView.addArrangedSubview(sortingButtonsStackView)
    headerContentStackView.addArrangedSubview(sortingButtonsGrayLine)
    
    view.addSubview(centerImageView)
    view.addSubview(addButton)
    
    headerStackView.snp.makeConstraints { make in
      make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
      make.leading.equalTo(view).offset(16)
      make.trailing.equalTo(view).offset(-16)
    }
    
    headerContentStackView.snp.makeConstraints { make in
      make.top.equalTo(scrollView).offset(16)
      make.leading.trailing.bottom.equalTo(scrollView)
      make.width.equalTo(scrollView)
    }
    
    recentButton.snp.makeConstraints { make in
      make.leading.equalTo(sortingButtonsStackView).offset(20)
    }
    
    verticalGrayLine.snp.makeConstraints { make in
      make.width.equalTo(1)
      make.trailing.equalTo(popularButton.snp.leading).offset(-6)
    }
    
    centerImageView.snp.makeConstraints { make in
      make.centerX.centerY.equalTo(view)
      make.width.height.equalTo(150) // Adjust width and height as needed
    }
    
    scrollView.snp.makeConstraints { make in
      make.top.equalTo(headerStackView.snp.bottom).offset(16)
      make.leading.trailing.bottom.equalTo(view)
    }
    
    sortingButtonsGrayLine.snp.makeConstraints { make in
      make.bottom.equalTo(sortingButtonsStackView.snp.top).offset(35)
    }
    
    addButton.snp.makeConstraints { make in
      make.width.height.equalTo(60) // Increase width and height as needed
      make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
      make.trailing.equalTo(view).offset(-16)
    }
  }
  
  @objc func addButtonTapped() {
    let createStudyViewController = CreateStudyViewController()
    let navigationController = UINavigationController(rootViewController: createStudyViewController)
    navigationController.modalPresentationStyle = .fullScreen
    
    // Present the navigation controller modally
    present(navigationController, animated: true, completion: nil)
  }
  
  @objc func sortingButtonTapped(_ sender: UIButton) {
    // Reset colors of all buttons
    recentButton.setTitleColor(.gray, for: .normal)
    popularButton.setTitleColor(.gray, for: .normal)
    
    // Set the tapped button to orange background
    sender.setTitleColor(.black, for: .normal)
  }
}

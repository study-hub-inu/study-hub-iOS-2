
import UIKit

class BookmarkViewController:UIViewController{

  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        // Create the top stack view for the header
        let headerStackView = UIStackView()
        headerStackView.axis = .horizontal
        headerStackView.alignment = .center
        headerStackView.spacing = 6
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // Back button
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Add a flexible spacer to push the title label to the center
        let spacerView = UIView()
        spacerView.translatesAutoresizingMaskIntoConstraints = false
        spacerView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        // "북마크" label
        let howtouseLabel = UILabel()
        howtouseLabel.text = "북마크"
        howtouseLabel.textColor = .white
        howtouseLabel.font = UIFont.boldSystemFont(ofSize: 18)
        howtouseLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the backButton and studyLabel to the header stack view
        headerStackView.addArrangedSubview(backButton)
        headerStackView.addArrangedSubview(spacerView)
        headerStackView.addArrangedSubview(howtouseLabel)
     
        
        // Add the header stack view to the view
        view.addSubview(headerStackView)

        
        let headerContentStackView = UIStackView()
        headerContentStackView.axis = .vertical
        headerContentStackView.spacing = 16
        headerContentStackView.translatesAutoresizingMaskIntoConstraints = false
      
        let countStackView = UIStackView()
        countStackView.axis = .horizontal
        countStackView.spacing = 16
        countStackView.translatesAutoresizingMaskIntoConstraints = false
        // Add the buttons stack view to the header content stack view
        headerContentStackView.addArrangedSubview(countStackView)
        
        // Create a label for "전체"
        let allLabel = UILabel()
        allLabel.text = "전체"
        allLabel.textColor = UIColor(hexCode: "#68737D")
        allLabel.font = UIFont.systemFont(ofSize: 16)
        allLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //전체삭제 버튼
        let alldeleteButton = UIButton(type: .system)
        alldeleteButton.setTitle("전체삭제", for: .normal)
        alldeleteButton.setTitleColor(UIColor(hexCode: "#A1AAB0"), for: .normal)
        alldeleteButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        //        associatedepartButton.addTarget(self, action: #selector(departmentArrowButtonTapped), for: .touchUpInside)
        alldeleteButton.translatesAutoresizingMaskIntoConstraints = false

        countStackView.addArrangedSubview(allLabel)
        countStackView.addArrangedSubview(alldeleteButton)
        
        let centerImageStackView = UIStackView()
        centerImageStackView.axis = .vertical
        centerImageStackView.spacing = 16
        centerImageStackView.translatesAutoresizingMaskIntoConstraints = false
        // Add the buttons stack view to the header content stack view
        headerContentStackView.addSubview(centerImageStackView)
        
        // Create a UIImageView for the center image
        let centerImageView = UIImageView()
        centerImageView.image = UIImage(named: "Image 15") // Replace with the actual image name
        centerImageView.contentMode = .scaleAspectFit
        centerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerContentStackView.addSubview(centerImageView)

        // Create a label for "북마크 글이 없어요"
        let noBookmarkLabel = UILabel()
        noBookmarkLabel.text = "북마크 글이 없어요"
        noBookmarkLabel.textColor = .gray
        noBookmarkLabel.font = UIFont.boldSystemFont(ofSize: 14)
        noBookmarkLabel.textAlignment = .center
        noBookmarkLabel.translatesAutoresizingMaskIntoConstraints = false

        // Create a label for "관심있는 스터디를 저장하여"
        let subTextLabel1 = UILabel()
        subTextLabel1.text = "관심있는 스터디를 저장하여"
        subTextLabel1.textColor = UIColor(hexCode: "#FF5935") // Orange color
        subTextLabel1.font = UIFont.boldSystemFont(ofSize: 14)
        subTextLabel1.textAlignment = .center
        subTextLabel1.translatesAutoresizingMaskIntoConstraints = false

        // Create a label for "빠르게 확인하세요!"
        let subTextLabel2 = UILabel()
        subTextLabel2.text = "빠르게 확인하세요!"
        subTextLabel2.textColor = UIColor(hexCode: "#FF5935") // Orange color
        subTextLabel2.font = UIFont.boldSystemFont(ofSize: 14)
        subTextLabel2.textAlignment = .center
        subTextLabel2.translatesAutoresizingMaskIntoConstraints = false
        
        centerImageStackView.addSubview(noBookmarkLabel)
        centerImageStackView.addSubview(subTextLabel1)
        centerImageStackView.addSubview(subTextLabel2)
        
        
        // Create a scroll view to make the content scrollable
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(headerContentStackView)
        view.addSubview(scrollView)
        
        // Set up constraints
        NSLayoutConstraint.activate([
            // Header stack view constraints
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -180),
            
            // Header content stack view constraints
            headerContentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerContentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            headerContentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            headerContentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            headerContentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            countStackView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 30),
            countStackView.leadingAnchor.constraint(equalTo: headerContentStackView.leadingAnchor, constant: 16),
            countStackView.trailingAnchor.constraint(equalTo: headerContentStackView.trailingAnchor),
                
            alldeleteButton.leadingAnchor.constraint(equalTo: countStackView.leadingAnchor, constant: 300),
            alldeleteButton.trailingAnchor.constraint(equalTo: countStackView.trailingAnchor),
            
            // Constraints for centerImageView
            centerImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            centerImageView.widthAnchor.constraint(equalToConstant: 150), // Adjust the width as needed
            centerImageView.heightAnchor.constraint(equalToConstant: 150), // Adjust the height as needed

            // "북마크 글이 없어요" label constraints
            noBookmarkLabel.topAnchor.constraint(equalTo: centerImageView.bottomAnchor, constant: 20),
            noBookmarkLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noBookmarkLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            // "관심있는 스터디를 저장하여" label constraints
            subTextLabel1.topAnchor.constraint(equalTo: noBookmarkLabel.bottomAnchor, constant: 10),
            subTextLabel1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subTextLabel1.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            // "빠르게 확인하세요!" label constraints
            subTextLabel2.topAnchor.constraint(equalTo: subTextLabel1.bottomAnchor, constant: 5),
            subTextLabel2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subTextLabel2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            // Scroll view constraints
            scrollView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        // Set the background color of the scrollView to black
                scrollView.backgroundColor = UIColor(hexCode: "#E9EBED")
        
        
        // Set the scroll view's content size to fit the content
        headerContentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
  // MARK: - setUpLayout
  func setUpLayout(){
    [

    ].forEach {
      view.addSubview($0)
    }
  }
  
  // MARK: - makeUI
  func makeUI(){
   
  }
    // Function to handle back button tap and navigate back to HomeViewController
     @objc func goBack() {
//         let homeViewController = HomeViewController()
//         let navController = UINavigationController(rootViewController: homeViewController) // Wrap the SignUpViewController in a navigation controller
//         navController.modalPresentationStyle = .fullScreen
//
//         _ = UIBarButtonItem(title: "back", style: .plain, target: self, action: #selector(backButtonTapped))
//
//
//         self.present(navController, animated: true, completion: nil) // Present the navigation controller modally
//
//
//     }
//     @objc func backButtonTapped() {
//         self.dismiss(animated: true, completion: nil)
//     }
         // Dismiss the current view controller to go back to the previous one
         self.dismiss(animated: true, completion: nil)
     }
 
    
}

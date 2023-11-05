//import UIKit
//
//class CategoryViewController: UIViewController {
//
//    // Add a variable to keep track of the starting point of the pan gesture
//    private var initialPanPoint: CGPoint = .zero
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//        
//        // Add the gray bar view
//        let grayBarView = UIView()
//        grayBarView.backgroundColor = UIColor(hexCode: "#D8DCDE")
//        grayBarView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(grayBarView)
//
//        let categoryLabel = UILabel()
//        categoryLabel.text = "카테고리"
//        categoryLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(categoryLabel)
//        
//        // Add the "완료" (Done) button
//        let doneButton = UIButton(type: .system)
//        doneButton.setTitle("완료", for: .normal)
//        doneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
//        doneButton.tintColor = UIColor(hexCode: "#FF5530")
//        doneButton.addTarget(self, action: #selector(doneButtonTapped(_:)), for: .touchUpInside)
//        doneButton.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(doneButton)
//        
//        // Create and add 18 buttons with the title "관심사"
//        var buttons: [UIButton] = []
//        for _ in 1...18 {
//            let button = UIButton(type: .system)
//            button.setTitle("관심사", for: .normal)
//            button.setTitleColor(.gray, for: .normal)
//            button.backgroundColor = .white
//            button.layer.cornerRadius = 10
//            button.layer.borderWidth = 0.5
//            button.layer.borderColor = UIColor.gray.cgColor
//            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//            button.translatesAutoresizingMaskIntoConstraints = false
//            buttons.append(button)
//            view.addSubview(button)
//        }
//        
//        // Arrange the buttons randomly on the screen
//        for button in buttons {
//            NSLayoutConstraint.activate([
//                button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: CGFloat.random(in: -100...100)),
//                button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: CGFloat.random(in: -100...100)),
//                button.widthAnchor.constraint(equalToConstant: 80),
//                button.heightAnchor.constraint(equalToConstant: 40)
//            ])
//        }
//
//        NSLayoutConstraint.activate([
//            grayBarView.topAnchor.constraint(equalTo: view.topAnchor),
//            grayBarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            grayBarView.widthAnchor.constraint(equalToConstant: 60),
//            grayBarView.heightAnchor.constraint(equalToConstant: 4), // Adjust the height as needed
//            
//            doneButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
//            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
//            
//            categoryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
//            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
//            // Add more constraints as needed for your content
//        ])
//        
//        // Add a pan gesture recognizer to the view
//        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
//        view.addGestureRecognizer(panGesture)
//    }
//    
//    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
//        let translation = gestureRecognizer.translation(in: view)
//        
//        switch gestureRecognizer.state {
//        case .began:
//            initialPanPoint = view.frame.origin
//        case .changed:
//            let newY = max(initialPanPoint.y + translation.y, 0)
//            view.frame.origin = CGPoint(x: 0, y: newY)
//        case .ended, .cancelled:
//            // Dismiss the view if it's dragged down by a certain threshold
//            if view.frame.origin.y > view.frame.height * 0.4 {
//                dismissViewController()
//            } else {
//                // Return the view to its original position
//                UIView.animate(withDuration: 0.3) {
//                    self.view.frame.origin = self.initialPanPoint
//                }
//            }
//        default:
//            break
//        }
//    }
//    
//    @objc func doneButtonTapped(_ sender: UIButton) {
//        dismissViewController()
//    }
//    
//    @objc func buttonTapped(_ sender: UIButton) {
//        if sender.backgroundColor == .white {
//            sender.backgroundColor = UIColor(hexCode: "#FF5530")
//        } else {
//            sender.backgroundColor = .white
//        }
//    }
//    
//    func dismissViewController() {
//        UIView.animate(withDuration: 0.3, animations: {
//            self.view.frame.origin = CGPoint(x: 0, y: self.view.frame.height)
//        }) { _ in
//            self.view.removeFromSuperview()
//            self.removeFromParent()
//        }
//    }
//}

//
//  ViewController.swift
//  Vought Showcase
//
//  Created by Burhanuddin Rampurawala on 06/08/24.
//

import UIKit

class MainViewController: UIViewController {
    
    //all ui components extended in MainViewController+UI
    
    @IBOutlet weak var containerView: UIView!
    
     var buttonTapped = false
     var openCarouselButton: UIButton!
     var infoLabel: UILabel!
    
    // MARK: - MainVC LifecycleMethods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOpenCarouselButton()
        setupInfoLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if buttonTapped {
            openCarouselButton.layer.borderColor = UIColor.gray.cgColor
        } else {
            openCarouselButton.layer.borderColor = UIColor.blue.withAlphaComponent(0.4).cgColor
        }
    }
    
    private func setupContainerViewFullScreen() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

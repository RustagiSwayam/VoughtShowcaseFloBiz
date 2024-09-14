//
//  CarouselViewController.swift
//  Vought Showcase
//
//  Created by Burhanuddin Rampurawala on 06/08/24.
//

import Foundation
import UIKit


final class CarouselViewController: UIViewController {
    
    @IBOutlet private weak var containerView: UIView!
    
      private var pageViewController: UIPageViewController?
      private var items: [CarouselItem] = []
      private var segmentedProgressBar: SegmentedProgressBar!
      private var currentItemIndex: Int = 0
      private var lastSegmentCompleted = false
      private var isAutoProgressing: Bool = true

      public init(items: [CarouselItem]) {
          self.items = items
          super.init(nibName: "CarouselViewController", bundle: nil)
      }

      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    
      override func viewDidLoad() {
          super.viewDidLoad()
          initPageViewController()
          initSegmentedProgressBar()
          addTapGestureRecognizers()
          addLongPressGestureRecognizer()
          addSwipeDownGestureRecognizer()
          view.backgroundColor = UIColor.black
      }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetProgressBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            segmentedProgressBar.startAnimation()
        }
    
    private func resetProgressBar() {
        segmentedProgressBar.reset()
    }


    // MARK: - Init Methods

      private func initPageViewController() {
          pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
          
          pageViewController?.setViewControllers([getController(at: currentItemIndex)], direction: .forward, animated: true)
          
          guard let theController = pageViewController else { return }
          add(asChildViewController: theController, containerView: containerView)
          
      }

      private func initSegmentedProgressBar() {
          let progressBarWidth: CGFloat = view.bounds.width - 20
          
          let progressBarX: CGFloat = (containerView.bounds.width - progressBarWidth) / 2

          segmentedProgressBar = SegmentedProgressBar(numberOfSegments: items.count)
          segmentedProgressBar.delegate = self
          segmentedProgressBar.frame = CGRect(x: progressBarX, y: 40, width: progressBarWidth, height: 4)
          segmentedProgressBar.topColor = UIColor.white
          segmentedProgressBar.bottomColor = UIColor.gray.withAlphaComponent(0.5)
          containerView.addSubview(segmentedProgressBar)
          segmentedProgressBar.startAnimation()
          
      }
    
    
    
    // MARK: - Methods
    
      private func addTapGestureRecognizers() {
          let leftTap = UITapGestureRecognizer(target: self, action: #selector(handleLeftTap))
          let rightTap = UITapGestureRecognizer(target: self, action: #selector(handleRightTap))
          
          let leftSide = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width / 2, height: view.bounds.height))
          let rightSide = UIView(frame: CGRect(x: view.bounds.width / 2, y: 0, width: view.bounds.width / 2, height: view.bounds.height))
          
          leftSide.addGestureRecognizer(leftTap)
          rightSide.addGestureRecognizer(rightTap)
          
          view.addSubview(leftSide)
          view.addSubview(rightSide)
      }
    
    private func addSwipeDownGestureRecognizer() {
           let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown(_:)))
           swipeDown.direction = .down
           view.addGestureRecognizer(swipeDown)
       }

       @objc private func handleSwipeDown(_ gesture: UISwipeGestureRecognizer) {
           dismiss(animated: true, completion: nil)
       }

      @objc private func handleLeftTap() {
          rewind()
      }

      @objc private func handleRightTap() {
          if currentItemIndex == items.count - 1 {
              lastSegmentCompleted = true
              dismiss(animated: true, completion: nil)
          } else{
              
              skip()
          }
      }
    
    @objc private func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            segmentedProgressBar.isPaused = true //pausing
        } else if gesture.state == .ended {
            segmentedProgressBar.isPaused = false //unpausing
        }
    }

    private func skip() {
        guard !lastSegmentCompleted else { return }
            if currentItemIndex + 1 < items.count {
            currentItemIndex += 1
            let controller = getController(at: currentItemIndex)
            pageViewController?.setViewControllers([controller], direction: .forward, animated: true, completion: nil)
            segmentedProgressBar.skip()
        } else {
            lastSegmentCompleted = true
        }
    }

      private func rewind() {
          if currentItemIndex > 0 {
              currentItemIndex -= 1
              let controller = getController(at: currentItemIndex)
              pageViewController?.setViewControllers([controller], direction: .reverse, animated: true, completion: nil)
              segmentedProgressBar.rewind()
          }
      }
    
    private func addLongPressGestureRecognizer() {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        longPress.minimumPressDuration = 0.2
        view.addGestureRecognizer(longPress)
    }

      private func getController(at index: Int) -> UIViewController {
          return items[index].getController()
      }
  }

  // MARK: - SegmentedProgressBarDelegate
extension CarouselViewController: SegmentedProgressBarDelegate {
    func segmentedProgressBarChangedIndex(index: Int) {
            if index < items.count {
                currentItemIndex = index
                let controller = getController(at: index)
                pageViewController?.setViewControllers([controller], direction: .forward, animated: true, completion: nil)
            }
        }
    

    func segmentedProgressBarFinished() {
        if currentItemIndex == items.count - 1 {
            lastSegmentCompleted = true
            dismiss(animated: true, completion: nil)
        } else {
            skip()
        }
    }
  }


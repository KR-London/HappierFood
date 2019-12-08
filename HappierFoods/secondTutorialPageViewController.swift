//
//  secondTutorialPageViewController.swift
//  HappierFoods
//
//  Created by Kate Roberts on 24/11/2019.
//  Copyright © 2019 Kate Roberts. All rights reserved.
//

    import UIKit

    class secondTutorialPageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
        var pageController: UIPageViewController!
        var controllers = [UIViewController]()
        var firstTry = false

        override func viewDidLoad() {
            super.viewDidLoad()

            pageController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
            pageController.dataSource = self
            pageController.delegate = self

            addChild(pageController)
            view.addSubview(pageController.view)

            let views = ["pageController": pageController.view] as [String: AnyObject]
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[pageController]|", options: [], metrics: nil, views: views))
            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[pageController]|", options: [], metrics: nil, views: views))

            if firstTry == true
            {
                let storyboard = UIStoryboard(name: "ExtraTutorial", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "p1" )
                controllers.append(vc)
            }
            
            for x in 2 ... 11 {
                let identifier = "p" + String(x)
                let storyboard = UIStoryboard(name: "ExtraTutorial", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: identifier )
                if x == 11 {
                    let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)) )
                    vc.view.addGestureRecognizer(tap)
                }
                
                controllers.append(vc)
            }

            pageController.setViewControllers([controllers[0]], direction: .forward, animated: false)
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            if let index = controllers.firstIndex(of: viewController) {
                if index > 0 {
                    return controllers[index - 1]
                } else {
                    self.dismiss(animated: false, completion: nil)
                    return nil
                }
            }

            return nil
        }

        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            if let index = controllers.firstIndex(of: viewController) {
                if index < controllers.count - 1 {
                    return controllers[index + 1]
                } else {
                    self.dismiss(animated: false, completion: nil)
                    return nil
                }
            }

            return nil
        }
        
        @objc func handleTap(_ sender: UITapGestureRecognizer) {
            print("tap recognised")
            pageController.dismiss(animated: true, completion: nil)
        }

    }

//
//  MainPageViewController.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 21.12.2022.
//

import UIKit

final class MainPageViewController: UIPageViewController {
    
    private lazy var greenViewController = UIViewController()
    private lazy var redViewController = UIViewController()
    private lazy var blueViewController = UIViewController()
    
    private lazy var colourViewControllers: [UIViewController] = [
        greenViewController,
        redViewController,
        blueViewController
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        greenViewController.view.backgroundColor = .green
        redViewController.view.backgroundColor = .red
        blueViewController.view.backgroundColor = .blue
        
        guard let firstViewController = colourViewControllers.first else {
            return
        }
        setViewControllers([firstViewController],
                           direction: .forward,
                           animated: true)
    }
}

// MARK: - UIPageViewControllerDataSource

extension MainPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = colourViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 && colourViewControllers.count > previousIndex else {
            return nil
        }
        return colourViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = colourViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let colourViewControllersCount = colourViewControllers.count
        guard colourViewControllersCount != nextIndex &&
                colourViewControllersCount > nextIndex
        else {
            return nil
        }
        return colourViewControllers[nextIndex]
    }
    
// MARK: - Methods for dots
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        colourViewControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}

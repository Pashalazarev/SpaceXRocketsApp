//
//  MainPageViewController.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 21.12.2022.
//

import UIKit


final class MainPageViewController: UIPageViewController {
    
// MARK: - Private properties
    
    private var colourViewControllers: [UIViewController] = [
        NetworkService.shared.redViewController,
        NetworkService.shared.greenViewController,
        NetworkService.shared.blueViewController
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        
        if let firstViewController = colourViewControllers.first { 
            setViewControllers([firstViewController],
                               direction: .forward,
                               animated: true,
                               completion: nil)
        }
    }
}

// MARK: - UIPageViewControllerDataSource

extension MainPageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = colourViewControllers.firstIndex(of: viewController) else {
            return nil
        }
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard colourViewControllers.count > previousIndex else {
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
        guard colourViewControllersCount != nextIndex else {
            return nil
        }
        guard colourViewControllersCount > nextIndex else {
            return nil
        }
        return colourViewControllers[nextIndex]
    }
    
// MARK: - Methods for dots
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        colourViewControllers.count
    }
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
              let firstViewControllerIndex = colourViewControllers.firstIndex(of: firstViewController) else {
                  return 0
              }
        return 0
    }
}


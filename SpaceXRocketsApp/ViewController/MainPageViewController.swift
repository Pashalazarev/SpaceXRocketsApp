//
//  MainPageViewController.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 21.12.2022.
//

import UIKit

private let greenViewController = UIViewController()
private let redViewController = UIViewController()
private let blueViewController = UIViewController()

final class MainPageViewController: UIPageViewController {
    
// MARK: - Private properties
    
    private var colourViewControllers: [UIViewController] = [
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
        setViewControllers([firstViewController], // почему такой firstViewController?
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
        return colourViewControllers[previousIndex] // почему возвращаем это?
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
        return colourViewControllers[nextIndex] // почему возвращаем это?
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

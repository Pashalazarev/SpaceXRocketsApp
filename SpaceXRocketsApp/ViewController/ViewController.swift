//
//  ViewController.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 08.12.2022.
//

import UIKit

final class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.navigationItem.backBarButtonItem?.tintColor = .white
        }
    }

    @IBAction func unwidSegueAction(unwindSegue: UIStoryboardSegue) {}
}

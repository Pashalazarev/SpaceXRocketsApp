//
//  ViewController.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 08.12.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkService.shared.fetchLaunches { launch in
            print(launch)
        }
        NetworkService.shared.fetchRockets { rocket in
            print(rocket)
        }
    }
}





















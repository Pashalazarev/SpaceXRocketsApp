//
//  LaunchesTableTableViewController.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 22.01.2023.
//

import UIKit

private enum LaunchImages {
    static let success = "success launch"
    static let failed = "failed launch"
}

final class LaunchesTableViewController: UITableViewController {
    
    private let dateFormatter = DateFormatter()
    private var launches: [Launch] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "dd MMMM.yyyy"
        NetworkService.shared.fetchLaunches { launches in
            switch launches {
            case .success(let launches):
                self.launches = launches
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        launches.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: LaunchesTableViewCell.self), for: indexPath) as? LaunchesTableViewCell
        else {
            return UITableViewCell()
        }
        let launches = launches[indexPath.row]
        
        var launchImage = UIImage()
        
        if launches.success == true {
            launchImage = UIImage.init(named: LaunchImages.success) ?? launchImage
        } else if launches.success == false {
            launchImage = UIImage.init(named: LaunchImages.failed) ?? launchImage
        }
        
        cell.configure(launches: launches, date: dateFormatter.string(from: launches.dateLocal), typeOfLaunch: launchImage)
        
        return cell
    }
}

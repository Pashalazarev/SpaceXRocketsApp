//
//  LaunchesTableTableViewController.swift
//  SpaceXRocketsApp
//
//  Created by Pavel Lazarev Macbook on 22.01.2023.
//

import UIKit

final class LaunchesTableTableViewController: UITableViewController {
    
    private let dateFormatter = DateFormatter()
    private var launches: [Launch] = []
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "launches", for: indexPath) as? LaunchesTableViewCell
        else {
            return UITableViewCell()
        }
        let launches = launches[indexPath.row]
        dateFormatter.dateFormat = "dd MMMM.yyyy"
        cell.configure(launches: launches, date: dateFormatter.string(from: launches.dateLocal))

        return cell
    }
}

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

        cell.selectionStyle = .none // убирает выделение ячейки при нажатии на нее
        
        return cell
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .black
    } //настраивает цвет ячейки
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

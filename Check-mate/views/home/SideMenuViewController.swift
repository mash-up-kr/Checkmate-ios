//
//  SideViewController.swift
//  Check-mate
//
//  Created by Changmin Kim on 2018. 8. 5..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit
var tableData: [String] = ["Mash up", "Worksmobile"]
class SideMenuViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    let cellIdentifier : String = "cell"
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
}

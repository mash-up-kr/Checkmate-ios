//
//  SideViewController.swift
//  Check-mate
//
//  Created by Changmin Kim on 2018. 8. 5..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit
protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index : Int32)
}
var tableData: [TempJobData] = [TempJobData(name: "Mash up", pay: 0, location: "서울시 강남구"),
                                TempJobData(name: "Worksmobile", pay: 20000, location:"성남시 분당구")]
class SideMenuViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var jobNameLabel : UILabel!
    @IBOutlet var jobPayLabel: UILabel!
    @IBOutlet var jobLocationLabel: UILabel!
    
    
    var btnMenu : UIButton!
    var delegate: SlideMenuDelegate?
    
    let cellIdentifier : String = "cell"
    
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        sideMenuLeadingConstraint.constant = -1 * UIScreen.main.bounds.size.width
    }
    
    func modalSidebarMenu(){
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.sideMenuLeadingConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    func dismissSidebar(){
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.sideMenuLeadingConstraint.constant = -1 * UIScreen.main.bounds.size.width
            self.view.layoutIfNeeded()
        })
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
        
        cell.textLabel?.text = tableData[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //code to execute on click
        self.jobNameLabel.text = tableData[indexPath.row].name
        self.jobPayLabel.text = String(tableData[indexPath.row].pay)
        self.jobLocationLabel.text = tableData[indexPath.row].location
        
    }
}

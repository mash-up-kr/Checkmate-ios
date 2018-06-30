//
//  WorkSpaceViewController.swift
//  Check-mate
//
//  Created by Noverish Harold on 2018. 6. 30..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class WorkSpaceViewController: UIViewController {

    let CELL_ID = "cell"

    var workSpaces: [String] = ["파리바게트", "백다방"]

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "WorkSpaceTableViewCell", bundle: nil), forCellReuseIdentifier: CELL_ID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addBtnClicked() {
        let vc = UIStoryboard.instantiate(WorkSpaceAddNavigationController.self)
        self.navigationController?.tabBarController?.present(vc, animated: true)
    }

    func detailClicked() {
        let vc = UIStoryboard.instantiate(WorkSpaceDetailViewController.self, storyboardName: "WorkSpaceNavigationController")
        self.navigationController?.pushViewController(vc, animated: true)
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

extension WorkSpaceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workSpaces.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
                as? WorkSpaceTableViewCell else {
            return UITableViewCell()
        }
        
        cell.isLastCell = indexPath.row == workSpaces.count
        cell.workSpaceView.addBtnCallback = addBtnClicked
        cell.workSpaceView.detailCallback = detailClicked

        return cell
    }
}

extension WorkSpaceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 + (indexPath.row == workSpaces.count ? 0 : WorkSpaceTableViewCell.workSpaceViewBottomOrigin)
    }
}

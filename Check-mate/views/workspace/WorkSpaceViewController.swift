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
        tableView.register(WorkSpaceTableViewCell.self, forCellReuseIdentifier: CELL_ID)
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

extension WorkSpaceViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workSpaces.count + 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ID, for: indexPath)
                as? WorkSpaceTableViewCell else {
            return UITableViewCell()
        }

        if cell.workSpaceView == nil {
            cell.workSpaceView = WorkSpaceView(frame: cell.bounds)
            cell.contentView.addSubview(cell.workSpaceView)
        }

        cell.workSpaceView.isLastCardView = indexPath.row == workSpaces.count

        return cell
    }
}

extension WorkSpaceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200 + (indexPath.row == workSpaces.count ? 0 : WorkSpaceTableViewCell.CELL_INSET)
    }
}

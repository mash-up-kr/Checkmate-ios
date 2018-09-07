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

    var workSpaces: [WorkSpace] = []

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "WorkSpaceTableViewCell", bundle: nil), forCellReuseIdentifier: CELL_ID)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        refresh()
    }
    
    func refresh() {
        ServerClient.getWorkSpaceList() { workSpaces in
            DispatchQueue.main.async {
                self.workSpaces = workSpaces
                self.tableView.reloadData()
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addBtnClicked() {
        let vc = UIStoryboard.instantiate(WorkSpaceAddVC.self)
        self.present(vc, animated: true)
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
        
        if (!cell.isLastCell) {
            cell.workSpaceView.setWorkSpace(workSpace: workSpaces[indexPath.row])
        }

        return cell
    }
}

extension WorkSpaceViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isLastView = indexPath.row == workSpaces.count
        return CGFloat(isLastView ? WorkSpaceView.addBtnStatusHeight : WorkSpaceView.normalStatusHeight) + CGFloat(10.0)
    }
}

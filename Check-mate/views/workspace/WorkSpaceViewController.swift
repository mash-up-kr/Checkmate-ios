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

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var deleteBtn: UIButton!
    var views = [WorkSpaceView]()
    var workSpaces: [WorkSpace] = []
    var isDeleteMode = false

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
    
    @IBAction func deleteBtnClicked() {
        deleteBtn.isSelected = !deleteBtn.isSelected
        isDeleteMode = deleteBtn.isSelected
        views.forEach { $0.modeToDelete(on: self.isDeleteMode) }
    }
    
    func cellAddBtnClicked() {
        let vc = UIStoryboard.instantiate(WorkSpaceAddVC.self)
        self.present(vc, animated: true)
    }

    func cellDetailClicked() {
        let vc = UIStoryboard.instantiate(WorkSpaceDetailViewController.self, storyboardName: "WorkSpaceNavigationController")
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func cellDeleteClicked(workSpace: WorkSpace) {
        ServerClient.deleteWorkSpace(workSpaceId: workSpace.id) { success in
            DispatchQueue.main.async {
                self.refresh()
            }
        }
    }
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
        cell.workSpaceView.addBtnCallback = cellAddBtnClicked
        cell.workSpaceView.detailCallback = cellDetailClicked
        cell.workSpaceView.deleteCallback = cellDeleteClicked
        cell.workSpaceView.modeToDelete(on: isDeleteMode)
        
        if (!cell.isLastCell) {
            cell.workSpaceView.setWorkSpace(workSpace: workSpaces[indexPath.row])
        }
        
        if (!views.contains(cell.workSpaceView)) {
            views.append(cell.workSpaceView)
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

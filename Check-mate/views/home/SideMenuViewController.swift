//
//  SideViewController.swift
//  Check-mate
//
//  Created by Changmin Kim on 2018. 8. 5..
//  Copyright © 2018년 MashUp. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var jobNameLabel : UILabel!
    @IBOutlet var jobPayLabel: UILabel!
    @IBOutlet var jobLocationLabel: UILabel!
    var workSpaces: [WorkSpace] = [WorkSpace]()
    
    let cellIdentifier : String = "cell"
    var selectedWorkSpace: Int = 0
    
    @IBOutlet weak var sideMenuLeadingConstraint: NSLayoutConstraint!
    @IBOutlet var shadowView: UIView!
    
    @IBAction func touchUpLaborOfficeButton(_ sender: UIButton){
        
    }
    
    func setWorkSpaces(spaces: [WorkSpace]){
        workSpaces = spaces
        
        if self.workSpaces.count == 0{
            let alert: UIAlertController = UIAlertController(title: "통신 에러", message: "서버로 부터 데이터를 불러 올 수 없습니다.", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive, handler : nil)
            alert.addAction(defaultAction)
            present(alert, animated: false, completion: nil)
            return
        }
        
        if workSpaces.count < 2{
            selectedWorkSpace = 0
        }
        
        tableView.reloadData()
        
        let indexPath: IndexPath = IndexPath(row: selectedWorkSpace, section: 0)
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        initLabel(workSpaces: workSpaces, index: indexPath.row)
        //UserDefaults.standard.set(workSpaces[indexPath.row], forKey: "workSpace")
        updateHomeView(workSpaces[indexPath.row])
    }
    
    func updateHomeView(_ workSpace: WorkSpace){
        for vc in self.childViewControllers{
            if let homeView = vc as? HomeViewController {
                homeView.updateHomeView(workSpace: workSpace)
            }
        }
    }
    
    func initSideMenu(){
        sideMenuLeadingConstraint.constant = -1 * UIScreen.main.bounds.size.width
        
        let tabShadowViewGesture = UITapGestureRecognizer.init(target: self, action: #selector(tabShadowView))
        shadowView.addGestureRecognizer(tabShadowViewGesture)
        shadowView.isHidden = true
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeSideView))
        swipeRight.direction = .right
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeSideView))
        swipeLeft.direction = .left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
        
        jobNameLabel.layer.cornerRadius = 20
        jobNameLabel.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        initSideMenu();
        
        ServerClient.getWorkSpaceList(callback: self.setWorkSpaces)
    }
    
    @objc func tabShadowView(){
        self.dismissSidebar()
    }
    
    @objc func swipeSideView(_ sender: UISwipeGestureRecognizer){
        if sender.direction == .left {
            self.dismissSidebar()
        }else if sender.direction == .right{
            self.modalSidebarMenu()
        }
    }
    
    func modalSidebarMenu(){
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.sideMenuLeadingConstraint.constant = 0
            self.view.layoutIfNeeded()
            self.shadowView.isHidden = false
        })
    }
    
    func dismissSidebar(){
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.sideMenuLeadingConstraint.constant = -1 * UIScreen.main.bounds.size.width
            self.view.layoutIfNeeded()
            self.shadowView.isHidden = true
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
    func initLabel(workSpaces:[WorkSpace], index: Int){
        self.jobNameLabel.text = workSpaces[index].name
        self.jobPayLabel.text = String(workSpaces[index].wage)
        let splitedAddress = workSpaces[index].address.components(separatedBy: " ")
        if splitedAddress.count < 2{
            self.jobLocationLabel.text = splitedAddress[0]
        }else {
            self.jobLocationLabel.text = splitedAddress[0] + " " + splitedAddress[1]
        }
        jobNameLabel.layer.cornerRadius = 20
        jobNameLabel.layer.masksToBounds = true
    }
}

extension SideMenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = workSpaces[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workSpaces.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //code to execute on click
        initLabel(workSpaces: workSpaces, index: indexPath.row)
        updateHomeView(workSpaces[indexPath.row])
    }
}

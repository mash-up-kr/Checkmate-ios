import UIKit

class DetailTimeCell: UITableViewCell {
    
    @IBOutlet weak var timeTableView: UITableView!
    var times: [Date] = []
    
    override func awakeFromNib() {
        timeTableView.delegate = self
        timeTableView.dataSource = self
        
        timeTableView.rowHeight = UITableViewAutomaticDimension
        timeTableView.estimatedRowHeight = 204
        
        timeTableView.separatorStyle = .none
        timeTableView.showsVerticalScrollIndicator = false;
        timeTableView.allowsSelection = false
    }
    
    func setTimes(_ times: [Date]) {
        self.times = times
        timeTableView.reloadData()
    }
    
}

extension DetailTimeCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = timeTableView.dequeueReusableCell(withIdentifier: "timeHistoryCell", for: indexPath) as? DetailTimeHistoryCell else {
            return UITableViewCell()
        }
        
        cell.setTime(times[indexPath.row])
        
        if indexPath.row % 2 == 0 {
            // [ON]
            cell.setOn()
        }
        else {
            // [OFF]
            cell.setOff()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 61.0
    }
}

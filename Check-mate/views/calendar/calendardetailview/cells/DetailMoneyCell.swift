import UIKit

class DetailMoneyCell: UITableViewCell {
    
    weak var delegate: DetailMoneyCellDelegate?
    
    @IBOutlet weak var lblWage: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    
    @IBOutlet weak var innerView: UIView!
    
    override func awakeFromNib() {
        
    }
    
    @IBAction func closedButton(_ sender: Any) {
        delegate?.closedPressed(self)
    }
    
    func setHourlyWage(_ hourlyWage: Int) {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        if let strHourlyWage = numberFormatter.string(from: NSNumber(value: hourlyWage)) {
            lblWage.text = "시급 \(strHourlyWage) won"
        }
        else {
            lblWage.text = "시급 \(hourlyWage) won"
        }
    }
    
    func setHour(_ hour: Int) {
        lblTime.text = "\(hour)h"
    }
    
}

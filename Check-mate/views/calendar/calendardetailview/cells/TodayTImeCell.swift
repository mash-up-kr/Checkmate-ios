import UIKit

class TodayTimeCell: UITableViewCell, OpenButtonProtocol {
    
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var openButton: UIButton!
    
    weak var delegate: TodayTimeCellDelegate?
    
    @IBAction func buttonPressed(_ sender: Any) {
        delegate?.buttonPressed(self)
    }
    
    func showButton() {
        openButton.isHidden = false
    }
    
    func hideButton() {
        openButton.isHidden = true
    }
}

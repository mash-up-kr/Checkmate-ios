import UIKit

class EtcCell: UITableViewCell {
    
    @IBOutlet weak var extraCollectionView: UICollectionView!
    
    @IBOutlet weak var innerView: UIView!
    
    var extras: [ExtraPay] = []
    
    override func awakeFromNib() {
        innerView.layer.shadowColor = UIColor.black.cgColor
        innerView.layer.shadowOpacity = 0.4
        innerView.layer.shadowOffset = CGSize.zero
        innerView.layer.shadowRadius = 1
        
        extraCollectionView.delegate = self
        extraCollectionView.dataSource = self
        
        extraCollectionView.allowsSelection = false
        extraCollectionView.isScrollEnabled = false
        extraCollectionView.isPagingEnabled = true

    }
    
    func setExtras(_ extras: [ExtraPay]) {
        self.extras = extras
        extraCollectionView.reloadData()
    }
    
}

extension EtcCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return extras.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.extraCollectionView.bounds.width) / CGFloat(extras.count), height: 103)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = extraCollectionView.dequeueReusableCell(withReuseIdentifier: "benefitCell", for: indexPath) as? BenefitCell else {
            return UICollectionViewCell()
        }
        let extra = extras[indexPath.row]
        
        let description = extra.type.description()
        let price = extra.value
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        switch extra.type {
        case .holiday:
            cell.extraImage.image = UIImage(named: "holidayPay")
        case .night:
            cell.extraImage.image = UIImage(named: "nightPay")
        case .week:
            cell.extraImage.image = UIImage(named: "weekPay")
        case .overtime:
            cell.extraImage.image = UIImage(named: "overtimePay")
        }
        
        cell.lblExtra.text = description
        if let strExtraMoney = numberFormatter.string(from: NSNumber(value: price)) {
            cell.lblPay.text = strExtraMoney
        }
        else {
            cell.lblPay.text = "NONE"
        }
        
        if indexPath.row == extras.count - 1 {
            cell.hideSeparator()
        }
        else {
            cell.showSeparator()
        }
        
        
        return cell
    }
}

extension EtcCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.extraCollectionView.setCollectionViewLayout(layout, animated: true)
    }
}

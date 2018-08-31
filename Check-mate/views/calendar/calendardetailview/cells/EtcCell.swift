import UIKit

class EtcCell: UITableViewCell {
    
    @IBOutlet weak var extraCollectionView: UICollectionView!
    
    var extras: [ExtraPay] = []
    
    override func awakeFromNib() {
        extraCollectionView.delegate = self
        extraCollectionView.dataSource = self
        extraCollectionView.allowsSelection = false
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 86, height: 91)
        
        layout.scrollDirection = .horizontal
        
        self.extraCollectionView.setCollectionViewLayout(layout, animated: true)
        self.extraCollectionView.isPagingEnabled = true
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
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = extraCollectionView.dequeueReusableCell(withReuseIdentifier: "benefitCell", for: indexPath) as? BenefitCell else {
            return UICollectionViewCell()
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        cell.lblExtra.text = extras[indexPath.row].type.description()
        
        let price = extras[indexPath.row].value
        
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

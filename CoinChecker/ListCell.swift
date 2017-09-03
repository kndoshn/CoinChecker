import UIKit

final class ListCell: UITableViewCell {
    @IBOutlet weak var coinImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    func configure(rate: String, row: Int) {
        let type = CoinType.allTypes[row]
        coinImageView.image = UIImage(named: String(describing: type))
        nameLabel.text = type.rawValue
        priceLabel.text = "¥" + rate
    }
}

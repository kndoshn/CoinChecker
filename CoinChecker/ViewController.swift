import UIKit
import APIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = ListViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = viewModel
        
        CoinType.allTypes.forEach {
            viewModel.reloadData(type: $0)
        }
        
        viewModel.coins.asObservable()
            .filter { x in
                return !x.isEmpty
            }
            .subscribe(onNext: { [unowned self] _ in
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / CGFloat(CoinType.allTypes.count)
    }
}

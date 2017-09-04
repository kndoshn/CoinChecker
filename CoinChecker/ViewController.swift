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
        
        configureTableView()
        
        CoinType.allTypes.forEach {
            viewModel.reloadData(type: $0)
        }
        
        viewModel.coins.asObservable()
            .subscribe(onNext: { [unowned self] _ in
                self.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - TableView
    func configureTableView() {
        tableView.isUserInteractionEnabled = false
        tableView.delegate = self
        tableView.dataSource = viewModel
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (view.frame.height - 64) / CGFloat(CoinType.allTypes.count)
    }
}

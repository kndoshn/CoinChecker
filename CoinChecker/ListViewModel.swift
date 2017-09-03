import UIKit
import RxSwift
import APIKit

final class ListViewModel: NSObject, UITableViewDataSource {
    private let cellIdentifier = "ListCell"
    
    private(set) var coins = Variable<[CoinInfo]>([])
    
    private(set) var error = Variable<Error?>(nil)
    
    let disposeBag = DisposeBag()
    
    func reloadData(type: CoinType) {
        let request = FetchRequest(type: type)
        Session.rx_sendRequest(request: request)
            .subscribe { [weak self] event in
                switch event {
                case .next(let coins):
                    self?.coins.value = coins
                case .error(let error): break
                self?.error.value = error
                default: break
                }
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoinType.allTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! ListCell
        let row = indexPath.row
        cell.configure(rate: coins.value[row].rate, row: indexPath.row)
        return cell
    }
}

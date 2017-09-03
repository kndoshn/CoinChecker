import UIKit
import RxSwift
import APIKit

final class ListViewModel: NSObject, UITableViewDataSource {
    
    private(set) var coins = Variable<[CoinInfo]>([])
    private(set) var error = Variable<Error?>(nil)
    
    let disposeBag = DisposeBag()
    private let cellIdentifier = "ListCell"
    
    var count = 0
    
    func reloadData(type: CoinType) {
        let request = FetchRequest(type: type)

        Session.rx_sendRequest(request: request)
            .subscribe { [weak self] event in
                switch event {
                case .next(let coin):
                    self?.coins.value.append(coin)
                case .error(let error):
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
        guard !coins.value.isEmpty else { return cell }
        guard count < CoinType.allTypes.count else { return cell }
        
        let row = indexPath.row
        print(row, "/", coins.value.count)
        cell.configure(rate: coins.value[row].rate, row: indexPath.row)
        count += 1
        return cell
    }
}

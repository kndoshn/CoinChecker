import APIKit
import Himotoki

protocol CoincheckRequest: Request {}

extension CoincheckRequest {
    
}

extension CoincheckRequest where Response: Decodable {
    
}

struct FetchRequest: CoincheckRequest {
    
}

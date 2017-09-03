import APIKit
import Himotoki

protocol CoincheckRequest: Request {}

extension CoincheckRequest {
    var baseURL: URL {
        return URL(string: "https://coincheck.com/api/rate/")!
    }

    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        guard (200..<300).contains(urlResponse.statusCode) else {
            throw ResponseError.unacceptableStatusCode(urlResponse.statusCode)
        }
        return object
    }
}

extension CoincheckRequest where Response: Decodable {
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Self.Response {
        return try decodeValue(object)
    }
}

struct FetchRequest: CoincheckRequest {
    var type: CoinType
    var path: String {
        return type.path
    }
    
    typealias Response = [CoinInfo]
    
    var method: HTTPMethod {
        return .get
    }
    
    init(type: CoinType) {
        self.type = type
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> FetchRequest.Response {
        return try decodeArray(object)
    }
}

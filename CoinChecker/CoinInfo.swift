import Himotoki

struct CoinInfo: Decodable {
    let rate: String
    
    static func decode(_ e: Extractor) throws -> CoinInfo {
        return try CoinInfo(
            rate: e <| "rate"
        )
    }
}

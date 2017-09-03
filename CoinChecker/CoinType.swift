import Foundation

enum CoinType: String {
    case bitCoin = "Bitcoin"
    case ethereum = "Ethereum"
    case etherClassic = "Ether Classic"
    case lisk = "Lisk"
    case factom = "Factom"
    case monero = "Monero"
    case augur = "Augur"
    case ripple = "Ripple"
    case zCash = "Zcash"
    case nem = "NEM"
    case liteCoin = "Litecoin"
    case dash = "DASH"
    case bitcoinCash = "Bitcoin Cash"
    
    static var allTypes: [CoinType] {
        return [
            .bitCoin, .ethereum, .etherClassic, .factom, .monero,
            .lisk, .augur, .ripple, .zCash, .nem, .liteCoin, .dash,
        ]
    }
    
    var path: String {
        switch self {
        case .bitCoin:
            return "btc_jpy"
        case .ethereum:
            return "eth_jpy"
        case .etherClassic:
            return "etc_jpy"
        case .factom:
            return "fct_jpy"
        case .monero:
            return "xmr_jpy"
        case .lisk:
            return "lsk_jpy"
        case .augur:
            return "rep_jpy"
        case .ripple:
            return "xrp_jpy"
        case .zCash:
            return "zec_jpy"
        case .nem:
            return "xem_jpy"
        case .liteCoin:
            return "ltc_jpy"
        case .dash:
            return "dash_jpy"
        case .bitcoinCash:
            return "bch_jpy"
        }
    }
}

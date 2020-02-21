



enum EntityNames {
    case band
    case albums
    
    var name: String {
        switch self {
        case .band: return "Band"
        case .albums: return "Albums"
        }
    }
}

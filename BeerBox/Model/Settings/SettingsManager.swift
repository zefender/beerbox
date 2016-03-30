import Foundation

enum UserSettingsKeys: String {
    case SortType = "sortType"
}

class SettingsManager {
    private let userDefaults = NSUserDefaults.standardUserDefaults()
    
    static let instance = SettingsManager()
    
    private init() {}
    
    func userSettings() -> Settings {
        if let sortType = userDefaults.stringForKey(UserSettingsKeys.SortType.rawValue) {
            return Settings(sortType: SortBy(rawValue: sortType)!)
        } else {
            return Settings(sortType: .ByDate) // default value
        }
    }
    
    func storeSettings(settings: Settings) {
        userDefaults.setObject(settings.sortType.rawValue, forKey: UserSettingsKeys.SortType.rawValue)
        userDefaults.synchronize()
    }
}

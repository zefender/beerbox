import Foundation
import UIKit

class SettingsViewController: ViewController, SettingsViewDelegate {
    private let settingsView = SettingsView(frame: UIScreen.mainScreen().bounds)
    private let sortTypes = [SortBy.ByDate, SortBy.ByName]

    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        
        automaticallyAdjustsScrollViewInsets = false
        
        settingsView.settingsDelegate = self
        settingsView.showSortTypes(sortTypes.map { $0.rawValue })
        
        let settings = SettingsManager.instance.userSettings()
        
        if let index = sortTypes.indexOf(settings.sortType) {
            settingsView.selectSortType(index)
        }
    }
    
    func settingsViewDidSelectSortTypeIndex(index: Int) {
        SettingsManager.instance.storeSettings(Settings(sortType: sortTypes[index]))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        settingsView.setInsets(UIEdgeInsets(top: topLayoutGuide.length + 24, left: 0, bottom: 0, right: 0))
    }
}

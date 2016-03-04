import Foundation
import UIKit

class SearchViewController: ViewController, SearchViewDelegate {
    private let searchView = SearchView(frame: UIScreen.mainScreen().bounds)

    override func loadView() {
        searchView.delegate = self

        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
    }

    func searchViewDidTriggerCloseAction(view: SearchView) {
        dismissViewControllerAnimated(true, completion: nil)
    }


    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

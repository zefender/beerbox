import Foundation
import UIKit

class SearchViewController: AlertViewController, SearchViewDelegate, SearchResultViewDelegate {
    private let searchResultView = SearchResultView(frame: UIScreen.mainScreen().bounds)
    private var beers = [BeerItem]()
    private var searchButton: UIBarButtonItem!

    override func loadView() {
        view = searchResultView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultView.delegate = self
        automaticallyAdjustsScrollViewInsets = false

        let searchView = SearchView(frame: CGRect(x: 0, y: 0, width: navigationController?.navigationBar.width ?? 0 - 44,
                height: navigationController?.navigationBar.height ?? 0))
        searchView.setPlaceHolder("Type beer name")
        searchView.delegate = self
        searchView.setFirstResponder()

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchView)
        navigationItem.rightBarButtonItem = nil
    }


    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        searchResultView.setInsets(UIEdgeInsets(top: topLayoutGuide.length + 24, left: 0, bottom: 0, right: 0))
    }

    func handleStashButtonTap(sender: AnyObject) {
        let controller = StashViewController()
        navigationController?.pushViewController(controller, animated: true)
    }


    private func showBeers(beers: [BeerItem]) {
        self.searchResultView.showBeers(beers, photoLoader: {
            (url, completionHandler) -> () in

            DataManager.instance.loadPhotoForUrl(url) {
                (image, error) -> () in

                if error.hasError {
                    self.showAlertForError(error)
                } else {
                    completionHandler(image)
                }
            }
        })
    }


    func searchViewDidTriggerCloseAction(view: SearchView) {
        navigationController?.popViewControllerAnimated(true)
    }

    func searchViewDidTriggerSearchAction(term: String) {
        switchNetworkActivity(true)
        searchResultView.state = .Loading

        DataManager.instance.searchBeersWithTerm(term) {
            [weak self] beers, error in
            self?.switchNetworkActivity(false)
            self?.searchResultView.state = .Normal

            if error.hasError {
                self?.showAlertForError(error)
            } else {
                if let beers = beers {
                    self?.beers = beers
                    
                    if beers.count > 0 {
                        self?.showBeers(beers)
                    } else {
                        self?.showCustomAlert("Seems this beer not brewed yet")
                    }
                }
            }

        }
    }


    func searchResultView(view: SearchResultView, didTriggerStashActionForIndex index: Int) {
        let beer = beers[index]
        switchNetworkActivity(true)
        searchResultView.state = .Loading

        DataManager.instance.addBeerToStash(beer.bid) {
            [weak self] error in
            self?.switchNetworkActivity(false)
            self?.searchResultView.state = .Normal

            if error.hasError {
                self?.showCustomAlert("Fail To Add Beer To Stash")
            } else {
                self?.searchResultView.endAddingToStash()
            }
        }
    }
}

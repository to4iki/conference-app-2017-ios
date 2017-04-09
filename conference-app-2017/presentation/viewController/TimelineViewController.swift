import UIKit

final class TimetableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    /// dummy
    fileprivate let texts = (1...10).map(String.init)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension TimetableViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(with: SessionTableViewCell.self, for: indexPath)
        cell.textLabel?.text = texts[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TimetableViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let text = texts[indexPath.row]
        let destination = SessionViewController.instantiate(text: text)
        navigationController?.pushViewController(destination, animated: true)
    }
}

import UIKit

final class MySessionViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    /// dummy
    fileprivate let texts = (11...20).map(String.init)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
    }
}

// MARK: - UITableViewDataSource
extension MySessionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return texts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SessionCell", for: indexPath)
        cell.textLabel?.text = texts[indexPath.row]
        return cell
    }
}

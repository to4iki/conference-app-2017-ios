import UIKit
import AVFoundation
import OctavKit
import Then
import QRCodeReader

final class InformationViewController: UITableViewController {
    fileprivate var sponsors: [Sponsor] = []

    lazy var readerViewController: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode], captureDevicePosition: .back)
            $0.showTorchButton = true
        }
        return QRCodeReaderViewController(builder: builder).then {
            $0.delegate = self
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSponsor()
    }
}

extension InformationViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == "\(SponsorViewController.className)Segue" {
            let viewController = segue.destination as! SponsorViewController
            viewController.sponsors = sponsors.groping()
        }
    }
}

extension InformationViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1, indexPath.row == 0 {
            presentQRCodeReader(animated: true, completion: nil)
        }
    }
}

extension InformationViewController {
    fileprivate func setupSponsor() {
        SponsorService.shared.read { [weak self] result in
            if case .success(let value) = result {
                self?.sponsors = value
            }
        }
    }
}

import UIKit
import AVFoundation
import Kingfisher
import OctavKit
import enum Result.Result
import RxSwift
import Then
import QRCodeReader

final class InformationViewController: UITableViewController {
    var usecase: AnyReadUseCase<[Int: [Sponsor]]>!
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate var sponsors: [Int: [Sponsor]] = [:]

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
            viewController.sponsors = sponsors
        }
    }
}

extension InformationViewController {
    private enum CellType {
        case sponsor
        case floorMap
        case qrCodeReader
        case clearCache

        init(rawValue: IndexPath) {
            switch (rawValue.section, rawValue.row) {
            case (0, 0):
                self = .sponsor
            case (0, 1):
                self = .floorMap
            case (1, 0):
                self = .qrCodeReader
            case (2, 0):
                self = .clearCache
            default:
                fatalError("non reachable")
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch CellType(rawValue: indexPath) {
        case .qrCodeReader:
            presentQRCodeReader(animated: true, completion: nil)
        case .clearCache:
            presentClearCacheDialog(animated: true, completion: nil)
        default:
            break
        }
    }
}

extension InformationViewController {
    fileprivate func setupSponsor() {
        usecase.execute().subscribe(onSuccess: { [unowned self] sponsors in
            self.sponsors = sponsors
        }).disposed(by: disposeBag)
    }

    fileprivate func presentClearCacheDialog(animated: Bool, completion: (() -> Void)?) {
        let alert = UIAlertController(title: nil, message: "Clear App's Cache", preferredStyle: .alert)
        let clearAction = UIAlertAction(title: "Clear", style: .default) { [weak self] _ in
            self?.clearCache { result in
                if case .success(_) = result {
                    let dialog = UIAlertController(title: nil, message: "Deleted all data from the cache", preferredStyle: .alert)
                    dialog.addAction(UIAlertAction(title: "Close", style: .default, handler: nil))
                    self?.present(dialog, animated: true, completion: nil)
                }
            }
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(clearAction)
        present(alert, animated: animated, completion: completion)
    }

    // TODO: display loding-indicator
    private func clearCache(completion: @escaping (Result<Void, StorageError>) -> Void) {
        ImageCache.default.clearDiskCache()
        DiskCache.shared.removeAll(completion: completion)
    }
}

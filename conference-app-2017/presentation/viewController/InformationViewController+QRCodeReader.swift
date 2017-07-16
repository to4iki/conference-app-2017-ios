import UIKit
import AVFoundation
import SafariServices
import QRCodeReader

extension InformationViewController {
    func presentQRCodeReader(animated: Bool, completion: (() -> Void)?) {
        guard checkScanPermissions() else { return }
        present(readerViewController, animated: animated, completion: completion)
    }

    fileprivate func presentOpenURLDialog(url: URL) {
        let alert = UIAlertController(title: "読み取り結果", message: url.absoluteString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "開く", style: .default, handler: { [weak self] _ in self?.open(url: url) }))
        present(alert, animated: true, completion: nil)
    }

    private func open(url: URL) {
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true, completion: nil)
    }

    private func checkScanPermissions() -> Bool {
        do {
            return try QRCodeReader.supportsMetadataObjectTypes()
        } catch let error as NSError {
            log.error("error: \(error.localizedDescription)")
            var alert = Alert.Builder().set(title: "エラー")
            switch error.code {
            case -11852:
                let action = UIAlertAction(title: "設定", style: .default, handler: { _ in
                    DispatchQueue.main.async {
                        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
                    }
                })
                alert = alert
                    .set(message: error.localizedDescription)
                    .set(action: action)
                    .set(action: UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
            case -11814:
                alert = alert
                    .set(message: error.localizedDescription)
                    .set(action: UIAlertAction(title: "OK", style: .cancel, handler: nil))
            default:
                alert = alert
                    .set(message: error.localizedDescription)
                    .set(action: UIAlertAction(title: "OK", style: .cancel, handler: nil))
            }
            alert.present(animated: true, completion: nil)
            return false
        }
    }
}

// MARK: - QRCodeReaderViewControllerDelegate
extension InformationViewController: QRCodeReaderViewControllerDelegate {
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        dismiss(animated: false) { [weak self] in
            guard let url = URL(string: result.value) else { return }
            self?.presentOpenURLDialog(url: url)
        }
    }

    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if let cameraName = newCaptureDevice.device.localizedName {
            log.debug("Switching capturing to: \(cameraName)")
        }
    }

    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
}

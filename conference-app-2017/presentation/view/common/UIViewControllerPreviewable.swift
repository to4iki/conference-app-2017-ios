import UIKit

protocol UIViewControllerPreviewable {
    associatedtype PreviewContent
    func previewingContent(viewControllerForLocation location: CGPoint) -> PreviewContent?
    func previewingViewController(content: PreviewContent) -> UIViewController?
}

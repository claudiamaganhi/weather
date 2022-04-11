import Foundation

extension DispatchQueue: DispatchQueueProtocol {
    func callAsync(execute work: @escaping () -> Void) {
        async(execute: work)
    }
}

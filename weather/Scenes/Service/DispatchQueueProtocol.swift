import Foundation

protocol DispatchQueueProtocol {
    func callAsync(execute work: @escaping () -> Void)
}

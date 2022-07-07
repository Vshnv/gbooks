import Foundation
import UIKit

class ImageLoader {
    private var loadedImages = [URL: UIImage]()
    private var runningTasks = [UUID: URLSessionDataTask]()

    func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        if let image = loadedImages[url] {
            completion(.success(image))
            return nil
        }

        let uuid = UUID()

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            defer {
                self.runningTasks.removeValue(forKey: uuid)
            }
            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[url] = image
                completion(.success(image))
                return
            }
            guard let error = error else {
                return
            }
            guard (error as NSError).code == NSURLErrorCancelled else {
                completion(.failure(error))
                return
            }
        }

        task.resume()
        runningTasks[uuid] = task
        return uuid
    }

    func cancalLoad(for uuid: UUID) {
        runningTasks[uuid]?.cancel()
        runningTasks.removeValue(forKey: uuid)
    }
}

//
//  ImageService.swift
//  nikeAppClone
//
//  Created by Claude on 2/14/26.
//

import Foundation
import Supabase
import UIKit

enum ImageError: LocalizedError {
    case uploadFailed(String)
    case invalidImage

    var errorDescription: String? {
        switch self {
        case .uploadFailed(let message):
            return "Failed to upload image: \(message)"
        case .invalidImage:
            return "Invalid image data"
        }
    }
}

final class ImageService {
    static let shared = ImageService()
    private let client = SupabaseManager.shared.client
    private let bucketName = "product-images"

    private init() {}

    /// Upload image to Supabase Storage
    func uploadImage(_ image: UIImage, filename: String) async throws -> String {
        guard let imageData = image.jpegData(compressionQuality: 0.8) else {
            throw ImageError.invalidImage
        }

        let filePath = "\(UUID().uuidString)-\(filename)"

        do {
            try await client.storage
                .from(bucketName)
                .upload(
                    path: filePath,
                    file: imageData,
                    options: FileOptions(contentType: "image/jpeg")
                )

            // Get public URL
            let url = try client.storage
                .from(bucketName)
                .getPublicURL(path: filePath)

            return url.absoluteString
        } catch {
            throw ImageError.uploadFailed(error.localizedDescription)
        }
    }

    /// Upload product images from local assets (one-time migration)
    func migrateLocalImage(named imageName: String) async throws -> String {
        guard let image = UIImage(named: imageName) else {
            throw ImageError.invalidImage
        }
        return try await uploadImage(image, filename: "\(imageName).jpg")
    }
}

//
//  DataSeeder.swift
//  nikeAppClone
//
//  Created by Claude on 2/14/26.
//

import Foundation

final class DataSeeder {
    static let shared = DataSeeder()

    private init() {}

    /// Check if products already seeded
    func isProductsSeeded() async -> Bool {
        do {
            let products = try await ProductService.shared.fetchProducts()
            return !products.isEmpty
        } catch {
            return false
        }
    }

    /// Seed initial product catalog to Supabase
    func seedProducts() async throws {
        let imageService = ImageService.shared
        let productService = ProductService.shared

        // Upload images and get URLs for 6 hardcoded products

        // Product 1: Everyday Plus Cushioned (Black)
        let img1 = try await imageService.migrateLocalImage(named: "image-1")
        let product1 = Product(
            id: 1,
            name: "Nike Everyday Plus Cushioned",
            description: "Training Crew Socks (3 Pairs)",
            colors: "1 Color",
            price: Decimal(string: "18.97")!,
            imageUrl: img1,
            category: "Socks",
            createdAt: Date(),
            isDeleted: false
        )
        try await productService.insertProduct(product1)

        // Upload detail images for product 1
        let img1d1 = try await imageService.migrateLocalImage(named: "productDetail2")
        let img1d2 = try await imageService.migrateLocalImage(named: "productDetail3")
        let img1d3 = try await imageService.migrateLocalImage(named: "productDetail4")

        let detail1 = ProductDetail(
            productId: 1,
            name: "Nike Everyday Plus Cushioned",
            category: "Training Crew Socks",
            longDescription: "The Nike Everyday Plus Cushioned Socks bring comfort to your workout with extra cushioning under the heel and forefoot and a snug, supportive arch band. Sweat-wicking power and breathability up top help keep your feet dry and cool to help push you through that extra set.",
            info: "• Shown: Multi-Color\n• Style: SX6897-965",
            price: Decimal(string: "18.97")!,
            imageUrl: img1,
            imageDetail1: img1d1,
            imageDetail2: img1d2,
            imageDetail3: img1d3,
            copyTitle: "LEGENDARY STYLE REFINED.",
            copyDescription: "The Nike Everyday Plus Cushioned Socks bring comfort to your workout with extra cushioning under the heel and forefoot and a snug, supportive arch band.",
            benefits: "• Cushioning under the forefoot and heel helps soften the impact of your workout.\n• Dri-FIT technology helps your feet stay dry and comfortable.\n• Band around the arch feels snug and supportive.\n• Breathable knit pattern on top adds ventilation.\n• Reinforced heel and toe are made to last.",
            productDetails: "• Fabric: 61-67% cotton/30-36% polyester/2% spandex/1% nylon\n• Machine wash\n• Imported\n• Note: Material percentages may vary slightly depending on color. Check label for actual content.\n• Shown: Multi-Color\n• Style: SX6897-965",
            createdAt: Date(),
            isDeleted: false
        )
        try await productService.insertProductDetail(detail1)

        // Product 2: Everyday Plus Cushioned (White)
        let img2 = try await imageService.migrateLocalImage(named: "image-2")
        let product2 = Product(
            id: 2,
            name: "Nike Everyday Plus Cushioned",
            description: "Training Crew Socks (6 Pairs)",
            colors: "7 Colors",
            price: Decimal(string: "28.00")!,
            imageUrl: img2,
            category: "Socks",
            createdAt: Date(),
            isDeleted: false
        )
        try await productService.insertProduct(product2)

        let detail2 = ProductDetail(
            productId: 2,
            name: "Nike Everyday Plus Cushioned",
            category: "Training Crew Socks",
            longDescription: "The Nike Everyday Plus Cushioned Socks bring comfort to your workout with extra cushioning under the heel and forefoot and a snug, supportive arch band.",
            info: "• Shown: Multi-Color\n• Style: SX6897-965",
            price: Decimal(string: "28.00")!,
            imageUrl: img2,
            imageDetail1: img1d1,
            imageDetail2: img1d2,
            imageDetail3: img1d3,
            copyTitle: "LEGENDARY STYLE REFINED.",
            copyDescription: "Extra cushioning for all-day comfort.",
            benefits: "• Cushioning under the forefoot and heel\n• Dri-FIT technology\n• Snug arch band\n• Breathable knit pattern\n• Reinforced heel and toe",
            productDetails: "• Fabric: 61-67% cotton/30-36% polyester/2% spandex/1% nylon\n• Machine wash\n• Imported",
            createdAt: Date(),
            isDeleted: false
        )
        try await productService.insertProductDetail(detail2)

        // Product 3: Nike Elite Crew
        let img3 = try await imageService.migrateLocalImage(named: "image-3")
        let product3 = Product(
            id: 3,
            name: "Nike Elite Crew",
            description: "Basketball Socks",
            colors: "7 Colors",
            price: Decimal(string: "16.00")!,
            imageUrl: img3,
            category: "Socks",
            createdAt: Date(),
            isDeleted: false
        )
        try await productService.insertProduct(product3)

        let detail3 = ProductDetail(
            productId: 3,
            name: "Nike Elite Crew",
            category: "Basketball Socks",
            longDescription: "The Nike Elite Crew Basketball Socks feature sweat-wicking fabric with strategic cushioning for comfort on the court.",
            info: "• Shown: Multi-Color\n• Style: SX7627-965",
            price: Decimal(string: "16.00")!,
            imageUrl: img3,
            imageDetail1: img1d1,
            imageDetail2: img1d2,
            imageDetail3: img1d3,
            copyTitle: "ELITE PERFORMANCE.",
            copyDescription: "Built for basketball.",
            benefits: "• Dri-FIT technology\n• Strategic cushioning\n• Arch band support",
            productDetails: "• Fabric: Polyester/Spandex\n• Machine wash",
            createdAt: Date(),
            isDeleted: false
        )
        try await productService.insertProductDetail(detail3)

        // Product 4: Everyday Plus Cushioned Ankle
        let img4 = try await imageService.migrateLocalImage(named: "image-4")
        let product4 = Product(
            id: 4,
            name: "Nike Everyday Plus Cushioned",
            description: "Training Ankle Socks (6 Pairs)",
            colors: "5 Colors",
            price: Decimal(string: "60.00")!,
            imageUrl: img4,
            category: "Socks",
            createdAt: Date(),
            isDeleted: false
        )
        try await productService.insertProduct(product4)

        let detail4 = ProductDetail(
            productId: 4,
            name: "Nike Everyday Plus Cushioned",
            category: "Training Ankle Socks",
            longDescription: "The Nike Everyday Plus Cushioned Ankle Socks provide comfort with extra cushioning.",
            info: "• Shown: Multi-Color\n• Style: SX7667-965",
            price: Decimal(string: "60.00")!,
            imageUrl: img4,
            imageDetail1: img1d1,
            imageDetail2: img1d2,
            imageDetail3: img1d3,
            copyTitle: "ANKLE COMFORT.",
            copyDescription: "Low-cut comfort for training.",
            benefits: "• Extra cushioning\n• Dri-FIT technology\n• Arch support",
            productDetails: "• Fabric: Cotton/Polyester blend\n• Machine wash",
            createdAt: Date(),
            isDeleted: false
        )
        try await productService.insertProductDetail(detail4)

        // Product 5: Air Jordan XXXVI
        let img5 = try await imageService.migrateLocalImage(named: "homeImage2")
        let product5 = Product(
            id: 5,
            name: "Air Jordan XXXVI",
            description: "Basketball Shoes",
            colors: "Multiple Colors",
            price: Decimal(string: "185.00")!,
            imageUrl: img5,
            category: "Shoes",
            createdAt: Date(),
            isDeleted: false
        )
        try await productService.insertProduct(product5)

        let detail5 = ProductDetail(
            productId: 5,
            name: "Air Jordan XXXVI",
            category: "Basketball Shoes",
            longDescription: "The Air Jordan XXXVI delivers elite performance with responsive cushioning and lightweight support.",
            info: "• Shown: Multi-Color\n• Style: AJ36-001",
            price: Decimal(string: "185.00")!,
            imageUrl: img5,
            imageDetail1: img5,
            imageDetail2: img5,
            imageDetail3: img5,
            copyTitle: "LEGENDARY PERFORMANCE.",
            copyDescription: "Built for the modern game.",
            benefits: "• Responsive cushioning\n• Lightweight support\n• Excellent traction",
            productDetails: "• Premium materials\n• Advanced cushioning technology",
            createdAt: Date(),
            isDeleted: false
        )
        try await productService.insertProductDetail(detail5)

        // Product 6: Air Jordan XXXVI (variant)
        let product6 = Product(
            id: 6,
            name: "Air Jordan XXXVI",
            description: "Basketball Shoes",
            colors: "Multiple Colors",
            price: Decimal(string: "185.00")!,
            imageUrl: img5,
            category: "Shoes",
            createdAt: Date(),
            isDeleted: false
        )
        try await productService.insertProduct(product6)

        let detail6 = ProductDetail(
            productId: 6,
            name: "Air Jordan XXXVI",
            category: "Basketball Shoes",
            longDescription: "The Air Jordan XXXVI delivers elite performance with responsive cushioning and lightweight support.",
            info: "• Shown: Multi-Color\n• Style: AJ36-002",
            price: Decimal(string: "185.00")!,
            imageUrl: img5,
            imageDetail1: img5,
            imageDetail2: img5,
            imageDetail3: img5,
            copyTitle: "LEGENDARY PERFORMANCE.",
            copyDescription: "Built for the modern game.",
            benefits: "• Responsive cushioning\n• Lightweight support\n• Excellent traction",
            productDetails: "• Premium materials\n• Advanced cushioning technology",
            createdAt: Date(),
            isDeleted: false
        )
        try await productService.insertProductDetail(detail6)
    }
}

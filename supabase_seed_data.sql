-- Supabase SQL Editor에서 실행할 테스트 데이터
-- 이미지는 임시로 placeholder URL 사용

-- Products 테이블에 데이터 삽입
INSERT INTO products (id, name, description, colors, price, image_url, category, created_at, is_deleted)
VALUES
  (1, 'Nike Everyday Plus Cushioned', 'Training Crew Socks (3 Pairs)', '10 Colours', 18.97, 'https://via.placeholder.com/400x400/000000/FFFFFF?text=Nike+Socks+1', 'Socks', NOW(), false),
  (2, 'Nike Everyday Plus Cushioned', 'Training Crew Socks (6 Pairs)', '7 Colours', 28.00, 'https://via.placeholder.com/400x400/CCCCCC/000000?text=Nike+Socks+2', 'Socks', NOW(), false),
  (3, 'Nike Elite Crew', 'Basketball Socks', '7 Colours', 16.00, 'https://via.placeholder.com/400x400/FF6B6B/FFFFFF?text=Nike+Elite', 'Socks', NOW(), false),
  (4, 'Nike Everyday Plus Cushioned', 'Training Ankle Socks (6 Pairs)', '5 Colours', 60.00, 'https://via.placeholder.com/400x400/4ECDC4/000000?text=Nike+Ankle', 'Socks', NOW(), false),
  (5, 'Air Jordan XXXVI', 'Basketball Shoes', 'Multiple Colors', 185.00, 'https://via.placeholder.com/400x400/FF0000/FFFFFF?text=Air+Jordan', 'Shoes', NOW(), false),
  (6, 'Air Jordan XXXVI', 'Basketball Shoes', 'Multiple Colors', 185.00, 'https://via.placeholder.com/400x400/000000/FF0000?text=Air+Jordan', 'Shoes', NOW(), false);

-- Product Details 테이블에 데이터 삽입
INSERT INTO product_details (product_id, name, category, long_description, info, price, image_url, image_detail_1, image_detail_2, image_detail_3, copy_title, copy_description, benefits, product_details, created_at, is_deleted)
VALUES
  (1, 'Nike Everyday Plus Cushioned', 'Training Crew Socks',
   'The Nike Everyday Plus Cushioned Socks bring comfort to your workout with extra cushioning under the heel and forefoot and a snug, supportive arch band. Sweat-wicking power and breathability up top help keep your feet dry and cool to help push you through that extra set.',
   '• Shown: Multi-Color\n• Style: SX6897-965',
   18.97,
   'https://via.placeholder.com/400x400/000000/FFFFFF?text=Nike+Socks+1',
   'https://via.placeholder.com/400x400/333333/FFFFFF?text=Detail+1',
   'https://via.placeholder.com/400x400/666666/FFFFFF?text=Detail+2',
   'https://via.placeholder.com/400x400/999999/FFFFFF?text=Detail+3',
   'LEGENDARY STYLE REFINED.',
   'The Nike Everyday Plus Cushioned Socks bring comfort to your workout with extra cushioning under the heel and forefoot and a snug, supportive arch band.',
   '• Cushioning under the forefoot and heel helps soften the impact of your workout.\n• Dri-FIT technology helps your feet stay dry and comfortable.\n• Band around the arch feels snug and supportive.\n• Breathable knit pattern on top adds ventilation.\n• Reinforced heel and toe are made to last.',
   '• Fabric: 61-67% cotton/30-36% polyester/2% spandex/1% nylon\n• Machine wash\n• Imported\n• Note: Material percentages may vary slightly depending on color. Check label for actual content.',
   NOW(), false),

  (2, 'Nike Everyday Plus Cushioned', 'Training Crew Socks',
   'The Nike Everyday Plus Cushioned Socks bring comfort to your workout with extra cushioning under the heel and forefoot and a snug, supportive arch band.',
   '• Shown: Multi-Color\n• Style: SX6897-966',
   28.00,
   'https://via.placeholder.com/400x400/CCCCCC/000000?text=Nike+Socks+2',
   'https://via.placeholder.com/400x400/DDDDDD/000000?text=Detail+1',
   'https://via.placeholder.com/400x400/EEEEEE/000000?text=Detail+2',
   'https://via.placeholder.com/400x400/FFFFFF/000000?text=Detail+3',
   'LEGENDARY STYLE REFINED.',
   'Extra cushioning for all-day comfort.',
   '• Cushioning under the forefoot and heel\n• Dri-FIT technology\n• Snug arch band\n• Breathable knit pattern\n• Reinforced heel and toe',
   '• Fabric: 61-67% cotton/30-36% polyester/2% spandex/1% nylon\n• Machine wash\n• Imported',
   NOW(), false),

  (3, 'Nike Elite Crew', 'Basketball Socks',
   'The Nike Elite Crew Basketball Socks feature sweat-wicking fabric with strategic cushioning for comfort on the court.',
   '• Shown: Multi-Color\n• Style: SX7627-965',
   16.00,
   'https://via.placeholder.com/400x400/FF6B6B/FFFFFF?text=Nike+Elite',
   'https://via.placeholder.com/400x400/FF8888/FFFFFF?text=Detail+1',
   'https://via.placeholder.com/400x400/FFAAAA/FFFFFF?text=Detail+2',
   'https://via.placeholder.com/400x400/FFCCCC/FFFFFF?text=Detail+3',
   'ELITE PERFORMANCE.',
   'Built for basketball.',
   '• Dri-FIT technology\n• Strategic cushioning\n• Arch band support',
   '• Fabric: Polyester/Spandex\n• Machine wash',
   NOW(), false),

  (4, 'Nike Everyday Plus Cushioned', 'Training Ankle Socks',
   'The Nike Everyday Plus Cushioned Ankle Socks provide comfort with extra cushioning.',
   '• Shown: Multi-Color\n• Style: SX7667-965',
   60.00,
   'https://via.placeholder.com/400x400/4ECDC4/000000?text=Nike+Ankle',
   'https://via.placeholder.com/400x400/6EDDDD/000000?text=Detail+1',
   'https://via.placeholder.com/400x400/8EEEEE/000000?text=Detail+2',
   'https://via.placeholder.com/400x400/AEFFFF/000000?text=Detail+3',
   'ANKLE COMFORT.',
   'Low-cut comfort for training.',
   '• Extra cushioning\n• Dri-FIT technology\n• Arch support',
   '• Fabric: Cotton/Polyester blend\n• Machine wash',
   NOW(), false),

  (5, 'Air Jordan XXXVI', 'Basketball Shoes',
   'The Air Jordan XXXVI delivers elite performance with responsive cushioning and lightweight support.',
   '• Shown: Multi-Color\n• Style: AJ36-001',
   185.00,
   'https://via.placeholder.com/400x400/FF0000/FFFFFF?text=Air+Jordan',
   'https://via.placeholder.com/400x400/CC0000/FFFFFF?text=Detail+1',
   'https://via.placeholder.com/400x400/990000/FFFFFF?text=Detail+2',
   'https://via.placeholder.com/400x400/660000/FFFFFF?text=Detail+3',
   'LEGENDARY PERFORMANCE.',
   'Built for the modern game.',
   '• Responsive cushioning\n• Lightweight support\n• Excellent traction',
   '• Premium materials\n• Advanced cushioning technology',
   NOW(), false),

  (6, 'Air Jordan XXXVI', 'Basketball Shoes',
   'The Air Jordan XXXVI delivers elite performance with responsive cushioning and lightweight support.',
   '• Shown: Multi-Color\n• Style: AJ36-002',
   185.00,
   'https://via.placeholder.com/400x400/000000/FF0000?text=Air+Jordan',
   'https://via.placeholder.com/400x400/111111/FF0000?text=Detail+1',
   'https://via.placeholder.com/400x400/222222/FF0000?text=Detail+2',
   'https://via.placeholder.com/400x400/333333/FF0000?text=Detail+3',
   'LEGENDARY PERFORMANCE.',
   'Built for the modern game.',
   '• Responsive cushioning\n• Lightweight support\n• Excellent traction',
   '• Premium materials\n• Advanced cushioning technology',
   NOW(), false);

-- 데이터 확인
SELECT * FROM products;
SELECT * FROM product_details;

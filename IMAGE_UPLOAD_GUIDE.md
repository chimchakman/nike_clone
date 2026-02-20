# 실제 이미지 업로드 가이드

## 방법 1: Supabase Storage에 수동 업로드

### 1단계: Storage Bucket 생성

1. Supabase Dashboard → Storage
2. "New Bucket" 클릭
3. Name: `product-images`
4. Public bucket: ✅ 체크
5. Create

### 2단계: 이미지 업로드

1. `product-images` 버킷 클릭
2. "Upload file" 버튼 클릭
3. 이미지 파일들 선택 (image-1.jpg, image-2.jpg, etc.)
4. 업로드 완료 후 각 이미지 클릭 → "Get URL" 복사

### 3단계: SQL에서 URL 업데이트

```sql
-- 업로드한 이미지 URL로 업데이트
UPDATE products
SET image_url = 'https://your-project.supabase.co/storage/v1/object/public/product-images/image-1.jpg'
WHERE id = 1;

UPDATE products
SET image_url = 'https://your-project.supabase.co/storage/v1/object/public/product-images/image-2.jpg'
WHERE id = 2;

-- product_details도 동일하게 업데이트
UPDATE product_details
SET image_url = 'https://your-project.supabase.co/storage/v1/object/public/product-images/image-1.jpg',
    image_detail_1 = 'https://your-project.supabase.co/storage/v1/object/public/product-images/productDetail2.jpg',
    image_detail_2 = 'https://your-project.supabase.co/storage/v1/object/public/product-images/productDetail3.jpg',
    image_detail_3 = 'https://your-project.supabase.co/storage/v1/object/public/product-images/productDetail4.jpg'
WHERE product_id = 1;
```

---

## 방법 2: DataSeeder 사용 (자동화)

DataSeeder를 사용하면 Asset Catalog의 이미지를 자동으로 Supabase에 업로드할 수 있어요.

### 전제조건

Xcode Asset Catalog에 다음 이미지들이 있어야 합니다:
- `image-1`, `image-2`, `image-3`, `image-4` (제품 메인 이미지)
- `homeImage2` (Air Jordan 이미지)
- `productDetail2`, `productDetail3`, `productDetail4` (상세 이미지)

### 사용 방법

앱의 어딘가(예: ContentView나 테스트 뷰)에서 한 번만 실행:

```swift
import SwiftUI

struct DataSeedingView: View {
    @State private var isSeeding = false
    @State private var message = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("데이터 시딩")
                .font(.title)

            Button("제품 데이터 업로드") {
                Task {
                    isSeeding = true
                    message = "업로드 중..."

                    do {
                        // 이미 데이터가 있는지 확인
                        if await DataSeeder.shared.isProductsSeeded() {
                            message = "이미 데이터가 존재합니다!"
                        } else {
                            // 데이터 시딩 실행
                            try await DataSeeder.shared.seedProducts()
                            message = "✅ 업로드 완료!"
                        }
                    } catch {
                        message = "❌ 에러: \(error.localizedDescription)"
                    }

                    isSeeding = false
                }
            }
            .disabled(isSeeding)

            if !message.isEmpty {
                Text(message)
                    .foregroundColor(message.contains("✅") ? .green : .red)
            }

            if isSeeding {
                ProgressView()
            }
        }
        .padding()
    }
}

#Preview {
    DataSeedingView()
}
```

### 주의사항

DataSeeder는:
1. Asset Catalog에서 이미지를 읽어옴
2. JPEG로 변환 (0.8 압축)
3. Supabase Storage에 업로드
4. URL을 받아서 DB에 저장

**시간이 걸릴 수 있어요** (이미지 6개 + 상세 이미지들)

---

## 방법 3: 임시로 placeholder 사용

개발 중에는 placeholder를 그대로 사용해도 괜찮아요!

현재 SQL 파일은 https://via.placeholder.com을 사용하고 있어서:
- ✅ 바로 작동함
- ✅ 레이아웃 확인 가능
- ⚠️ 실제 제품 이미지는 아님

나중에 실제 이미지로 교체하면 됩니다.

---

## 추천 순서

1. **먼저 placeholder로 테스트** (지금 만든 SQL 파일 사용)
   → 앱이 정상 작동하는지 확인

2. **나중에 실제 이미지 업로드**
   → Storage에 수동 업로드 or DataSeeder 사용

3. **프로덕션에서는 진짜 제품 이미지 사용**

---

## 문제 해결

### 이미지가 안 보여요
- Supabase Storage 버킷이 Public인지 확인
- 이미지 URL이 올바른지 확인
- 네트워크 연결 확인

### DataSeeder가 실패해요
- Asset Catalog에 이미지가 있는지 확인
- Supabase 연결 확인
- 에러 메시지 확인

### Storage bucket을 못 찾겠어요
```sql
-- Supabase SQL Editor에서 실행
SELECT * FROM storage.buckets;
```

이렇게 하면 bucket 목록을 볼 수 있어요!

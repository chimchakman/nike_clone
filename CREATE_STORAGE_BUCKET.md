# Supabase Storage Bucket 생성 가이드

## 단계별 생성 방법

### 1. Supabase Dashboard에서 Storage 메뉴 선택

### 2. "New Bucket" 또는 "Create a new bucket" 버튼 클릭

### 3. Bucket 설정

```
Name: product-images
Public bucket: ✅ 체크 (중요!)
File size limit: 기본값 (50MB)
Allowed MIME types: 기본값 (모두 허용)
```

**중요:** Public bucket을 체크해야 앱에서 이미지 URL에 직접 접근할 수 있어요!

### 4. "Create bucket" 버튼 클릭

---

## 생성 확인

Storage 메뉴에서 `product-images` 버킷이 보이면 성공!

---

## 대안: SQL로 Bucket 생성

만약 UI에서 안 되면 SQL Editor에서 실행:

```sql
-- Storage bucket 생성
INSERT INTO storage.buckets (id, name, public)
VALUES ('product-images', 'product-images', true);

-- 생성 확인
SELECT * FROM storage.buckets WHERE id = 'product-images';
```

---

## Bucket 생성 후 할 일

### 옵션 1: UI에서 이미지 업로드

1. `product-images` 버킷 클릭
2. "Upload" 버튼 클릭
3. 이미지 파일 선택 (image-1.jpg, image-2.jpg 등)
4. 업로드 완료!

### 옵션 2: DataSeeder 사용

Bucket이 생성되면 앱에서 DataSeeder를 실행할 수 있어요:

```swift
Task {
    try await DataSeeder.shared.seedProducts()
}
```

---

## 문제 해결

### "Bucket already exists" 에러

이미 bucket이 있다는 뜻이에요. 확인:

```sql
SELECT * FROM storage.buckets;
```

### Bucket은 있는데 "Access denied" 에러

Public 설정 확인:

```sql
-- Bucket을 public으로 변경
UPDATE storage.buckets
SET public = true
WHERE id = 'product-images';
```

### Bucket을 삭제하고 다시 만들고 싶어요

```sql
-- 주의: 안의 모든 파일도 삭제됩니다!
DELETE FROM storage.buckets WHERE id = 'product-images';
```

그 다음 UI나 SQL로 다시 생성하세요.

---

## Public Access 정책 설정 (필요시)

Bucket을 생성했는데도 접근이 안 되면:

```sql
-- Storage policies 확인
SELECT * FROM storage.policies WHERE bucket_id = 'product-images';

-- Public read access 정책 추가
INSERT INTO storage.policies (
  id,
  bucket_id,
  name,
  definition
)
VALUES (
  'public-read-product-images',
  'product-images',
  'Public Read Access',
  '{
    "role": "public",
    "action": "SELECT",
    "using": true
  }'::jsonb
);
```

하지만 대부분의 경우 Bucket을 Public으로 만들면 별도 정책 없이도 작동합니다!

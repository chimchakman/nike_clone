-- 간단한 Storage 정책 설정
-- Supabase가 제공하는 헬퍼 함수 사용

-- 1. Bucket이 public인지 확인
SELECT id, name, public FROM storage.buckets WHERE id = 'product-images';

-- 2. Bucket을 완전히 public으로 설정 (UI에서 하는 것과 동일)
UPDATE storage.buckets
SET public = true,
    file_size_limit = 52428800,  -- 50MB
    allowed_mime_types = NULL     -- 모든 타입 허용
WHERE id = 'product-images';

-- 3. 확인
SELECT * FROM storage.buckets WHERE id = 'product-images';

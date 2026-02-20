-- Storage RLS 정책 수정
-- product-images 버킷에 대한 업로드 권한 부여

-- 1. storage.objects 테이블의 RLS 활성화 확인
ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

-- 2. 기존 product-images 정책 삭제 (있으면)
DROP POLICY IF EXISTS "Allow public uploads to product-images" ON storage.objects;
DROP POLICY IF EXISTS "Allow public read from product-images" ON storage.objects;
DROP POLICY IF EXISTS "Allow public delete from product-images" ON storage.objects;

-- 3. Public 업로드 허용 (누구나 업로드 가능)
CREATE POLICY "Allow public uploads to product-images"
ON storage.objects
FOR INSERT
TO public
WITH CHECK (
    bucket_id = 'product-images'
);

-- 4. Public 읽기 허용 (누구나 읽기 가능)
CREATE POLICY "Allow public read from product-images"
ON storage.objects
FOR SELECT
TO public
USING (
    bucket_id = 'product-images'
);

-- 5. Public 업데이트 허용 (선택사항)
CREATE POLICY "Allow public update to product-images"
ON storage.objects
FOR UPDATE
TO public
USING (
    bucket_id = 'product-images'
)
WITH CHECK (
    bucket_id = 'product-images'
);

-- 6. Public 삭제 허용 (선택사항)
CREATE POLICY "Allow public delete from product-images"
ON storage.objects
FOR DELETE
TO public
USING (
    bucket_id = 'product-images'
);

-- 정책 확인
SELECT
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual,
    with_check
FROM pg_policies
WHERE tablename = 'objects' AND schemaname = 'storage'
ORDER BY policyname;

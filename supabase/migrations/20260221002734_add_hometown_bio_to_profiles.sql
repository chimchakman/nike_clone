-- Add hometown and bio columns to profiles table
ALTER TABLE profiles
ADD COLUMN IF NOT EXISTS hometown TEXT,
ADD COLUMN IF NOT EXISTS bio TEXT;

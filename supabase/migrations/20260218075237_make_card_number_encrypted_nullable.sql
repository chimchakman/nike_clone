-- Make card_number_encrypted nullable to align with Swift code security design
ALTER TABLE payment_cards
ALTER COLUMN card_number_encrypted DROP NOT NULL;

-- Add comment explaining why this column is nullable
COMMENT ON COLUMN payment_cards.card_number_encrypted IS
'Encrypted card number (nullable for security - app stores only last 4 digits)';

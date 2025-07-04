-- Create credential_status_transaction table
CREATE TABLE IF NOT EXISTS credential_status_transaction (
    transaction_log_id SERIAL PRIMARY KEY,        -- Unique ID for this transaction log entry
    credential_id VARCHAR(255) NOT NULL,          -- The ID of the credential this transaction pertains to (should exist in ledger.credential_id)
    status_purpose VARCHAR(100),                  -- The purpose of this status update
    status_value boolean,                         -- The status value (true/false)
    status_list_credential_id VARCHAR(255),       -- The ID of the status list credential involved, if any
    status_list_index BIGINT,                     -- The index on the status list, if any
    cr_dtimes TIMESTAMP NOT NULL DEFAULT NOW(),   -- Creation timestamp
    upd_dtimes TIMESTAMP,                         -- Update timestamp

    -- Foreign key constraint to ledger table
    CONSTRAINT fk_credential_status_transaction_ledger
        FOREIGN KEY(credential_id)
        REFERENCES ledger(credential_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    -- Foreign key constraint to status_list_credential table
    CONSTRAINT fk_credential_status_transaction_status_list
        FOREIGN KEY(status_list_credential_id)
        REFERENCES status_list_credential(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Add comments for documentation
COMMENT ON TABLE credential_status_transaction IS 'Transaction log for credential status changes and updates.';
COMMENT ON COLUMN credential_status_transaction.transaction_log_id IS 'Serial primary key for the transaction log entry.';
COMMENT ON COLUMN credential_status_transaction.credential_id IS 'The ID of the credential this transaction pertains to (references ledger.credential_id).';
COMMENT ON COLUMN credential_status_transaction.status_purpose IS 'The purpose of this status update (e.g., revocation, suspension).';
COMMENT ON COLUMN credential_status_transaction.status_value IS 'The status value (true for revoked/suspended, false for active).';
COMMENT ON COLUMN credential_status_transaction.status_list_credential_id IS 'The ID of the status list credential involved, if any.';
COMMENT ON COLUMN credential_status_transaction.status_list_index IS 'The index on the status list, if any.';
COMMENT ON COLUMN credential_status_transaction.cr_dtimes IS 'Timestamp when this transaction was created.';
COMMENT ON COLUMN credential_status_transaction.upd_dtimes IS 'Timestamp when this transaction was last updated.';

-- Create indexes for credential_status_transaction
CREATE INDEX IF NOT EXISTS idx_cst_credential_id ON credential_status_transaction(credential_id);
CREATE INDEX IF NOT EXISTS idx_cst_status_purpose ON credential_status_transaction(status_purpose);
CREATE INDEX IF NOT EXISTS idx_cst_status_list_credential_id ON credential_status_transaction(status_list_credential_id);
CREATE INDEX IF NOT EXISTS idx_cst_status_list_index ON credential_status_transaction(status_list_index);
CREATE INDEX IF NOT EXISTS idx_cst_cr_dtimes ON credential_status_transaction(cr_dtimes);
CREATE INDEX IF NOT EXISTS idx_cst_status_value ON credential_status_transaction(status_value);
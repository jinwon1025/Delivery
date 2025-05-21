```
CREATE TABLE notice (
    notice_idx INT PRIMARY KEY,    
    title NVARCHAR(MAX),    
    content NVARCHAR(MAX),    
    created_time DATETIME DEFAULT GETDATE(),    
    updated_time DATETIME,    
    deleteyn NVARCHAR(1) NOT NULL DEFAULT 'N',    
    useyn NVARCHAR(1) NOT NULL DEFAULT 'N',    
    notice_type NVARCHAR(1),    
    writer NVARCHAR(50)
);

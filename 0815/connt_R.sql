ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'ilave300'; #給予資料庫帳密別名
CREATE DATABASE test CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; #新的測試database，建立時先決定編碼
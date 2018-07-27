CREATE USER sonar;
CREATE DATABASE sonar OWNER sonar; 
ALTER USER kong WITH password 'sonar'; 
GRANT all on database sonar to sonar;

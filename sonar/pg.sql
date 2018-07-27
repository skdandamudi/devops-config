CREATE USER sonar;
CREATE DATABASE sonar OWNER sonar; 
ALTER USER sonar WITH password 'sonar'; 
GRANT all on database sonar to sonar;

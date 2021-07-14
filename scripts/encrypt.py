#from passlib.hash import sha256_crypt as sha256
from passlib.hash import sha512_crypt as sha512

passwd="password"
#sha256_passwd = sha256.encrypt(passwd, rounds=5000)
sha512_passwd = sha512.encrypt(passwd, rounds=5000)

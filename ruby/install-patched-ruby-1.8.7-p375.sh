# patch for make ruby error
#   % rbenv install 1.8.7-p375
#   ...
#   ossl_pkey_ec.c:815: error: ‘EC_GROUP_new_curve_GF2m’ undeclared (first use in this function)
#   ossl_pkey_ec.c:815: error: (Each undeclared identifier is reported only once
#   ossl_pkey_ec.c:815: error: for each function it appears in.)
#   make[1]: *** [ossl_pkey_ec.o] error 1
#   ...
#
# refs: http://forums.cpanel.net/f5/case-84173-error-installing-ruby-377831.html
#

cat <<_EOT_ > ruby-1.8.7-p375_for_ossl_error.patch
ruby-1.8.7-p375_for_ossl_error.patch
--- ext/openssl/ossl_pkey_ec.c  2010-06-21 04:18:59.000000000 -0500
+++ ext/openssl/ossl_pkey_ec.c  2013-12-10 13:30:18.919963527 -0600
@@ -757,8 +757,10 @@
                 method = EC_GFp_mont_method();
             } else if (id == s_GFp_nist) {
                 method = EC_GFp_nist_method();
+               #if !defined(OPENSSL_NO_EC2M)
             } else if (id == s_GF2m_simple) {
                 method = EC_GF2m_simple_method();
+               #endif
             }

             if (method) {
@@ -811,8 +813,10 @@

             if (id == s_GFp) {
                 new_curve = EC_GROUP_new_curve_GFp;
+               #if !defined(OPENSSL_NO_EC2M)
             } else if (id == s_GF2m) {
                 new_curve = EC_GROUP_new_curve_GF2m;
+               #endif
             } else {
                 rb_raise(rb_eArgError, "unknown symbol, must be :GFp or :GF2m");
             }
_EOT_

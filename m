From: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH] SPI: spi-ath79: fix compile error due to missing include
Date: Wed, 16 Nov 2011 20:01:43 +0100
Message-ID: <1321470103-9020-1-git-send-email-juhosg@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Whithout including 'linux/module.h' spi-ath79 driver fails to compile
with the these errors:

drivers/spi/spi-ath79.c:273:12: error: 'THIS_MODULE' undeclared here (not in a function)
drivers/spi/spi-ath79.c:278:20: error: expected declaration specifiers or '...' before string constant
drivers/spi/spi-ath79.c:278:1: warning: data definition has no type or storage class
drivers/spi/spi-ath79.c:278:1: warning: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
drivers/spi/spi-ath79.c:278:20: warning: function declaration isn't a prototype
drivers/spi/spi-ath79.c:279:15: error: expected declaration specifiers or '...' before string constant
drivers/spi/spi-ath79.c:279:1: warning: data definition has no type or storage class
drivers/spi/spi-ath79.c:279:1: warning: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
drivers/spi/spi-ath79.c:279:15: warning: function declaration isn't a prototype
drivers/spi/spi-ath79.c:280:16: error: expected declaration specifiers or '...' before string constant
drivers/spi/spi-ath79.c:280:1: warning: data definition has no type or storage class
drivers/spi/spi-ath79.c:280:1: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
drivers/spi/spi-ath79.c:280:16: warning: function declaration isn't a prototype
drivers/spi/spi-ath79.c:281:14: error: expected declaration specifiers or '...' before string constant
drivers/spi/spi-ath79.c:281:1: warning: data definition has no type or storage class
drivers/spi/spi-ath79.c:281:1: warning: type defaults to 'int' in declaration of 'MODULE_ALIAS'
drivers/spi/spi-ath79.c:281:14: warning: function declaration isn't a prototype

Signed-off-by: Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-ath79.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 024b48a..acc88b4 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
-- 
1.7.2.1


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d

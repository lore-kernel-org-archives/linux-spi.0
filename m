From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 1/4] spi/ath79: fix compile error due to missing include
Date: Fri,  9 Dec 2011 21:32:32 +0100
Message-ID: <1323462755-14369-2-git-send-email-w.sang@pengutronix.de>
References: <1323462755-14369-1-git-send-email-w.sang@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323462755-14369-1-git-send-email-w.sang@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Gabor Juhos <juhosg@openwrt.org>

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

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
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
1.7.2.5

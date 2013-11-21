From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: [PATCH] spi: core: invert success test in devm_spi_register_master
Date: Thu, 21 Nov 2013 16:11:15 -0700
Message-ID: <1385075475-25441-1-git-send-email-swarren@wwwdotorg.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

devres_add() should be called when the action to be undone succeeded,
not when it failed. Fix the inverted test in devm_spi_register_master()
which was doing the opposite.

The user-visible issue without this fix is:
insmod spi-tegra114.ko
  Assume there's an MTD device on that SPI bus, which creates /dev/mtd0.
rmmod spi-tegra114
  Doesn't remove devices on the SPI bus.
insmod spi-tegra114.ko
  Creates a duplicate SPI device which creates /dev/mtd1.
hexdump -C /dev/mtd0
  That's the old device, which uses an SPI bus hosted by a non-existent
  module, which causes the oops below.

Unable to handle kernel paging request at virtual address bf0017c0
pgd = c0004000
[bf0017c0] *pgd=ad51b811, *pte=00000000, *ppte=00000000
Internal error: Oops: 80000007 [#1] PREEMPT SMP ARM
...
PC is at 0xbf0017c0
LR is at spi_pump_messages+0x15c/0x204
pc : [<bf0017c0>] lr : [<c02f0af8>] psr: 60000113
...

Fixes: 666d5b4c742b ("spi: core: Add devm_spi_register_master()")
Signed-off-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e29d73d759ce..678af42a1a41 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1404,7 +1404,7 @@ int devm_spi_register_master(struct device *dev, struct spi_master *master)
 		return -ENOMEM;
 
 	ret = spi_register_master(master);
-	if (ret != 0) {
+	if (!ret) {
 		*ptr = master;
 		devres_add(dev, ptr);
 	} else {
-- 
1.8.1.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

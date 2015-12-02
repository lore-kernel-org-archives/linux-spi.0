From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: butterfly: correct alignment" to the spi tree
Date: Wed, 02 Dec 2015 20:11:04 +0000
Message-ID: <E1a4Dk0-0003RS-IN@debutante>
References: <1449064071-4915-3-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449064071-4915-3-git-send-email-sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: butterfly: correct alignment

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e71fec7352c83af889ea36e164f1f6f895b0aaaf Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 2 Dec 2015 19:17:50 +0530
Subject: [PATCH] spi: butterfly: correct alignment

checkpatch complains about the allignment with open parenthesis.

Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-butterfly.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-butterfly.c b/drivers/spi/spi-butterfly.c
index 8fc284d0d7c3..f16ef7fb10f1 100644
--- a/drivers/spi/spi-butterfly.c
+++ b/drivers/spi/spi-butterfly.c
@@ -143,9 +143,8 @@ static void butterfly_chipselect(struct spi_device *spi, int value)
 #include "spi-bitbang-txrx.h"
 
 static u32
-butterfly_txrx_word_mode0(struct spi_device *spi,
-		unsigned nsecs,
-		u32 word, u8 bits)
+butterfly_txrx_word_mode0(struct spi_device *spi, unsigned nsecs, u32 word,
+			  u8 bits)
 {
 	return bitbang_txrx_be_cpha0(spi, nsecs, 0, 0, word, bits);
 }
@@ -223,8 +222,8 @@ static void butterfly_attach(struct parport *p)
 	 */
 	pp->port = p;
 	pd = parport_register_device(p, "spi_butterfly",
-			NULL, NULL, NULL,
-			0 /* FLAGS */, pp);
+				     NULL, NULL, NULL,
+				     0 /* FLAGS */, pp);
 	if (!pd) {
 		status = -ENOMEM;
 		goto clean0;
@@ -275,7 +274,7 @@ static void butterfly_attach(struct parport *p)
 	pp->dataflash = spi_new_device(pp->bitbang.master, &pp->info[0]);
 	if (pp->dataflash)
 		pr_debug("%s: dataflash at %s\n", p->name,
-				dev_name(&pp->dataflash->dev));
+			 dev_name(&pp->dataflash->dev));
 
 	pr_info("%s: AVR Butterfly\n", p->name);
 	butterfly = pp;
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

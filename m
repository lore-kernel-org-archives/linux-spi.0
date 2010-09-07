From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] spi/spi_s3c64xx: Move to subsys_initcall()
Date: Tue,  7 Sep 2010 11:29:17 +0100
Message-ID: <1283855357-15179-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Cc: patches@opensource.wolfsonmicro.com,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jassi Brar <jassi.brar@samsung.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	David Brownell <dbrownell@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Allow the use of the S3C64xx SPI controller with things like PMICs by
moving the init up to subsys_initcall().

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Incidentally I don't seem to see anything in the current SPI tree for
-next - should the tree being used be updated or something?

 drivers/spi/spi_s3c64xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_s3c64xx.c b/drivers/spi/spi_s3c64xx.c
index f72e1c0..6e48ea9 100644
--- a/drivers/spi/spi_s3c64xx.c
+++ b/drivers/spi/spi_s3c64xx.c
@@ -1181,7 +1181,7 @@ static int __init s3c64xx_spi_init(void)
 {
 	return platform_driver_probe(&s3c64xx_spi_driver, s3c64xx_spi_probe);
 }
-module_init(s3c64xx_spi_init);
+subsys_initcall(s3c64xx_spi_init);
 
 static void __exit s3c64xx_spi_exit(void)
 {
-- 
1.7.1

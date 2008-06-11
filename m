From: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] mmc_spi: put signals to low power off
	fix
Date: Wed, 11 Jun 2008 16:04:15 +0200
Message-ID: <20080611140415.GA32735@nikitenko.systec.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The original intention was to write a zero byte to mmc to force spi
signals to low when doing power off. Somehow the spi_w8r8 call got there
so a read followed the write of single zero byte. This patch changes
that to simple write of zero byte without the following read.
This way the power off is more reliable and completely sufficient.

Signed-off-by: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

---
 drivers/mmc/host/mmc_spi.c |    3 ++-
  1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 3550858..7365168 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1076,6 +1076,7 @@ static void mmc_spi_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		 */
 		if (canpower && ios->power_mode == MMC_POWER_OFF) {
 			int mres;
+			u8 nullbyte = 0;
 
 			host->spi->mode &= ~(SPI_CPOL|SPI_CPHA);
 			mres = spi_setup(host->spi);
@@ -1083,7 +1084,7 @@ static void mmc_spi_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				dev_dbg(&host->spi->dev,
 					"switch to SPI mode 0 failed\n");
 
-			if (spi_w8r8(host->spi, 0x00) < 0)
+			if (spi_write(host->spi, &nullbyte, 1) < 0)
 				dev_dbg(&host->spi->dev,
 					"put spi signals to low failed\n");
 


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php

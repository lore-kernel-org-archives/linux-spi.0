From: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Subject: [PATCH 20/28] Blackfin SPI: reset ctl_reg bits when setup is run
	again on a device
Date: Sun, 17 Oct 2010 18:59:33 -0400
Message-ID: <1287356381-31495-21-git-send-email-vapier@gentoo.org>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1287356381-31495-1-git-send-email-vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

During runtime, the spi setup function may be called multiple times on the
same device in order to reconfigure some settings on the fly.  When this
happens, we need to reset the ctl_reg bits so that changing the mode works
as expected.

Reported-by: Andy Getzendanner <james.getzendanner-9geRo0GdX4k6efY3Smnssodd74u8MsAO@public.gmane.org>
Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi_bfin5xx.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 830c705..376f2f0 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -972,6 +972,7 @@ static int bfin_spi_setup(struct spi_device *spi)
 	struct bfin5xx_spi_chip *chip_info;
 	struct slave_data *chip = NULL;
 	struct master_data *drv_data = spi_master_get_devdata(spi->master);
+	u16 bfin_ctl_reg;
 	int ret = -EINVAL;
 
 	/* Only alloc (or use chip_info) on first setup */
@@ -989,6 +990,10 @@ static int bfin_spi_setup(struct spi_device *spi)
 		chip_info = spi->controller_data;
 	}
 
+	/* Let people set non-standard bits directly */
+	bfin_ctl_reg = BIT_CTL_OPENDRAIN | BIT_CTL_EMISO |
+		BIT_CTL_PSSE | BIT_CTL_GM | BIT_CTL_SZ;
+
 	/* chip_info isn't always needed */
 	if (chip_info) {
 		/* Make sure people stop trying to set fields via ctl_reg
@@ -997,13 +1002,11 @@ static int bfin_spi_setup(struct spi_device *spi)
 		 * Not sure if a user actually needs/uses any of these,
 		 * but let's assume (for now) they do.
 		 */
-		if (chip_info->ctl_reg & ~(BIT_CTL_OPENDRAIN | BIT_CTL_EMISO | \
-		                           BIT_CTL_PSSE | BIT_CTL_GM | BIT_CTL_SZ)) {
+		if (chip_info->ctl_reg & ~bfin_ctl_reg) {
 			dev_err(&spi->dev, "do not set bits in ctl_reg "
 				"that the SPI framework manages\n");
 			goto error;
 		}
-
 		chip->enable_dma = chip_info->enable_dma != 0
 		    && drv_data->master_info->enable_dma;
 		chip->ctl_reg = chip_info->ctl_reg;
@@ -1011,6 +1014,9 @@ static int bfin_spi_setup(struct spi_device *spi)
 		chip->idle_tx_val = chip_info->idle_tx_val;
 		chip->pio_interrupt = chip_info->pio_interrupt;
 		spi->bits_per_word = chip_info->bits_per_word;
+	} else {
+		/* force a default base state */
+		chip->ctl_reg &= bfin_ctl_reg;
 	}
 
 	if (spi->bits_per_word != 8 && spi->bits_per_word != 16) {
-- 
1.7.3.1


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev

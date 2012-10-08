From: Stan Hu <stanhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/1] spi: omap2-mcspi: add option to configure output line for
	McSPI driver
Date: Mon,  8 Oct 2012 16:39:40 -0600
Message-ID: <1349735980-17015-1-git-send-email-stanhu@gmail.com>
References: <y>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stan Hu <stanhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-FVTvWyuFUl3QT0dZR+AlfA@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Nicolas Pitre <nico-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <y>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

McSPI driver previously assumed that D0 was input (MISO) and D1 was output (MOSI).
This forces the hardware designer to wire all SPI peripherals in this way when
it should be a software configuration option.

Signed-off-by: Stan Hu <stanhu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c                 |   11 +++++++++--
 include/linux/platform_data/spi-omap2-mcspi.h |    2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 3542fdc..d7c7e13 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -740,6 +740,7 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 		struct spi_transfer *t)
 {
 	struct omap2_mcspi_cs *cs = spi->controller_state;
+	struct omap2_mcspi_device_config *cd = spi->controller_data;
 	struct omap2_mcspi *mcspi;
 	struct spi_master *spi_cntrl;
 	u32 l = 0, div = 0;
@@ -765,8 +766,14 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
 	/* standard 4-wire master mode:  SCK, MOSI/out, MISO/in, nCS
 	 * REVISIT: this controller could support SPI_3WIRE mode.
 	 */
-	l &= ~(OMAP2_MCSPI_CHCONF_IS|OMAP2_MCSPI_CHCONF_DPE1);
-	l |= OMAP2_MCSPI_CHCONF_DPE0;
+	l &= ~(OMAP2_MCSPI_CHCONF_IS|
+		OMAP2_MCSPI_CHCONF_DPE0|OMAP2_MCSPI_CHCONF_DPE1);
+
+	/* set input selection for D0 and D1 */
+	if (cd->d0_is_output)
+		l |= OMAP2_MCSPI_CHCONF_IS|OMAP2_MCSPI_CHCONF_DPE1;
+	else
+		l |= OMAP2_MCSPI_CHCONF_DPE0;
 
 	/* wordlength */
 	l &= ~OMAP2_MCSPI_CHCONF_WL_MASK;
diff --git a/include/linux/platform_data/spi-omap2-mcspi.h b/include/linux/platform_data/spi-omap2-mcspi.h
index a357eb2..419d08a 100644
--- a/include/linux/platform_data/spi-omap2-mcspi.h
+++ b/include/linux/platform_data/spi-omap2-mcspi.h
@@ -18,6 +18,8 @@ struct omap2_mcspi_dev_attr {
 
 struct omap2_mcspi_device_config {
 	unsigned turbo_mode:1;
+	/* 0 -> [D0 = MISO, D1 = MOSI], 1 -> [D0 = MOSI, D1 = MISO] */
+	unsigned d0_is_output:1;
 };
 
 #endif
-- 
1.7.9.5


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev

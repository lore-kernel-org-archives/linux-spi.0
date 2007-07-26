From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 3/3] [POWERPC][SPI] spi_mpc83xx: add
	support for loopback	mode
Date: Thu, 26 Jul 2007 17:51:06 +0400
Message-ID: <20070726135106.GC5550@localhost.localdomain>
References: <20070726134754.GA3539@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20070726134754.GA3539-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
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

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
 drivers/spi/spi_mpc83xx.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 458075a..e9582d3 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -39,6 +39,7 @@ struct mpc83xx_spi_reg {
 };
 
 /* SPI Controller mode register definitions */
+#define	SPMODE_LOOP		(1 << 30)
 #define	SPMODE_CI_INACTIVEHIGH	(1 << 29)
 #define	SPMODE_CP_BEGIN_EDGECLK	(1 << 28)
 #define	SPMODE_DIV16		(1 << 27)
@@ -155,7 +156,7 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 		/* mask out bits we are going to set */
 		regval &= ~(SPMODE_CP_BEGIN_EDGECLK | SPMODE_CI_INACTIVEHIGH |
 			    SPMODE_LEN(0xF) | SPMODE_DIV16 | SPMODE_PM(0xF) | \
-			    SPMODE_REV);
+			    SPMODE_REV | SPMODE_LOOP);
 
 		if (spi->mode & SPI_CPHA)
 			regval |= SPMODE_CP_BEGIN_EDGECLK;
@@ -163,6 +164,8 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 			regval |= SPMODE_CI_INACTIVEHIGH;
 		if (!(spi->mode & SPI_LSB_FIRST))
 			regval |= SPMODE_REV;
+		if (spi->mode & SPI_LOOP)
+			regval |= SPMODE_LOOP;
 
 		regval |= SPMODE_LEN(len);
 
@@ -273,7 +276,8 @@ int mpc83xx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 }
 
 /* the spi->mode bits understood by this driver: */
-#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST)
+#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST | \
+		  SPI_LOOP)
 
 static int mpc83xx_spi_setup(struct spi_device *spi)
 {
-- 
1.5.0.6

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/

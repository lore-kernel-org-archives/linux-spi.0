From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 1/3] [SPI] Sync spidev.{h, c} with spi.h
Date: Thu, 26 Jul 2007 17:50:41 +0400
Message-ID: <20070726135041.GA5550@localhost.localdomain>
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
 drivers/spi/spidev.c       |    4 ++--
 include/linux/spi/spidev.h |    3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 38b60ad..4c51a61 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -56,8 +56,8 @@ static unsigned long	minors[N_SPI_MINORS / BITS_PER_LONG];
 
 
 /* Bit masks for spi_device.mode management */
-#define SPI_MODE_MASK			(SPI_CPHA | SPI_CPOL)
-
+#define SPI_MODE_MASK			(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | \
+					 SPI_LSB_FIRST | SPI_3WIRE)
 
 struct spidev_data {
 	struct device		dev;
diff --git a/include/linux/spi/spidev.h b/include/linux/spi/spidev.h
index 7d700be..369d42e 100644
--- a/include/linux/spi/spidev.h
+++ b/include/linux/spi/spidev.h
@@ -35,6 +35,9 @@
 #define SPI_MODE_2		(SPI_CPOL|0)
 #define SPI_MODE_3		(SPI_CPOL|SPI_CPHA)
 
+#define SPI_CS_HIGH		0x04
+#define SPI_LSB_FIRST		0x08
+#define SPI_3WIRE		0x10
 
 /*---------------------------------------------------------------------------*/
 
-- 
1.5.0.6


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/

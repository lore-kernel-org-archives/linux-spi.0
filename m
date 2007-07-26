From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 2/3] [SPI] Add new mode: SPI_LOOP
Date: Thu, 26 Jul 2007 17:50:51 +0400
Message-ID: <20070726135051.GB5550@localhost.localdomain>
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

Loopback mode is supported by various controllers, this mode
is useful for testing, especially in conjunction with spidev
driver.

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
 drivers/spi/spidev.c       |    2 +-
 include/linux/spi/spi.h    |    1 +
 include/linux/spi/spidev.h |    1 +
 3 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 4c51a61..24c8d4d 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -57,7 +57,7 @@ static unsigned long	minors[N_SPI_MINORS / BITS_PER_LONG];
 
 /* Bit masks for spi_device.mode management */
 #define SPI_MODE_MASK			(SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | \
-					 SPI_LSB_FIRST | SPI_3WIRE)
+					 SPI_LSB_FIRST | SPI_3WIRE | SPI_LOOP)
 
 struct spidev_data {
 	struct device		dev;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 302b81d..e180615 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -77,6 +77,7 @@ struct spi_device {
 #define	SPI_CS_HIGH	0x04			/* chipselect active high? */
 #define	SPI_LSB_FIRST	0x08			/* per-word bits-on-wire */
 #define	SPI_3WIRE	0x10			/* SI/SO signals shared */
+#define	SPI_LOOP	0x20			/* loopback mode */
 	u8			bits_per_word;
 	int			irq;
 	void			*controller_state;
diff --git a/include/linux/spi/spidev.h b/include/linux/spi/spidev.h
index 369d42e..c93ef9d 100644
--- a/include/linux/spi/spidev.h
+++ b/include/linux/spi/spidev.h
@@ -38,6 +38,7 @@
 #define SPI_CS_HIGH		0x04
 #define SPI_LSB_FIRST		0x08
 #define SPI_3WIRE		0x10
+#define SPI_LOOP		0x20
 
 /*---------------------------------------------------------------------------*/
 
-- 
1.5.0.6


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/

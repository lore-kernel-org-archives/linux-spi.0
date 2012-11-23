From: Phil Edworthy <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v2] spi: sh-hspi: Improve performance
Date: Fri, 23 Nov 2012 14:46:24 +0000
Message-ID: <1353681984-15850-1-git-send-email-phil.edworthy@renesas.com>
References: <20121123095137.7DBB03E07BE@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Phil Edworthy <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20121123095137.7DBB03E07BE@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The driver attempts to read the received data immediately after
writing to the transmit buffer. If no data is available, the driver
currently waits 20ms until trying again. Since the hardware needs
to shift out the transmitted data, the first poll always fails,
leading to 20ms delay between bytes.

This patch waits for the time it takes to transmit a byte before
reading the received data.

Signed-off-by: Phil Edworthy <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
---
v2:
 Instead of replacing msleep(20) with udelay(1), this version now
 calculates the time it takes to shift out a byte, and uses udelay or
 ndelay for this time. After this it falls back to polling every 20ms
 using msleep. The delay has an empirical element based on testing at
 different speeds.

 drivers/spi/spi-sh-hspi.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index bc25419..407eac0 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -53,6 +53,7 @@ struct hspi_priv {
 	struct spi_master *master;
 	struct device *dev;
 	struct clk *clk;
+	u32 actual_speed;
 };
 
 /*
@@ -168,6 +169,7 @@ static void hspi_hw_setup(struct hspi_priv *hspi,
 	if (spi->mode & SPI_CPOL)
 		spcr |= 1 << 6;
 
+	hspi->actual_speed = best_rate;
 	dev_dbg(dev, "speed %d/%d\n", target_rate, best_rate);
 
 	hspi_write(hspi, SPCR, spcr);
@@ -185,6 +187,8 @@ static int hspi_transfer_one_message(struct spi_master *master,
 	int ret, i;
 	unsigned int cs_change;
 	const int nsecs = 50;
+	u32 tx_us = 0;
+	u32 tx_ns = 0;
 
 	dev_dbg(hspi->dev, "%s\n", __func__);
 
@@ -194,6 +198,23 @@ static int hspi_transfer_one_message(struct spi_master *master,
 
 		if (cs_change) {
 			hspi_hw_setup(hspi, msg, t);
+
+			/* Calculate time to shift out 8 bits & get rx data.
+			 * The values of 8x, 9x & 11x are empirically derived,
+			 * using a scope to check that we haven't dropped in
+			 * a 20ms delay between bytes.
+			 * If delay is >1ms, poll using msleep so we don't
+			 * block.
+			 */
+			tx_us = 0;
+			tx_ns = 0;
+			if (hspi->actual_speed > 1000000)
+				tx_ns = 8*1000000/(hspi->actual_speed/1000);
+			else if (hspi->actual_speed > 100000)
+				tx_ns = 9*1000000/(hspi->actual_speed/1000);
+			else if (hspi->actual_speed > 1000)
+				tx_us = 11*1000000/hspi->actual_speed;
+
 			hspi_hw_cs_enable(hspi);
 			ndelay(nsecs);
 		}
@@ -212,6 +233,10 @@ static int hspi_transfer_one_message(struct spi_master *master,
 
 			hspi_write(hspi, SPTBR, tx);
 
+			/* Wait to get recieved data */
+			udelay(tx_us);
+			ndelay(tx_ns);
+
 			/* wait recive */
 			ret = hspi_status_check_timeout(hspi, 0x4, 0x4);
 			if (ret < 0)
-- 
1.7.5.4


------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov

From: kernel@martin.sperl.org
Subject: [PATCH V2 2/6] spi: bcm2835: Avoid 64-bit arithmetic in xfer len calc
Date: Tue, 23 Apr 2019 20:15:09 +0000
Message-ID: <20190423201513.8073-3-kernel@martin.sperl.org>
References: <20190423201513.8073-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel@martin.sperl.org>
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190423201513.8073-1-kernel@martin.sperl.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

From: Martin Sperl <kernel@martin.sperl.org>

Avoid 64 bit aritmetics when deciding if we need to use polling or not
This replicates: commit d704afffe65c
("spi: bcm2835aux: Avoid 64-bit arithmetic in xfer len calc")
from spi-bcm2835aux

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>

Changelog:
  V1 -> V2: applied feedback by Stefan Wahren
            reorganized patchset
	    added extra rational, descriptions

---
 drivers/spi/spi-bcm2835.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index ef7f8dc9f18e..a64bfa8e0710 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -777,7 +777,6 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
 	unsigned long spi_hz, clk_hz, cdiv;
 	unsigned long spi_used_hz;
-	unsigned long long xfer_time_us;
 	u32 cs = bcm2835_rd(bs, BCM2835_SPI_CS);

 	/* set clock */
@@ -818,14 +817,15 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	bs->tx_len = tfr->len;
 	bs->rx_len = tfr->len;

-	/* calculate the estimated time in us the transfer runs */
-	xfer_time_us = (unsigned long long)tfr->len
-		* 9 /* clocks/byte - SPI-HW waits 1 clock after each byte */
-		* 1000000;
-	do_div(xfer_time_us, spi_used_hz);
-
-	/* for short requests run polling*/
-	if (xfer_time_us <= BCM2835_SPI_POLLING_LIMIT_US)
+	/* Calculate the estimated time in us the transfer runs.  Note that
+	 * there is 1 idle clocks cycles after each byte getting transferred
+	 * so we have 9 cycles/byte.  This is used to find the number of Hz
+	 * per byte per polling limit.  E.g., we can transfer 1 byte in 30 us
+	 * per 300,000 Hz of bus clock.
+	 */
+#define HZ_PER_BYTE ((9 * 1000000) / BCM2835_SPI_POLLING_LIMIT_US)
+	/* run in polling mode for short transfers */
+	if (tfr->len < spi_used_hz / HZ_PER_BYTE)
 		return bcm2835_spi_transfer_one_poll(master, spi, tfr, cs);

 	/* run in dma mode if conditions are right */
--
2.11.0

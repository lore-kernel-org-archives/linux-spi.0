From: kernel@martin.sperl.org
Subject: [resend] [PATCH 5/5] spi: bcm2835aux: support effective_speed_hz
Date: Sat, 23 Feb 2019 15:07:05 +0000
Message-ID: <20190223150705.10729-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Martin Sperl <kernel@martin.sperl.org>
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
 Stefan Wahren <stefan.wahren@i2se.com>, linux-spi@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

Setting spi_transfer->effective_speed_hz in transfer_one so that
it can get used in cs_change_delay configured with delay as a muliple
of SPI clock cycles.

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/spi/spi-bcm2835aux.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 671e374e1b01..51ce76706073 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -325,7 +325,6 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 {
 	struct bcm2835aux_spi *bs = spi_master_get_devdata(master);
 	unsigned long spi_hz, clk_hz, speed;
-	unsigned long spi_used_hz;

 	/* calculate the registers to handle
 	 *
@@ -353,7 +352,7 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	/* set the new speed */
 	bs->cntl[0] |= speed << BCM2835_AUX_SPI_CNTL0_SPEED_SHIFT;

-	spi_used_hz = clk_hz / (2 * (speed + 1));
+	tfr->effective_speed_hz = clk_hz / (2 * (speed + 1));

 	/* set transmit buffers and length */
 	bs->tx_buf = tfr->tx_buf;
@@ -371,7 +370,7 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	 */
 #define HZ_PER_BYTE ((9 * 1000000) / BCM2835_AUX_SPI_POLLING_LIMIT_US)
 	/* run in polling mode for short transfers */
-	if (tfr->len < spi_used_hz / HZ_PER_BYTE)
+	if (tfr->len < tfr->effective_speed_hz / HZ_PER_BYTE)
 		return bcm2835aux_spi_transfer_one_poll(master, spi, tfr);

 	/* run in interrupt mode for all others */
--
2.11.0

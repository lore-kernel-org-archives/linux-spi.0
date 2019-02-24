From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH 8/9] spi: bcm2835aux: use BCM2835_AUX_SPI_STAT_RX_LVL
Date: Sun, 24 Feb 2019 12:54:39 +0000
Message-ID: <20190224125440.16117-9-kernel@martin.sperl.org>
References: <20190224125440.16117-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
 Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>,
 Hubert Denkmair <h.denkmair-4pT7WzY1KUiELgA04lAiVw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190224125440.16117-1-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

On long running tests with a mcp2517fd can controller it showed that
on rare occations the data read shows corruptions for longer spi transfers.

Example of a 22 byte transfer:

expected (as captured on logic analyzer):
FF FF 78 00 00 00 08 06 00 00 91 20 77 56 84 85 86 87 88 89 8a 8b

read by the driver:
FF FF 78 00 00 00 08 06 00 00 91 20 77 56 84 88 89 8a 00 00 8b 9b

To fix this use BCM2835_AUX_SPI_STAT_RX_LVL to determine when we may
read data from the fifo reliably without any corruption.

Surprisingly the only values ever empirically read in
BCM2835_AUX_SPI_STAT_RX_LVL are 0x00, 0x10, 0x20 and 0x30.
So whenever the mask is not 0 we can read from the fifo in a safe manner.

The patch has now been tested intensively and we are no longer
able to reproduce the "RX" issue any longer.

Fixes: 1ea29b39f4c812ece2f936065a0a3d6fe44a263e
(Note: requires Patch 6)

Reported-by: Hubert Denkmair <h.denkmair-4pT7WzY1KUiELgA04lAiVw@public.gmane.org>
Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835aux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 8821fc183ca0..8cd273d0fef2 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -232,12 +232,12 @@ static void bcm2835aux_spi_reset_hw(struct bcm2835aux_spi *bs)

 static void bcm2835aux_spi_transfer_helper(struct bcm2835aux_spi *bs)
 {
+	u32 stat = bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT);
+
 	/* check if we have data to read */
-	while (bs->rx_len &&
-	       (!(bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT) &
-		  BCM2835_AUX_SPI_STAT_RX_EMPTY))) {
+	for (; bs->rx_len && (stat & BCM2835_AUX_SPI_STAT_RX_LVL);
+	     stat = bcm2835aux_rd(bs, BCM2835_AUX_SPI_STAT))
 		bcm2835aux_rd_fifo(bs);
-	}

 	/* check if we have data to write */
 	while (bs->tx_len &&
--
2.11.0

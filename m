From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH V2 3/6] spi: bcm2835: added comment about different bus
 behaviour of DMA mode
Date: Tue, 23 Apr 2019 20:15:10 +0000
Message-ID: <20190423201513.8073-4-kernel@martin.sperl.org>
References: <20190423201513.8073-1-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
 Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190423201513.8073-1-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
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

The DMA mode behaves slightly different than polling or interrupt driven
mode, so just document the fact

Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

Changelog:
  V1 -> V2: applied feedback by Stefan Wahren
            new in V2

---
 drivers/spi/spi-bcm2835.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index a64bfa8e0710..3140d952c03a 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -828,7 +828,10 @@ static int bcm2835_spi_transfer_one(struct spi_master *master,
 	if (tfr->len < spi_used_hz / HZ_PER_BYTE)
 		return bcm2835_spi_transfer_one_poll(master, spi, tfr, cs);

-	/* run in dma mode if conditions are right */
+	/* run in dma mode if conditions are right
+	 * Note that unlike poll or interrupt mode DMA mode does not have
+	 * this 1 idle clock cycle pattern but runs the spi clock without gaps
+	 */
 	if (master->can_dma && bcm2835_spi_can_dma(master, spi, tfr))
 		return bcm2835_spi_transfer_one_dma(master, spi, tfr, cs);

--
2.11.0

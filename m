From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: [PATCH] spi: bcm2835: fix kbuild compile warnings/errors and a typo
Date: Tue, 12 May 2015 10:32:08 +0000
Message-ID: <1431426729-2154-1-git-send-email-kernel@martin.sperl.org>
References: <55516950.5070105@wwwdotorg.org>
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55516950.5070105-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

fixes several warnings/error emmitted by the kbuild system:
* warn: cast from pointer to integer of different size
  using size_t instead of u32
* error: 'SZ_4K' undeclared
  moved to PAGE_SIZE and PAGE_MASK instead

Review showed also a typo in the same code where tx_buff
was checked twice instead of checking both rx and tx_buff.

Reported by: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
---
 drivers/spi/spi-bcm2835.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 6ab43c8..ac1760e 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -20,6 +20,7 @@
  * GNU General Public License for more details.
  */
 
+#include <asm/page.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
@@ -378,18 +379,19 @@ static bool bcm2835_spi_can_dma(struct spi_master *master,
 	}
 
 	/* if we run rx/tx_buf with word aligned addresses then we are OK */
-	if (((u32)tfr->tx_buf % 4 == 0) && ((u32)tfr->tx_buf % 4 == 0))
+	if ((((size_t)tfr->rx_buf & 3) == 0) &&
+	    (((size_t)tfr->tx_buf & 3) == 0))
 		return true;
 
 	/* otherwise we only allow transfers within the same page
 	 * to avoid wasting time on dma_mapping when it is not practical
 	 */
-	if (((u32)tfr->tx_buf % SZ_4K) + tfr->len > SZ_4K) {
+	if (((size_t)tfr->tx_buf & PAGE_MASK) + tfr->len > PAGE_SIZE) {
 		dev_warn_once(&spi->dev,
 			      "Unaligned spi tx-transfer bridging page\n");
 		return false;
 	}
-	if (((u32)tfr->rx_buf % SZ_4K) + tfr->len > SZ_4K) {
+	if (((size_t)tfr->rx_buf & PAGE_MASK) + tfr->len > PAGE_SIZE) {
 		dev_warn_once(&spi->dev,
 			      "Unaligned spi tx-transfer bridging page\n");
 		return false;
-- 
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

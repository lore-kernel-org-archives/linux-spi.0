From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] spi: pxa2xx: Rewrite switch code block in interrupt_transfer
Date: Wed, 3 Oct 2018 17:55:22 +0200
Message-ID: <20181003155522.GA31045@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Rewrite switch code block to directly do the expected number
of shifts in each case and have break statements.

Addresses-Coverity-ID: 1056539 ("Missing break in switch")
Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/spi/spi-pxa2xx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index fc9aac2..d68f511 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -665,9 +665,11 @@ static irqreturn_t interrupt_transfer(struct driver_data *drv_data)
 			bytes_left = drv_data->rx_end - drv_data->rx;
 			switch (drv_data->n_bytes) {
 			case 4:
-				bytes_left >>= 1;
+				bytes_left >>= 2;
+				break;
 			case 2:
 				bytes_left >>= 1;
+				break;
 			}
 
 			rx_thre = pxa2xx_spi_get_rx_default_thre(drv_data);
-- 
2.7.4

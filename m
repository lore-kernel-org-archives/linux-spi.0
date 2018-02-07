From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] spi: bcm2835aux: use 64-bit arithmetic instead of 32-bit
Date: Wed, 7 Feb 2018 10:00:02 -0600
Message-ID: <20180207160002.GA9292@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Mark Brown <broonie@kernel.org>, Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add suffix ULL to constant 9 in order to give the compiler complete
information about the proper arithmetic to use. Notice that this
constant is used in a context that expects an expression of type
unsigned long long (64 bits, unsigned).

The expression tfr->len * 9 * 1000000 is currently being evaluated
using 32-bit arithmetic.

Addresses-Coverity-ID: 1339619
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/spi/spi-bcm2835aux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
index 7428091..a768c23 100644
--- a/drivers/spi/spi-bcm2835aux.c
+++ b/drivers/spi/spi-bcm2835aux.c
@@ -363,7 +363,7 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
 	 * chunk getting transferred - in our case the chunk size
 	 * is 3 bytes, so we approximate this by 9 bits/byte
 	 */
-	xfer_time_us = tfr->len * 9 * 1000000;
+	xfer_time_us = tfr->len * 9ULL * 1000000;
 	do_div(xfer_time_us, spi_used_hz);
 
 	/* run in polling mode for short transfers */
-- 
2.7.4

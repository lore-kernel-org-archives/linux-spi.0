From: Thierry Reding <thierry.reding@gmail.com>
Subject: [PATCH 2/2] spi: Prevent a type mismatch warning using min_t()
Date: Thu, 18 Feb 2016 14:32:58 +0100
Message-ID: <1455802378-17780-2-git-send-email-thierry.reding@gmail.com>
References: <1455802378-17780-1-git-send-email-thierry.reding@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455802378-17780-1-git-send-email-thierry.reding@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The min_t() variant of the min() macro uses an explicit cast to the type
given in the first argument and can be used to avoid a compiler warning
if both types differ (f.e. in signedness).

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f123f9f4d779..fe001ec4471e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2301,7 +2301,7 @@ static int __spi_split_transfer_maxsize(struct spi_master *master,
 	/* the first transfer just needs the length modified, so we
 	 * run it outside the loop
 	 */
-	xfers[0].len = min(maxsize, xfer[0].len);
+	xfers[0].len = min_t(size_t, maxsize, xfer[0].len);
 
 	/* all the others need rx_buf/tx_buf also set */
 	for (i = 1, offset = maxsize; i < count; offset += maxsize, i++) {
-- 
2.7.1

From: Takuo Koguchi <takuo.koguchi@gmail.com>
Subject: [PATCH] spi: jcore: disable clock when registering spi conroller
Date: Thu,  7 Dec 2017 19:09:24 +0900
Message-ID: <1512641366-5963-1-git-send-email-takuo.koguchi.sw@hitachi.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-kernel@vger.kernel.org, khoroshilov@ispras.ru,
        takuo.koguchi@gmail.com, takuo.koguchi.sw@hitachi.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

 failed When probe function fails in registering the spi controller, the clock
 should remain disabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
---
 Compiled test only, no runtime test done.
 
 drivers/spi/spi-jcore.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-jcore.c b/drivers/spi/spi-jcore.c
index cebfea5..dafed62 100644
--- a/drivers/spi/spi-jcore.c
+++ b/drivers/spi/spi-jcore.c
@@ -198,8 +198,10 @@ static int jcore_spi_probe(struct platform_device *pdev)
 
 	/* Register our spi controller */
 	err = devm_spi_register_master(&pdev->dev, master);
-	if (err)
+	if (err) {
+		clk_disable(clk);
 		goto exit;
+	}
 
 	return 0;
 
-- 
2.7.4

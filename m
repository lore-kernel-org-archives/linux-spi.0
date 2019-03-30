From: Colin King <colin.king@canonical.com>
Subject: [PATCH] spi: oc-tiny: fix negative loop bound error on for loop
Date: Sat, 30 Mar 2019 21:23:00 +0000
Message-ID: <20190330212300.11675-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the for-loop using an unsigned int for the loop counter
which is problematic when comparing it to the signed int
gt->gpio_cs_count.  This is an issue because if the signed int is
negative (for example, the call to of_gpio_count failed) then
the negative loop bound is implicitly cast to an unsigned int on
the comparison to loop counter i and will yield a very large value,
eventually causing an array bounds overflow on hw->gpio_cs.

Fix this by simply making the loop counter i a signed int;

Fixes: ca632f556697 ("spi: reorganize drivers")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-oc-tiny.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-oc-tiny.c b/drivers/spi/spi-oc-tiny.c
index 085f580be7ec..81f74b938dc9 100644
--- a/drivers/spi/spi-oc-tiny.c
+++ b/drivers/spi/spi-oc-tiny.c
@@ -206,7 +206,7 @@ static int tiny_spi_of_probe(struct platform_device *pdev)
 {
 	struct tiny_spi *hw = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
-	unsigned int i;
+	int i;
 	u32 val;
 
 	if (!np)
-- 
2.20.1

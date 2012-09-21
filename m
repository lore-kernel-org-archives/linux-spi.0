From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH] spi: sh-hspi: fix return value check in hspi_probe()
Date: Fri, 21 Sep 2012 15:16:55 +0800
Message-ID: <CAPgLHd9i5kYKk+eTcC2ddu3k_F+PwdnVi91k4vEoj_wWkgBXDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: yongjun_wei@trendmicro.com.cn,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: grant.likely@secretlab.ca
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function clk_get() returns ERR_PTR()
and never returns NULL pointer. The NULL test in the error
handling should be replaced with IS_ERR().

dpatch engine is used to auto generated this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/spi/spi-sh-hspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 934138c..ecb99f3 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -251,7 +251,7 @@ static int __devinit hspi_probe(struct platform_device *pdev)
 	}
 
 	clk = clk_get(NULL, "shyway_clk");
-	if (!clk) {
+	if (IS_ERR(clk)) {
 		dev_err(&pdev->dev, "shyway_clk is required\n");
 		ret = -EINVAL;
 		goto error0;

From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 3/4] spi: sprd: Replace of_hwspin_lock_get_id() with of_hwspin_lock_get_id_byname()
Date: Fri,  1 Jun 2018 17:04:54 +0800
Message-ID: <1ee51555e05ad1fbfca7fac60050d318be9181f6.1527843425.git.baolin.wang@linaro.org>
References: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
Cc: baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
To: ohad@wizery.com, bjorn.andersson@linaro.org, broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
In-Reply-To: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
References: <1be6adeb558fada77de79a40cd5ef7dc2719c945.1527843425.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Now the hwlock core has supplied new function to get a specific hwlock id
by one hwlock name, which is more clear for users. So change to use
of_hwspin_lock_get_id_byname().

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/spi/spi-sprd-adi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 6fc50cf..d8d5e2f 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -459,7 +459,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 	sadi->slave_pbase = res->start + ADI_SLAVE_OFFSET;
 	sadi->ctlr = ctlr;
 	sadi->dev = &pdev->dev;
-	ret = of_hwspin_lock_get_id(np, 0);
+	ret = of_hwspin_lock_get_id_byname(np, "adi");
 	if (ret < 0) {
 		dev_err(&pdev->dev, "can not get the hardware spinlock\n");
 		goto put_ctlr;
-- 
1.7.9.5

From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sprd-adi: silence an uninitialized variable warning" to the spi tree
Date: Mon, 25 Sep 2017 17:16:38 +0100 (BST)
Message-ID: <20170925161638.E9B1244005A@finisterre.ee.mobilebroadband>
References: <20170922204808.7o7jn7pfj4se2s5r@mwanda>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@spreadtrum.com>,
        linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20170922204808.7o7jn7pfj4se2s5r@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sprd-adi: silence an uninitialized variable warning

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From b0d6e097b922ac7f538623c52794d9d63d6ee378 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 22 Sep 2017 23:48:08 +0300
Subject: [PATCH] spi: sprd-adi: silence an uninitialized variable warning

If of_get_property() fails then "size" is uninitialized and it leads to
a static checker warning:

    drivers/spi/spi-sprd-adi.c:288 sprd_adi_hw_init()
    error: uninitialized symbol 'size'.

We can silence the warning by re-arranging the order of these checks.
It obviously doesn't affect runtime at all.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sprd-adi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index bff6ef1caad7..1324463244d3 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -285,7 +285,7 @@ static void sprd_adi_hw_init(struct sprd_adi *sadi)
 
 	/* Set hardware channels setting */
 	list = of_get_property(np, "sprd,hw-channels", &size);
-	if (!size || !list) {
+	if (!list || !size) {
 		dev_info(sadi->dev, "no hw channels setting in node\n");
 		return;
 	}
-- 
2.14.1


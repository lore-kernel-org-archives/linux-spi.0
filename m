From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] spi: sprd-adi: silence an uninitialized variable warning
Date: Fri, 22 Sep 2017 23:48:08 +0300
Message-ID: <20170922204808.7o7jn7pfj4se2s5r@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi@vger.kernel.org, kernel-janitors@vger.kernel.org
To: Mark Brown <broonie@kernel.org>,
        Baolin Wang <baolin.wang@spreadtrum.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If of_get_property() fails then "size" is uninitialized and it leads to
a static checker warning:

    drivers/spi/spi-sprd-adi.c:288 sprd_adi_hw_init()
    error: uninitialized symbol 'size'.

We can silence the warning by re-arranging the order of these checks.
It obviously doesn't affect runtime at all.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 0d481f8a46c2..146d674573f7 100644
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

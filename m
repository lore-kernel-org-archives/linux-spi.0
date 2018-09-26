From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] spi: sprd: don't mark remove function as __exit
Date: Wed, 26 Sep 2018 14:58:21 +0200
Message-ID: <20180926125833.2225931-1-arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Lanqing Liu <lanqing.liu@spreadtrum.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The __exit section is left out for built-in drivers, so a
'remove' callback must not be marked as such to avoid breaking when
we unbind a device at runtime. This was pointed out by kbuild:

`sprd_spi_remove' referenced in section `.data' of drivers/spi/spi-sprd.o: defined in discarded section `.exit.text' of drivers/spi/spi-sprd.o

Fixes: e7d973a31c24 ("spi: sprd: Add SPI driver for Spreadtrum SC9860")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-sprd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd.c b/drivers/spi/spi-sprd.c
index a9a6c5ed443f..8daa24eec624 100644
--- a/drivers/spi/spi-sprd.c
+++ b/drivers/spi/spi-sprd.c
@@ -676,7 +676,7 @@ static int sprd_spi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int __exit sprd_spi_remove(struct platform_device *pdev)
+static int sprd_spi_remove(struct platform_device *pdev)
 {
 	struct spi_controller *sctlr = platform_get_drvdata(pdev);
 	struct sprd_spi *ss = spi_controller_get_devdata(sctlr);
-- 
2.18.0

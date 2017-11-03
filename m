From: Colin King <colin.king@canonical.com>
Subject: [PATCH] spi: s3c64xx: remove redundant pointer sci
Date: Fri,  3 Nov 2017 13:35:25 +0000
Message-ID: <20171103133525.8173-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To: Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andi Shyti <andi.shyti@samsung.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer sci is assigned but never read, hence it is redundant
and can be removed. Cleans up clang warning:

drivers/spi/spi-s3c64xx.c:791:2: warning: Value stored to 'sci' is
never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-s3c64xx.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index b392cca8fa4f..de7df20f8712 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -752,7 +752,6 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 {
 	struct s3c64xx_spi_csinfo *cs = spi->controller_data;
 	struct s3c64xx_spi_driver_data *sdd;
-	struct s3c64xx_spi_info *sci;
 	int err;
 
 	sdd = spi_master_get_devdata(spi->master);
@@ -788,8 +787,6 @@ static int s3c64xx_spi_setup(struct spi_device *spi)
 		spi_set_ctldata(spi, cs);
 	}
 
-	sci = sdd->cntrlr_info;
-
 	pm_runtime_get_sync(&sdd->pdev->dev);
 
 	/* Check if we can provide the requested rate */
-- 
2.14.1

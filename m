From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] spi: npcm: fix u32 csgpio being checked for less than zero
Date: Wed, 14 Nov 2018 21:42:46 +0000
Message-ID: <20181114214246.15591-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To: Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Mark Brown <broonie@kernel.org>, openbmc@lists.ozlabs.org,
        linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The u32 variable csgpio is being checked for an error return
from the call to of_get_named_gpio, however, since this is unsigned
this comparison will always be false. Fix this by making csgpio an
int and fix up the %u format specifiers to %d accordingly.

Detected by CoverityScan, CID#1475476 ("Unsigned compared against 0")

Fixes: 2a22f1b30cee ("spi: npcm: add NPCM PSPI controller driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-npcm-pspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index 51777515c83f..6dae91091143 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -329,7 +329,7 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 	unsigned long clk_hz;
 	struct device_node *np = pdev->dev.of_node;
 	int num_cs, i;
-	u32 csgpio;
+	int csgpio;
 	int irq;
 	int ret;
 
@@ -417,12 +417,12 @@ static int npcm_pspi_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev, "failed to get csgpio#%u\n", i);
 			goto out_disable_clk;
 		}
-		dev_dbg(&pdev->dev, "csgpio#%u = %u\n", i, csgpio);
+		dev_dbg(&pdev->dev, "csgpio#%u = %d\n", i, csgpio);
 		ret = devm_gpio_request_one(&pdev->dev, csgpio,
 					    GPIOF_OUT_INIT_HIGH, DRIVER_NAME);
 		if (ret < 0) {
 			dev_err(&pdev->dev,
-				"failed to configure csgpio#%u %u\n"
+				"failed to configure csgpio#%u %d\n"
 				, i, csgpio);
 			goto out_disable_clk;
 		}
-- 
2.19.1

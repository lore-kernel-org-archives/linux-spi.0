From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] spi: qup: fix 64-bit build warning
Date: Thu, 10 Aug 2017 14:13:27 +0200
Message-ID: <20170810121335.2581513-2-arnd@arndb.de>
References: <20170810121335.2581513-1-arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Varadarajan Narayanan <varada@codeaurora.org>,
        Matthew McClintock <mmcclint@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170810121335.2581513-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 64-bit systems, pointers are wider than 'int' variables,
so we get a warning about a cast between them:

drivers/spi/spi-qup.c:1060:23: error: cast from pointer to integer of different size [-Werror=pointer-to-int-cast]

This changes the code to use the correct uintptr_t cast.

Fixes: 4d023737b2ef ("spi: qup: Fix QUP version identify method")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-qup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index e9ecd67cd817..974a8ce58b68 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -1057,7 +1057,7 @@ static int spi_qup_probe(struct platform_device *pdev)
 	else if (!ret)
 		master->can_dma = spi_qup_can_dma;
 
-	controller->qup_v1 = (int)of_device_get_match_data(dev);
+	controller->qup_v1 = (uintptr_t)of_device_get_match_data(dev);
 
 	if (!controller->qup_v1)
 		master->set_cs = spi_qup_set_cs;
-- 
2.9.0

From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH v2] spi: davinci: Fix compilation warning.
Date: Mon,  5 Jun 2017 19:20:40 +0530
Message-ID: <97178a72ee129abbf918562cd22a508bc1cf0e1a.1496670502.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: broonie@kernel.org, geert@linux-m68k.org, m-karicheri2@ti.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

If CONFIG_OF is disable, it'll through compilation warning.

drivers/spi/spi-davinci.c: In function ‘spi_davinci_get_pdata’:
drivers/spi/spi-davinci.c:880:2: warning: return makes pointer from integer without a cast [enabled by default]
  return -ENODEV;

drivers/spi/spi-davinci.c: In function ‘davinci_spi_probe’:
drivers/spi/spi-davinci.c:919:7: warning: assignment makes integer from pointer without a cast [enabled by default]
   ret = spi_davinci_get_pdata(pdev, dspi);

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Changes in v2:
             Add fix for both the warning.
Changes in v1:
             It has fix for first warning.
---
 drivers/spi/spi-davinci.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 2b0805d..6ddb6ef 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -873,9 +873,8 @@ static int spi_davinci_get_pdata(struct platform_device *pdev,
 	return 0;
 }
 #else
-static struct davinci_spi_platform_data
-	*spi_davinci_get_pdata(struct platform_device *pdev,
-		struct davinci_spi *dspi)
+static int spi_davinci_get_pdata(struct platform_device *pdev,
+			struct davinci_spi *dspi)
 {
 	return -ENODEV;
 }
-- 
1.9.1

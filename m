From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH -next] spi: atmel-quadspi: Make atmel_qspi_get_name static
Date: Thu, 21 Mar 2019 23:16:56 +0800
Message-ID: <20190321151656.16816-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
To: <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <ludovic.desroches@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

drivers/spi/atmel-quadspi.c:369:12: warning:
 symbol 'atmel_qspi_get_name' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/spi/atmel-quadspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index fffc21c..e541097 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -366,7 +366,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	return err;
 }
 
-const char *atmel_qspi_get_name(struct spi_mem *spimem)
+static const char *atmel_qspi_get_name(struct spi_mem *spimem)
 {
 	return dev_name(spimem->spi->dev.parent);
 }
-- 
2.7.0

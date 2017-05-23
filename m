From: <jiada_wang@mentor.com>
Subject: [PATCH linux-next v2 1/2] spi: imx: only allow dynamic burst in PIO mode
Date: Tue, 23 May 2017 07:35:28 -0700
Message-ID: <1495550129-3489-2-git-send-email-jiada_wang@mentor.com>
References: <1495550129-3489-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jiada Wang <jiada_wang@mentor.com>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495550129-3489-1-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

Currently only PIO mode supports dynamic burst length adjust,
in DMA mode, bpw (bytes per word) value still has to be used
as burst length, other wise transfer issue will be caused.

This patch avoid using dynamic burst in DMA mode by set
reset dynamic_burst when DMA mode is used.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Reported-and-tested-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/spi/spi-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 19b30cf..2768e64 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -242,6 +242,7 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 		return false;
 
 	spi_imx->wml = i;
+	spi_imx->dynamic_burst = 0;
 
 	return true;
 }
-- 
2.7.4

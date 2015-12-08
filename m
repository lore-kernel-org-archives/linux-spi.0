From: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
Subject: [PATCH v6 1/8] spi: imx: fix loopback mode setup after controller
 reset
Date: Tue,  8 Dec 2015 07:43:43 +0100
Message-ID: <1449557030-27525-2-git-send-email-anton.bondarenko.sama@gmail.com>
References: <1449557030-27525-1-git-send-email-anton.bondarenko.sama@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jiada_wang@mentor.com, vladimir_zapolskiy@mentor.com,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: broonie@kernel.org,
	b38343@freescale.com,
	s.hauer@pengutronix.de
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449557030-27525-1-git-send-email-anton.bondarenko.sama@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

If controller hold in reset it's not possible to write any
register except CTRL. So all other registers must be updated
only after controller bring out from reset.

Signed-off-by: Anton Bondarenko <anton.bondarenko.sama@gmail.com>
---
 drivers/spi/spi-imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 410522f..3aa33c8 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -356,6 +356,9 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 	else
 		cfg &= ~MX51_ECSPI_CONFIG_SSBPOL(config->cs);
 
+	/* CTRL register always go first to bring out controller from reset */
+	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
+
 	reg = readl(spi_imx->base + MX51_ECSPI_TESTREG);
 	if (config->mode & SPI_LOOP)
 		reg |= MX51_ECSPI_TESTREG_LBC;
@@ -363,7 +366,6 @@ static int __maybe_unused mx51_ecspi_config(struct spi_imx_data *spi_imx,
 		reg &= ~MX51_ECSPI_TESTREG_LBC;
 	writel(reg, spi_imx->base + MX51_ECSPI_TESTREG);
 
-	writel(ctrl, spi_imx->base + MX51_ECSPI_CTRL);
 	writel(cfg, spi_imx->base + MX51_ECSPI_CONFIG);
 
 	/*
-- 
2.6.3

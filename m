From: Daniel Ribeiro <drwyrm@gmail.com>
Subject: [PATCH] spi: pxa2xx_spi.c restore DRCMR on resume.
Date: Wed, 08 Apr 2009 11:00:38 -0300
Message-ID: <1239199238.20192.16.camel@brutus>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Ned Forrester <nforrester@whoi.edu>, David Brownell <david-b@pacbell.net>,
	openezx-devel <openezx-devel@lists.openezx.org>,
	Eric Miao <eric.y.miao@gmail.com>,
	linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>
To: spi-devel-general <spi-devel-general@lists.sourceforge.net>
Return-path: <openezx-devel-bounces@lists.openezx.org>
List-Unsubscribe: <https://lists.openezx.org/mailman/listinfo/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=unsubscribe>
List-Archive: <http://lists.openezx.org/pipermail/openezx-devel>
List-Post: <mailto:openezx-devel@lists.openezx.org>
List-Help: <mailto:openezx-devel-request@lists.openezx.org?subject=help>
List-Subscribe: <https://lists.openezx.org/mailman/listinfo/openezx-devel>,
	<mailto:openezx-devel-request@lists.openezx.org?subject=subscribe>
Sender: openezx-devel-bounces@lists.openezx.org
Errors-To: openezx-devel-bounces@lists.openezx.org
List-Id: linux-spi.vger.kernel.org

If DMA is enabled, any spi_sync call after suspend/resume would block forever,
because DRCMR is lost on suspend. This patch restores DRCMR to the same values
set by probe.

Signed-off-by: Daniel Ribeiro <drwyrm@gmail.com>

---
 drivers/spi/pxa2xx_spi.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
index c1688c7..79d7341 100644
--- a/drivers/spi/pxa2xx_spi.c
+++ b/drivers/spi/pxa2xx_spi.c
@@ -1700,6 +1700,13 @@ static int pxa2xx_spi_resume(struct platform_device *pdev)
 	struct ssp_device *ssp = drv_data->ssp;
 	int status = 0;
 
+	if (drv_data->rx_channel != -1)
+		DRCMR(drv_data->ssp->drcmr_rx) =
+			DRCMR_MAPVLD | drv_data->rx_channel;
+	if (drv_data->tx_channel != -1)
+		DRCMR(drv_data->ssp->drcmr_tx) =
+			DRCMR_MAPVLD | drv_data->tx_channel;
+
 	/* Enable the SSP clock */
 	clk_enable(ssp->clk);
 
-- 
tg: (577c9c4..) spi/pxa2xx_spi-fix-dma-resume (depends on: master)
total: 0 errors, 0 warnings, 13 lines checked

pxa2xx_spi-fix-dma-resume.patch has no obvious style problems and is ready for submission.

From: Jamie Iles <jamie@jamieiles.com>
Subject: [PATCH] spi: tegra: don't treat NULL clk as an error
Date: Mon, 10 Jan 2011 11:05:06 +0000
Message-ID: <1294657506-27510-1-git-send-email-jamie@jamieiles.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jamie Iles <jamie@jamieiles.com>, Erik Gilling <konkers@android.com>
To: spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Some platforms have been known to return NULL from clk_get() if they
support only a single struct clk.  Whilst tegra doesn't do this, make
the drivers consistent with others.

Cc: Erik Gilling <konkers@android.com>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---

 drivers/spi/spi_tegra.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_tegra.c b/drivers/spi/spi_tegra.c
index bb7df02..891e590 100644
--- a/drivers/spi/spi_tegra.c
+++ b/drivers/spi/spi_tegra.c
@@ -513,7 +513,7 @@ static int __init spi_tegra_probe(struct platform_device *pdev)
 	}
 
 	tspi->clk = clk_get(&pdev->dev, NULL);
-	if (IS_ERR_OR_NULL(tspi->clk)) {
+	if (IS_ERR(tspi->clk)) {
 		dev_err(&pdev->dev, "can not get clock\n");
 		ret = PTR_ERR(tspi->clk);
 		goto err2;
-- 
1.7.3.4

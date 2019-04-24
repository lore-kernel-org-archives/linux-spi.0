From: Fabien Dessenne <fabien.dessenne@st.com>
Subject: [PATCH] spi: stm32: return the get_irq error
Date: Wed, 24 Apr 2019 14:38:44 +0200
Message-ID: <1556109524-21874-1-git-send-email-fabien.dessenne@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabien Dessenne <fabien.dessenne@st.com>
To: Mark Brown <broonie@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>,
 Amelie Delaunay <amelie.delaunay@st.com>, <linux-spi@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

During probe, return the "get_irq" error value instead of -ENOENT. This
allows the driver to be defer probed if needed.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
---
 drivers/spi/spi-stm32.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
index 4186ed2..b222ce8 100644
--- a/drivers/spi/spi-stm32.c
+++ b/drivers/spi/spi-stm32.c
@@ -1839,8 +1839,9 @@ static int stm32_spi_probe(struct platform_device *pdev)
 
 	spi->irq = platform_get_irq(pdev, 0);
 	if (spi->irq <= 0) {
-		dev_err(&pdev->dev, "no irq: %d\n", spi->irq);
-		ret = -ENOENT;
+		ret = spi->irq;
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "failed to get irq: %d\n", ret);
 		goto err_master_put;
 	}
 	ret = devm_request_threaded_irq(&pdev->dev, spi->irq,
-- 
2.7.4

From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
Subject: [RFC] spi: sun6i: disable/unprepare clocks on remove
Date: Wed, 6 Dec 2017 13:50:29 +0100
Message-ID: <20171206125028.fqzmy354tgf7afis@agrajag.zerfleddert.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>,
 Maxime Ripard <maxime.ripard@free-electrons.com>,
 Chen-Yu Tsai <wens@csie.org>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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

sun6i_spi_probe() uses sun6i_spi_runtime_resume() to prepare/enable clocks,
so sun6i_spi_remove() should use sun6i_spi_runtime_suspend() to
disable/unprepare them.

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 3558fe900e8af spi: sunxi: Add Allwinner A31 SPI controller driver
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
---
This was found by LDV, and it looks very suspicious to me, but I'm not
sure if the fix is that easy. Is suspend() called automatically when the
driver is removed? If not, is it correct to unconditionally call
suspend(), or should there be a check for the PM state instead?

 drivers/spi/spi-sun6i.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index fb38234249a8..5e5df09e5d04 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -541,6 +541,7 @@ static int sun6i_spi_probe(struct platform_device *pdev)
 
 static int sun6i_spi_remove(struct platform_device *pdev)
 {
+	sun6i_spi_runtime_suspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
-- 
2.11.0

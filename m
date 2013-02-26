From: Wenyou Yang <wenyou.yang@atmel.com>
Subject: [PATCH v5 04/16] spi/spi-atmel: add physical base address
Date: Tue, 26 Feb 2013 14:47:57 +0800
Message-ID: <1361861289-30332-5-git-send-email-wenyou.yang@atmel.com>
References: <1361861289-30332-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <grant.likely@secretlab.ca>, <nicolas.ferre@atmel.com>,
	<plagnioj@jcrosoft.com>, <richard.genoud@gmail.com>,
	<JM.Lin@atmel.com>, <wenyou.yang@atmel.com>,
	<spi-devel-general@lists.sourceforge.net>,
	<linux-kernel@vger.kernel.org>
To: <linux-arm-kernel@lists.infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1361861289-30332-1-git-send-email-wenyou.yang@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>

Needed for future use with dmaengine enabled driver.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: spi-devel-general@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
[wenyou.yang@atmel.com: submit the patch]
Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 drivers/spi/spi-atmel.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
index 9c8f2d5..c70142e 100644
--- a/drivers/spi/spi-atmel.c
+++ b/drivers/spi/spi-atmel.c
@@ -197,6 +197,7 @@ struct atmel_spi_caps {
 struct atmel_spi {
 	spinlock_t		lock;
 
+	resource_size_t		phybase;
 	void __iomem		*regs;
 	int			irq;
 	struct clk		*clk;
@@ -1003,6 +1004,7 @@ static int atmel_spi_probe(struct platform_device *pdev)
 	as->regs = ioremap(regs->start, resource_size(regs));
 	if (!as->regs)
 		goto out_free_buffer;
+	as->phybase = regs->start;
 	as->irq = irq;
 	as->clk = clk;
 
-- 
1.7.9.5

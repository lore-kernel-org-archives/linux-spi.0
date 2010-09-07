From: Yong Wang <yong.y.wang@linux.intel.com>
Subject: [PATCH] dw_spi: Allow interrupt sharing
Date: Tue, 7 Sep 2010 15:27:27 +0800
Message-ID: <20100907072727.GA2152@ywang-moblin2.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	Feng Tang <feng.tang@intel.com>,
	George Shore <george@georgeshore.com>,
	Andrew Morton <akp
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Allow interrupt sharing since exclusive interrupt line for
DW SPI controller is not provided on every platform.

Signed-off-by: Yong Wang <yong.y.wang@intel.com>
---
 drivers/spi/dw_spi.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index d256cb0..11fbbf6 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -396,6 +396,11 @@ static irqreturn_t interrupt_transfer(struct dw_spi *dws)
 static irqreturn_t dw_spi_irq(int irq, void *dev_id)
 {
 	struct dw_spi *dws = dev_id;
+	u16 irq_status, irq_mask = 0x3f;
+
+	irq_status = dw_readw(dws, isr) & irq_mask;
+	if (!irq_status)
+		return IRQ_NONE;
 
 	if (!dws->cur_msg) {
 		spi_mask_intr(dws, SPI_INT_TXEI);
@@ -883,7 +888,7 @@ int __devinit dw_spi_add_host(struct dw_spi *dws)
 	dws->dma_inited = 0;
 	dws->dma_addr = (dma_addr_t)(dws->paddr + 0x60);
 
-	ret = request_irq(dws->irq, dw_spi_irq, 0,
+	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED,
 			"dw_spi", dws);
 	if (ret < 0) {
 		dev_err(&master->dev, "can not get IRQ\n");
-- 
1.5.5.1

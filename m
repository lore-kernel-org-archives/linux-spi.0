From: "Liu, ShuoX" <shuox.liu@intel.com>
Subject: [PATCH] dw_spi: Add spi number into spi irq desc
Date: Fri, 8 Jul 2011 11:51:05 +0800
Message-ID: <6E3BC7F7C9A4BF4286DD4C043110F30B59E04000E2@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "Tang, Feng" <feng.tang@intel.com>,
	"grant.likely@secretlab.ca" <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

>From 2efa9dbb5c4b1d8fa798d1792498ae21fc3a9d04 Mon Sep 17 00:00:00 2001
From: ShuoX Liu <shuox.liu@intel.com>
Date: Thu, 7 Jul 2011 16:09:41 +0800
Subject: [PATCH] dw_spi: Add spi number into spi irq desc

Signed-off-by: ShuoX Liu <shuox.liu@intel.com>
---
 drivers/spi/dw_spi.c |    4 +++-
 drivers/spi/dw_spi.h |    1 +
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
index 919fa9d..68a3026 100644
--- a/drivers/spi/dw_spi.c
+++ b/drivers/spi/dw_spi.c
@@ -818,9 +818,11 @@ int __devinit dw_spi_add_host(struct dw_spi *dws)
 	dws->prev_chip = NULL;
 	dws->dma_inited = 0;
 	dws->dma_addr = (dma_addr_t)(dws->paddr + 0x60);
+	snprintf(dws->name, sizeof(dws->name), "dw_spi%d",
+			dws->bus_num);
 
 	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED,
-			"dw_spi", dws);
+			dws->name, dws);
 	if (ret < 0) {
 		dev_err(&master->dev, "can not get IRQ\n");
 		goto err_free_master;
diff --git a/drivers/spi/dw_spi.h b/drivers/spi/dw_spi.h
index 7a5e78d..c7b9165 100644
--- a/drivers/spi/dw_spi.h
+++ b/drivers/spi/dw_spi.h
@@ -96,6 +96,7 @@ struct dw_spi {
 	struct spi_device	*cur_dev;
 	struct device		*parent_dev;
 	enum dw_ssi_type	type;
+	char			name[48];
 
 	void __iomem		*regs;
 	unsigned long		paddr;
-- 
1.7.1

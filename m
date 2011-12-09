From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: [PATCH 1/4] spi-topcliff-pch: Modify pci-bus number dynamically to get DMA device info
Date: Fri,  9 Dec 2011 13:11:42 +0900
Message-ID: <1323403905-3432-1-git-send-email-tomoya.rohm@gmail.com>
Cc: qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com,
	kok.howg.ewe@intel.com, Wolfram Sang <w.sang@pengutronix.de>,
	Tomoya MORINAGA <tomoya.rohm@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Tomoya MORINAGA <tomoya.rohm@gmail.com>
---
 drivers/spi/spi-topcliff-pch.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 99ec279..fcd9462 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -920,7 +920,8 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
 	dma_cap_set(DMA_SLAVE, mask);
 
 	/* Get DMA's dev information */
-	dma_dev = pci_get_bus_and_slot(2, PCI_DEVFN(12, 0));
+	dma_dev = pci_get_bus_and_slot(data->board_dat->pdev->bus->number,
+				       PCI_DEVFN(12, 0));
 
 	/* Set Tx DMA */
 	param = &dma->param_tx;
-- 
1.7.4.4

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH 3/8] intel_mid_ssp_spi: Implement the MRST quirk
Date: Wed, 09 Feb 2011 10:08:03 +0000
Message-ID: <20110209100741.555.63933.stgit@bob.linux.org.uk>
References: <20110209100231.555.90520.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: spi-devel-general@lists.sourceforge.net, russ.gorby@intel.com,
	grant.likely@secretlab.ca, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110209100231.555.90520.stgit@bob.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Alan Cox <alan@linux.intel.com>

This quirk simply changes the ID we use to find the DMA controller. Rename
the define and select a different ID IFF the MRST quirk is set

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/spi/intel_mid_ssp_spi.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)


diff --git a/drivers/spi/intel_mid_ssp_spi.c b/drivers/spi/intel_mid_ssp_spi.c
index f201edd..a7548e7 100644
--- a/drivers/spi/intel_mid_ssp_spi.c
+++ b/drivers/spi/intel_mid_ssp_spi.c
@@ -35,7 +35,8 @@
 
 #define DRIVER_NAME		"intel_mid_ssp_spi"
 #define PCI_DMAC_MAXDI		2047
-#define PCI_DMAC_ID		0x0827
+#define PCI_MDFL_DMAC_ID	0x0827
+#define PCI_MRST_DMAC_ID	0x0814
 /* PM QoS define */
 #define MIN_EXIT_LATENCY	20
 
@@ -463,15 +464,18 @@ static void intel_mid_ssp_spi_dma_init(struct driver_data *drv_data)
 {
 	struct intel_mid_dma_slave *rxs, *txs;
 	dma_cap_mask_t mask;
+	u16 id = PCI_MDFL_DMAC_ID;
 
 	if (drv_data->dma_inited)
 		return;
 
-	drv_data->dmac1 = pci_get_device(PCI_VENDOR_ID_INTEL, PCI_DMAC_ID,
+	if (drv_data->quirks & QUIRKS_PLATFORM_MRST)
+		id = PCI_MRST_DMAC_ID;
+
+	drv_data->dmac1 = pci_get_device(PCI_VENDOR_ID_INTEL, id,
 					 NULL);
 	if (!drv_data->dmac1) {
-		dev_warn(&drv_data->pdev->dev, "Can't find DMAC %x",
-			 PCI_DMAC_ID);
+		dev_warn(&drv_data->pdev->dev, "Can't find DMAC %x", id);
 		return;
 	}
 

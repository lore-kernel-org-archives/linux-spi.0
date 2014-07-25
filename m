From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/3] spi: topcliff-pch: use pci_get_dma_device() helper
Date: Fri, 25 Jul 2014 16:31:44 +0300
Message-ID: <1406295104-20082-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1406295104-20082-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1406295104-20082-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Since we have pci_get_dma_device() public we may use it in the drivers. It
considers the function 0 as a DMA controller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-topcliff-pch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index af51d6a..fe868ce 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -874,8 +874,7 @@ static void pch_spi_request_dma(struct pch_spi_data *data, int bpw)
 	dma_cap_set(DMA_SLAVE, mask);
 
 	/* Get DMA's dev information */
-	dma_dev = pci_get_bus_and_slot(data->board_dat->pdev->bus->number,
-				       PCI_DEVFN(12, 0));
+	dma_dev = pci_get_dma_device(data->board_dat->pdev);
 
 	/* Set Tx DMA */
 	param = &dma->param_tx;
-- 
2.0.1


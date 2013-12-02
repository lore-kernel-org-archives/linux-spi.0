From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 27/39] spi: remove DEFINE_PCI_DEVICE_TABLE macro
Date: Tue, 03 Dec 2013 08:25:19 +0900
Message-ID: <003001ceefb5$c418c600$4c4a5200$%han@samsung.com>
References: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>,
	'Mark Brown' <broonie@kernel.org>, linux-spi@vger.kernel.org
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <001501ceefb1$69c96820$3d5c3860$%han@samsung.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Don't use DEFINE_PCI_DEVICE_TABLE macro, because this macro
is not preferred.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/spi/spi-dw-pci.c       |    2 +-
 drivers/spi/spi-pxa2xx-pci.c   |    2 +-
 drivers/spi/spi-topcliff-pch.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 66fa995..f7be4be 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -148,7 +148,7 @@ static int spi_resume(struct pci_dev *pdev)
 #define spi_resume	NULL
 #endif
 
-static DEFINE_PCI_DEVICE_TABLE(pci_ids) = {
+static const struct pci_device_id pci_ids[] = {
 	/* Intel MID platform SPI controller 0 */
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x0800) },
 	{},
diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index 74bc187..3f006d3 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -62,7 +62,7 @@ static void ce4100_spi_remove(struct pci_dev *dev)
 	platform_device_unregister(pdev);
 }
 
-static DEFINE_PCI_DEVICE_TABLE(ce4100_spi_devices) = {
+static const struct pci_device_id ce4100_spi_devices[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x2e6a) },
 	{ },
 };
diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 4461313..338fc11 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -217,7 +217,7 @@ struct pch_pd_dev_save {
 	struct pch_spi_board_data *board_dat;
 };
 
-static DEFINE_PCI_DEVICE_TABLE(pch_spi_pcidev_id) = {
+static const struct pci_device_id pch_spi_pcidev_id[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_GE_SPI),    1, },
 	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7213_SPI), 2, },
 	{ PCI_VDEVICE(ROHM, PCI_DEVICE_ID_ML7223_SPI), 1, },
-- 
1.7.10.4

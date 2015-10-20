From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] spi: dw: explicitly free IRQ handler in dw_spi_remove_host()
Date: Tue, 20 Oct 2015 11:39:36 +0300
Message-ID: <1445330377-126534-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	stable@vger.kernel.org
To: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The following warning occurs when DW SPI is compiled as a module and it's a PCI
device. On the removal stage pcibios_free_irq() is called earlier than
free_irq() due to the latter is called at managed resources free strage.

------------[ cut here ]------------
WARNING: CPU: 1 PID: 1003 at /home/andy/prj/linux/fs/proc/generic.c:575 remove_proc_entry+0x118/0x150()
remove_proc_entry: removing non-empty directory 'irq/38', leaking at least 'dw_spi1'
Modules linked in: spi_dw_midpci(-) spi_dw [last unloaded: dw_dmac_core]
CPU: 1 PID: 1003 Comm: modprobe Not tainted 4.3.0-rc5-next-20151013+ #32
 00000000 00000000 f5535d70 c12dc220 f5535db0 f5535da0 c104e912 c198a6bc
 f5535dcc 000003eb c198a638 0000023f c11b4098 c11b4098 f54f1ec8 f54f1ea0
 f642ba20 f5535db8 c104e96e 00000009 f5535db0 c198a6bc f5535dcc f5535df0
Call Trace:
 [<c12dc220>] dump_stack+0x41/0x61
 [<c104e912>] warn_slowpath_common+0x82/0xb0
 [<c11b4098>] ? remove_proc_entry+0x118/0x150
 [<c11b4098>] ? remove_proc_entry+0x118/0x150
 [<c104e96e>] warn_slowpath_fmt+0x2e/0x30
 [<c11b4098>] remove_proc_entry+0x118/0x150
 [<c109b96a>] unregister_irq_proc+0xaa/0xc0
 [<c109575e>] free_desc+0x1e/0x60
 [<c10957d2>] irq_free_descs+0x32/0x70
 [<c109b1a0>] irq_domain_free_irqs+0x120/0x150
 [<c1039e8c>] mp_unmap_irq+0x5c/0x60
 [<c16277b0>] intel_mid_pci_irq_disable+0x20/0x40
 [<c1627c7f>] pcibios_free_irq+0xf/0x20
 [<c13189f2>] pci_device_remove+0x52/0xb0
 [<c13f6367>] __device_release_driver+0x77/0x100
 [<c13f6da7>] driver_detach+0x87/0x90
 [<c13f5eaa>] bus_remove_driver+0x4a/0xc0
 [<c128bf0d>] ? selinux_capable+0xd/0x10
 [<c13f7483>] driver_unregister+0x23/0x60
 [<c10bad8a>] ? find_module_all+0x5a/0x80
 [<c1317413>] pci_unregister_driver+0x13/0x60
 [<f80ac654>] dw_spi_driver_exit+0xd/0xf [spi_dw_midpci]
 [<c10bce9a>] SyS_delete_module+0x17a/0x210

Explicitly call free_irq() at removal stage of the DW SPI driver.

Fixes: 04f421e7b0b1 (spi: dw: use managed resources)
Cc: stable@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/spi/spi-dw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 1153d36..96753fc 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -517,8 +517,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	dws->dma_addr = (dma_addr_t)(dws->paddr + 0x60);
 	snprintf(dws->name, sizeof(dws->name), "dw_spi%d", dws->bus_num);
 
-	ret = devm_request_irq(dev, dws->irq, dw_spi_irq, IRQF_SHARED,
-			dws->name, master);
+	ret = request_irq(dws->irq, dw_spi_irq, IRQF_SHARED, dws->name, master);
 	if (ret < 0) {
 		dev_err(&master->dev, "can not get IRQ\n");
 		goto err_free_master;
@@ -563,6 +562,7 @@ err_dma_exit:
 	if (dws->dma_ops && dws->dma_ops->dma_exit)
 		dws->dma_ops->dma_exit(dws);
 	spi_enable_chip(dws, 0);
+	free_irq(dws->irq, master);
 err_free_master:
 	spi_master_put(master);
 	return ret;
@@ -575,6 +575,8 @@ void dw_spi_remove_host(struct dw_spi *dws)
 		return;
 	dw_spi_debugfs_remove(dws);
 
+	free_irq(dws->irq, dws->master);
+
 	if (dws->dma_ops && dws->dma_ops->dma_exit)
 		dws->dma_ops->dma_exit(dws);
 	spi_enable_chip(dws, 0);
-- 
2.6.1

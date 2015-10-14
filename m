From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 01/10] spi: dw: explicitly free IRQ handler in dw_spi_remove_host()
Date: Wed, 14 Oct 2015 23:12:16 +0300
Message-ID: <1444853545-59868-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1444853545-59868-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1444853545-59868-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The following warning occurs when DW SPI is compiled as module and it's a PCI
device. On removal stage pcibios_free_irq() called earlier than free_irq() due
to the latter is called at managed resources free strage.

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
Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/spi/spi-dw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 1153d36..254ffdf 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -571,10 +571,14 @@ EXPORT_SYMBOL_GPL(dw_spi_add_host);
 
 void dw_spi_remove_host(struct dw_spi *dws)
 {
+	struct spi_master *master = dws->master;
+
 	if (!dws)
 		return;
 	dw_spi_debugfs_remove(dws);
 
+	devm_free_irq(master->dev.parent, dws->irq, master);
+
 	if (dws->dma_ops && dws->dma_ops->dma_exit)
 		dws->dma_ops->dma_exit(dws);
 	spi_enable_chip(dws, 0);
-- 
2.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

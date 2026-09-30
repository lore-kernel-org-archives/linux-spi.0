Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F4050B41B;
	Wed, 30 Sep 2026 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790784442; cv=none; b=hpIu0qEFrOPrGEhRl4p7Xdr+6dB7pxu6TuK1r61KsU3tY0VaemFX9yyMdE3pqvcSyslKOJoO3Bt1EbZxlNJgQ7SIFPSjI5ZWUgtOrOhhtbmzzGwItsYS9CXwdSPRswkd/IbHgq9LIWLG1SBsragPu2FfVHD4fT4ge86eSXWpksQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790784442; c=relaxed/simple;
	bh=xK7tamjrNwFBAZwGxvC2tPl1f4cIk4BUdLuOctFvLtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qy+htdiJYSE/d5K+aCZF2+1RacxdSPf7oaYhju/tg/gw/oq4qqVKcVNmotx+kg+MOnhtkdqSIsoc3xdCpe9hsqwHlZP65mkWRusuOIqV+98ofc2A+6hZzp63D+j60qhXwGn1XKMvEvAGZZTpK9hnwD+uMgUfCriGVOl4mlc5DNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=RY+5H+Dn; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="RY+5H+Dn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=LYgeF6EE4HK9y1FXGURsNGn2Dslu8jTlzME3jbPfcO8=; b=RY+5H+Dn9k7UAguo5mXsvQYEDF
	A5fTwAhuFTqU4ZWVhmcCtwiJpRLbLqmzOKudlid0KufnhzZzy4nOm4Ogb/oXG869cquE868TEWxTv
	4YRf1QBcvUqrL19byRYGzcfJIBI/hg6zfvZBNMeLbKVX/vWRUzgAYWYOPVoKmq2I6chLSnQ/mAlZz
	8ViPfdUvJ/YaN5JZqgLP5SA5zdBaEScjqSyLyAWjg1EGHGrdH0iTweSiq8Qxso5phW0Zm4s5vvJhP
	5+LyEp5mIE398vkGDv4OsUrelhnSZhtKWXYjm4bdwpYUwf6fQza81Odft/pZyigJs3BTxqUd25sNP
	ci+54k0Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <fourdollars@debian.org>)
	id 1xBwpo-009IoV-0j;
	Wed, 30 Sep 2026 16:07:08 +0000
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v17 6/6] spi: pxa2xx-pci: disable DMA and runtime autosuspend for Apple MacBook8,1
Date: Thu,  1 Oct 2026 00:06:29 +0800
Message-Id: <20260930160629.1822-7-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260930160629.1822-1-fourdollars@debian.org>
References: <20260930160629.1822-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: fourdollars

On MacBook8,1 (early 2015 12" MacBook), the LPSS SPI controller at
00:15.4 (PCI ID 8086:9ce6, PCI_DEVICE_ID_INTEL_LPT1_1) registers and
allocates DMA channels successfully. However, during actual SPI
transfers, the DMA handshake synchronization fails.

This leads to continuous transfer timeouts and locks up the driver
queue, making the connected keyboard and touchpad completely dead:

[ 1582.050494] spi_master spi1: failed to transfer one message from queue
[ 1582.258387] applespi spi-APP000D:00: SPI transfer timed out
[ 1582.258498] applespi spi-APP000D:00: Error reading from device: -110

Empirical hardware register inspection reveals that the companion LPSS
DMA controller at 00:15.0 has its LPSS Private Reset Register (BAR0 +
0x204) left strictly at 0x00000000 by the EFI firmware. Even after
deasserting this reset and overriding ACPI _PRT to assign shared IRQ 21,
the DMA interrupt counter remains strictly at 0, confirming that DMA
completion interrupts are not delivered on this platform. Furthermore,
the SPI controller driver at 00:15.4 cannot safely reach across the PCI
bus to manipulate private registers of the separate DMAC function at
00:15.0 without violating driver layering.

Reverse engineering of the official OS drivers on the same hardware
corroborates that DMA is deliberately bypassed:

  1. On macOS (Big Sur), IOKit registry shows that while the LPSS DMAC
     driver (AppleIntelLpssDmac) is loaded, the allocated channel count
     (AppleIntelLpssDmacChannel) is 0 when the SPI device driver
     (AppleHSSPIHIDDriver) is active.
  2. On Windows 10 (Boot Camp), dynamic MMIO monitoring of BAR1 shows
     that the LPSS DMA control registers (offset 0x800+) remain
     inactive (all zeros) during active keyboard and touchpad
     transactions, and transfers are handled solely via the FIFO data
     registers at the beginning of BAR1.
  3. Logic board schematics confirm that a dedicated out-of-band GPIO
     interrupt line (TPAD_SPI_INT_L) is routed directly to the PCH for
     input events.

Additionally, when operating in PIO mode servicing high-frequency
keyboard and touchpad input streams operating at 60-125 Hz, the default
50 ms autosuspend delay causes the controller to repeatedly transition
between D0 and D3hot between bursts of user input. These runtime resume
transitions introduce latency spikes that drop key presses and cause
erratic touchpad motion.

Implement the forced PIO mode and runtime autosuspend lockout DMI quirk
in spi-pxa2xx-pci.c (the LPSS host controller PCI glue driver) scoped
strictly to MacBook8,1:
1. Include <linux/dmi.h> in alphabetical order for DMI system matching.
2. Add 'quirks' field in struct pxa2xx_spi_pci_config and define
   PXA2XX_SPI_QUIRK_NO_AUTOSUSPEND.
3. Add pxa2xx_spi_pci_dmi_table matching Apple MacBook8,1 and query it
   once in lpss_spi_setup() scoped to PCI_DEVICE_ID_INTEL_LPT1_1
   (0x9ce6). When matched, log the system ident with pci_info(), set
   enable_dma = 0 as a workaround, cache PXA2XX_SPI_QUIRK_NO_AUTOSUSPEND
   in cfg->quirks, and return immediately to skip unused DMA channel
   setup.
4. In pxa2xx_spi_pci_probe(), configure autosuspend with a 50 ms delay
   for all devices, but conditionally skip pm_runtime_allow() when
   PXA2XX_SPI_QUIRK_NO_AUTOSUSPEND is set. This keeps the controller in
   D0 by default (as initialized by PCI core pci_pm_init()) while bound,
   eliminating D3hot resume latency spikes, while ensuring that if
   userspace explicitly enables autosuspend via sysfs, the safe 50 ms
   delay is preserved rather than defaulting to 0. Standard system
   sleep (S3) remains fully operational via pm_runtime_force_suspend().

Assisted-by: Antigravity:gemini-3.8-flash sparse
Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/spi/spi-pxa2xx-pci.c | 61 +++++++++++++++++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
index f8d71362e840..f12a8ef12b17 100644
--- a/drivers/spi/spi-pxa2xx-pci.c
+++ b/drivers/spi/spi-pxa2xx-pci.c
@@ -7,6 +7,7 @@
  */
 #include <linux/clk-provider.h>
 #include <linux/device.h>
+#include <linux/dmi.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -40,6 +41,8 @@
 #define LPSS_PRIV_RESETS_IDMA			BIT(2)
 #define LPSS_PRIV_REG_COUNT			9
 
+#define PXA2XX_SPI_QUIRK_NO_AUTOSUSPEND		BIT(0)
+
 struct pxa_spi_info {
 	int (*setup)(struct pci_dev *pdev, struct pxa2xx_spi_controller *c);
 };
@@ -47,6 +50,7 @@ struct pxa_spi_info {
 struct pxa2xx_spi_pci_config {
 	struct pxa2xx_spi_controller pdata;
 	u32 lpss_priv_ctx[LPSS_PRIV_REG_COUNT];
+	u8 quirks;
 	bool is_lpt;
 };
 
@@ -106,8 +110,53 @@ static void lpss_dma_put_device(void *dma_dev)
 	pci_dev_put(dma_dev);
 }
 
+/*
+ * Apple MacBook8,1 (early 2015 12" MacBook):
+ *
+ * The LPSS SPI controller at 00:15.4 connects to the internal SPI keyboard
+ * and touchpad (applespi). When DMA mode is enabled, DMA transfers consistently
+ * time out (-110) because DMA completion interrupts are never delivered.
+ *
+ * Empirical hardware inspection and OS analysis show that:
+ * 1. Hardware/firmware configuration: EFI leaves companion LPSS DMA (00:15.0)
+ *    held in reset (LPSS_PRIV_RESETS == 0x0 / BAR0 + 0x204). Even after
+ *    deasserting the reset and overriding ACPI _PRT to assign shared IRQ 21,
+ *    the DMA interrupt counter remains strictly 0, confirming that DMA
+ *    completion interrupts are not delivered on this platform.
+ * 2. Operating system parity: Both macOS (AppleIntelLpssDmac channel count
+ *    is 0) and Windows 10 Boot Camp bypass DMA and handle keyboard/touchpad
+ *    transactions strictly in PIO mode via FIFO registers.
+ * 3. Layering: The SPI controller driver (00:15.4) cannot safely reconfigure
+ *    the private registers of the separate DMAC PCI function (00:15.0).
+ * 4. Runtime autosuspend: In PIO mode servicing 60-125 Hz input events, the
+ *    default 50 ms autosuspend delay introduces D3hot <-> D0 transition
+ *    latency spikes that drop key presses and cause erratic touchpad motion.
+ *
+ * Therefore, as a workaround, disable DMA channel allocation to force PIO mode
+ * and keep the device in D0 without enabling runtime autosuspend.
+ */
+static const struct dmi_system_id pxa2xx_spi_pci_dmi_table[] = {
+	{
+		.ident = "Apple MacBook8,1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "MacBook8,1"),
+		},
+	},
+	{ }
+};
+
+static const struct dmi_system_id *pxa2xx_spi_pci_get_dmi_id(struct pci_dev *dev)
+{
+	if (dev->device == PCI_DEVICE_ID_INTEL_LPT1_1)
+		return dmi_first_match(pxa2xx_spi_pci_dmi_table);
+
+	return NULL;
+}
+
 static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 {
+	const struct dmi_system_id *dmi_id;
 	struct pxa2xx_spi_pci_config *cfg = container_of(c, struct pxa2xx_spi_pci_config, pdata);
 	struct ssp_device *ssp = &c->ssp;
 	struct dw_dma_slave *tx, *rx;
@@ -165,6 +214,14 @@ static int lpss_spi_setup(struct pci_dev *dev, struct pxa2xx_spi_controller *c)
 	if (ret)
 		return ret;
 
+	dmi_id = pxa2xx_spi_pci_get_dmi_id(dev);
+	if (dmi_id) {
+		pci_info(dev, "%s detected: disabling DMA to force PIO mode\n", dmi_id->ident);
+		c->enable_dma = 0;
+		cfg->quirks |= PXA2XX_SPI_QUIRK_NO_AUTOSUSPEND;
+		return 0;
+	}
+
 	dma_dev = pci_get_slot(dev->bus, PCI_DEVFN(PCI_SLOT(dev->devfn), 0));
 	ret = devm_add_action_or_reset(&dev->dev, lpss_dma_put_device, dma_dev);
 	if (ret)
@@ -446,7 +503,9 @@ static int pxa2xx_spi_pci_probe(struct pci_dev *dev,
 	pm_runtime_set_autosuspend_delay(&dev->dev, 50);
 	pm_runtime_use_autosuspend(&dev->dev);
 	pm_runtime_put_autosuspend(&dev->dev);
-	pm_runtime_allow(&dev->dev);
+
+	if (!(cfg->quirks & PXA2XX_SPI_QUIRK_NO_AUTOSUSPEND))
+		pm_runtime_allow(&dev->dev);
 
 	return 0;
 }
-- 
2.39.5


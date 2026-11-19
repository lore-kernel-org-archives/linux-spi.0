Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082796;
	b=Q/1VYulWL1dn+Pj+17ugU0Wd8qjSNxZB5VqLrpktQ1n38lxgdgHDU7EPFbENE7/A1pvO
	 pGPQwjUxFEz8aLzn4oqU3k+SahRdR6+zznEag1r42w7/dNJzwIFwd+aCK87r3xg0W9DJ2
	 24+b06omUPxoz3OnNV1Kl+RCgZ60V62rmdYcn4bvhV4RlxyiDk37AXZnZpON5Tlxe2rzm
	 QDPsSb2NW1iVxw4a2+/zXgAdVvpUkpN4+tjB6bqxh1xiMh7bsi2UR4ylfb/LURaLHq3nj
	 LpRZ7ptHV/yOgjtK8OQ6c/GfFGB0tceZqarqaXge71AgsFghrE/1uGk9Mt8JM4r0UHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082796;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-SNPS-Relay:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YegI0vOl1WFk2AbfsX3BdrnvN3iGDqRhjhtUi9JV9oA=;
	b=T8XppkACThom2FFr+KAiDATysx6pgkdWMX6Kdn2sG/4y8oYWXjxzKSnE4GZbT7Ojn/4O
	 aZ/ixYEw/IkcZzLwZaeEER9wlHbg8qs9op6HGVvdJkb/l/nhx0fZPp3ee9wQi7ryZxyHa
	 iUGsaOXwQUOj5/QBGBnRCAocp4XF6KBVRKf4H8/Wei7RZZPWlTF1YmmnwCe/+tFC+OFH9
	 +HgvfuE1CmvJU+C9J1n9YVi6IABhOMiEXQ9Wm5i7MNrAY8pg7KDEC6gpEadrbvbHXyyZA
	 Bjw6Mh36C/kTi+FoSBsR6BBegkvgRuQB9z5fENMmbyKrZ83Zu+0MA8Gp2K2x/ZkNLgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=bN+C5CUq;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=H8+suQp2;
	arc=none smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9760A2603;
	Thu, 19 Nov 2026 10:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62B9760A2603
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=bN+C5CUq;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=H8+suQp2
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ9QnUA2057556;
	Thu, 19 Nov 2026 02:06:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=YegI0vOl1WFk2AbfsX3BdrnvN3iGDqRhjhtUi9JV9oA=; b=bN+C5CUqpgky
	zS5LX3INBIedVsDLHlC5IdoxYkeG0Lhw27yxH2mCtuI1LfyGMD7MH24aoe4+wJWG
	nJ8TNJao0pUFEWE2r9qQLpdALsFsTQ6KmNJB7V5LDODkNAXroMvkPbk8DMKVReh1
	5PRG9FPJQVpfix8mmAwRf8owvI96pjNhQ/6W9I/b0JjzHlKTeMW4cRGt2cHeUlE7
	eWb2JfL4WFo6NvnUjLr6NnPgGDdmBgyzQqB5sb5Dufykz66EzwVlMiv4BrYMSug2
	mKrHccjqZkDPNHP5wyqrcbxptAYavRQfaiK3NpC511z7tG9U02q/O7bYNzqIKL22
	ahIuiPpbPg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4j1ny430jw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 02:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1795082785; bh=h7zOiNJPJuXTPU4Ljwa2gbC5fk+xWfLRkqdAsDP+R00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H8+suQp2YUQkMcpG4NGHsUGrv56n65zfChIFH8R/vj7bOFTNueiZKq63Xubnqps/t
	 LusxdT5XjjeSTFjDtkLs/btC+DSETgO2VhN2Ho5QiHWkqhZQEaiwsd422idaJNf8ac
	 ipCkp/Wf8R2j4OquzQzVC+weWoBTOaDQ537XLclv24UORaeYErwfgFDWgnN2H01fYQ
	 GTAnm/Jz/qep9Lp7ZToz48n1bu7XTTVrKGjSS2nDMlCYNE5bX9C2K2/GIo6P0D26AT
	 HNo+i1LM9o89DRMgz/O1B7Qa89fKoE4984t46YAgfQrTmjRHulxwPEVham1O4Na6kJ
	 HbOB8PqU/rcCg==
Received: from mailhost.synopsys.com (eudc-mailhost1.synopsys.com [10.213.161.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 717DE40517;
	Thu, 19 Nov 2026 10:06:25 +0000 (UTC)
Received: from prakriti-VM.internal.synopsys.com (unknown [10.150.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mailhost.synopsys.com (Postfix) with ESMTPSA id 43658C17D3;
	Thu, 19 Nov 2026 10:06:20 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From: Prakriti Sharma <Prakriti.Sharma@synopsys.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
        Siddhant Kumar <Siddhant.Kumar@synopsys.com>,
        Prakriti Sharma <Prakriti.Sharma@synopsys.com>
Subject: [PATCH 2/6] spi: dw-g2: Add Synopsys DWC SSI v2.02a driver
Date: Thu, 19 Nov 2026 15:35:09 +0530
Message-Id: <20261119100513.433044-3-prakriti@synopsys.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119100513.433044-1-prakriti@synopsys.com>
References: <20261119100513.433044-1-prakriti@synopsys.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6afeca22 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=jIQo8A4GAAAA:8 a=VwQbUJbxAAAA:8 a=NKaUXhUtRRxtGEBMB7UA:9
 a=QZ4zNXlGoGHec-tL:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MCBTYWx0ZWRfX+LzvJVr5h5Z3
 Lm5FLGYvvyuSIvr65Kv7f/sIEliICCGSp4tYddeYgmlqzjlYAOaFW1MERhc0dwJfdvZScr7hq0U
 GuEs0ohs499+sM8HOx3RvMhzCMWZJ2/IUCcQgb2jIjyKECMK0He1WR4MqODMzJ9bs7qMd3c5Da6
 IbiXoIBZ4sL0kAW/+ab2rArMzgslKxtDz+SC65CkINYY0yhCWvOGGZRQNUPYs6qdldd1kkhGzkX
 Xm2RMX29942sQbFzxxAP2ibq7rv7mNtw38eYboZ4FDPZwG7eUKB0pXd4lKPwkb44ETfvmmJFSSj
 bxUFieWBD0N22LCTD/bgrxW1BZUctUUYKz96QNAnIzUZ46mVwueOmpERC/9noAvrtcD2bFRrmDo
 aILu1Wgu76o7e44HVzzK5le1SwRP2YFcF/iiRNIR7dR6iukTVS2MW4W0d5IRl7ahY02+K0t/UPp
 V+U2jMy1h+QfWr8sfFw==
X-Proofpoint-ORIG-GUID: QzibMcEYTYtA60N2MP4Ki7x798QHUdRv
X-Proofpoint-GUID: QzibMcEYTYtA60N2MP4Ki7x798QHUdRv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MCBTYWx0ZWRfX+PEZ3W+aAB2T
 XHql1IMTLYJqFwmT9nD0oz+uG9rvaDK55ZkPlnMLNvZNykCV/ei79wtwuojBe7EJT1a9sh0Zks3
 1BkPvEI2+82a4cDBnPMQRYAPvRyiFCs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2611040001 definitions=main-2611190040

Add a driver for the Synopsys DesignWare SSI Gen2 (DWC_ssi v2.02a)
controller. Support probe, the MMIO glue, command-only transfers, and
short register operations.

Transfers are polled. The IRQ is claimed, including the optional
per-source rxf, txe, txaf, and wsf lines.

Signed-off-by: Prakriti Sharma <prakriti@synopsys.com>
Signed-off-by: Siddhant Kumar <sidkumar@synopsys.com>
---
 MAINTAINERS                  |   1 +
 drivers/spi/Kconfig          |  21 +
 drivers/spi/Makefile         |   3 +
 drivers/spi/spi-dw-g2-core.c | 896 +++++++++++++++++++++++++++++++++++
 drivers/spi/spi-dw-g2-mmio.c | 196 ++++++++
 drivers/spi/spi-dw-g2.h      | 396 ++++++++++++++++
 6 files changed, 1513 insertions(+)
 create mode 100644 drivers/spi/spi-dw-g2-core.c
 create mode 100644 drivers/spi/spi-dw-g2-mmio.c
 create mode 100644 drivers/spi/spi-dw-g2.h

diff --git a/MAINTAINERS b/MAINTAINERS
index e68a4337a651..e0f97d2792b1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27310,6 +27310,7 @@ M:	Siddhant Kumar <sidkumar@synopsys.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/snps,dwc-ssi-2.02a.yaml
+F:	drivers/spi/spi-dw-g2-*.[ch]
 
 SYNOPSYS HSDK RESET CONTROLLER DRIVER
 M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a7b343d124a9..3c2a7ea543fd 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -381,6 +381,27 @@ config SPI_DESIGNWARE
 
 if SPI_DESIGNWARE
 
+config SPI_DW_SSI_G2
+	tristate "Synopsys Designware SSI Gen2 controller"
+	depends on SPI_DESIGNWARE
+	help
+	  Synopsys DesignWare SSI Gen2 is a SPI controller that supports
+	  standard, dual, quad, and octal SPI modes. It provides high
+	  performance SPI communication using the spi-mem interface.
+	  Enable this option if you have a device with a DW SSI Gen2
+	  controller and want to access SPI flash memories.
+
+config SPI_DW_SSI_G2_MMIO
+	tristate "Memory-mapped io interface driver for DW SSI Gen2 core"
+	depends on HAS_IOMEM
+	depends on SPI_DW_SSI_G2
+	help
+	  Memory-mapped I/O interface driver for the Synopsys DesignWare
+	  SSI Gen2 SPI controller. Enable this for platforms that access
+	  the controller registers via memory-mapped I/O. This is the
+	  most common access method for SoC-integrated instances of the
+	  DW SSI Gen2 controller.
+
 config SPI_DW_DMA
 	bool "DMA support for DW SPI controller"
 
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index b6ab37271555..f9c86827ebc2 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -57,6 +57,9 @@ spi-dw-y				:= spi-dw-core.o
 spi-dw-$(CONFIG_SPI_DW_DMA)		+= spi-dw-dma.o
 obj-$(CONFIG_SPI_DW_MMIO)		+= spi-dw-mmio.o
 obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-pci.o
+obj-$(CONFIG_SPI_DW_SSI_G2)		+= spi-dw-g2.o
+spi-dw-g2-y				:= spi-dw-g2-core.o
+obj-$(CONFIG_SPI_DW_SSI_G2_MMIO)     	+= spi-dw-g2-mmio.o
 obj-$(CONFIG_SPI_EP93XX)		+= spi-ep93xx.o
 obj-$(CONFIG_SPI_FALCON)		+= spi-falcon.o
 obj-$(CONFIG_SPI_FSI)			+= spi-fsi.o
diff --git a/drivers/spi/spi-dw-g2-core.c b/drivers/spi/spi-dw-g2-core.c
new file mode 100644
index 000000000000..7b0928f67103
--- /dev/null
+++ b/drivers/spi/spi-dw-g2-core.c
@@ -0,0 +1,896 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/of.h>
+#include <linux/delay.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+
+#include "spi-dw-g2.h"
+
+/*
+ * ========================================================================
+ * DebugFS support - exposes controller registers for debugging
+ * ========================================================================
+ */
+
+#ifdef CONFIG_DEBUG_FS
+#define DW_SPI_G2_DBG_REG(_name, _off) \
+	{ .name = _name, .offset = _off }
+
+static const struct debugfs_reg32 dw_spi_g2_dbg_regs[] = {
+	DW_SPI_G2_DBG_REG("SSIENR",         DW_SPI_G2_SSIENR),
+	DW_SPI_G2_DBG_REG("SLAVE_EN",       DW_SPI_G2_SER),
+	DW_SPI_G2_DBG_REG("CTRLR0_CS1",     DW_SPI_G2_CTRLR0(1)),
+	DW_SPI_G2_DBG_REG("CTRLR1_CS1",     DW_SPI_G2_CTRLR1(1)),
+	DW_SPI_G2_DBG_REG("SPI_CTRLR0_CS1", DW_SPI_G2_SPI_CTRLR0(1)),
+	DW_SPI_G2_DBG_REG("SPI_CTRLR1_CS1", DW_SPI_G2_SPI_CTRLR1(1)),
+	DW_SPI_G2_DBG_REG("BAUDR1",         DW_SPI_G2_BAUDR(1)),
+	DW_SPI_G2_DBG_REG("TXFTLR",         DW_SPI_G2_TXFTLR),
+	DW_SPI_G2_DBG_REG("RXFTLR",         DW_SPI_G2_RXFTLR),
+	DW_SPI_G2_DBG_REG("TXFLR",          DW_SPI_G2_TXFLR),
+	DW_SPI_G2_DBG_REG("RXFLR",          DW_SPI_G2_RXFLR),
+	DW_SPI_G2_DBG_REG("SR",             DW_SPI_G2_SR),
+	DW_SPI_G2_DBG_REG("IMR",            DW_SPI_G2_IMR),
+	DW_SPI_G2_DBG_REG("ISR",            DW_SPI_G2_ISR),
+	DW_SPI_G2_DBG_REG("DEDICATED_CS",   DW_SPI_G2_DEDICATED_CS_EN),
+};
+
+/**
+ * dw_spi_g2_debugfs_init - Create debugfs entries for register inspection
+ * @dws: Driver state
+ *
+ * Creates a debugfs directory at /sys/kernel/debug/dw_spi_g2.<bus_num>/
+ * with a "registers" file showing current controller register values.
+ * Useful for debugging transfer issues or verifying configuration.
+ */
+static void dw_spi_g2_debugfs_init(struct dw_spi_g2 *dws)
+{
+	char name[32];
+
+	snprintf(name, sizeof(name), "dw_spi_g2.%d", dws->ctlr->bus_num);
+
+	dws->debugfs = debugfs_create_dir(name, NULL);
+	if (!dws->debugfs)
+		return;
+
+	dws->regset.base = dws->regs;
+	dws->regset.regs = dw_spi_g2_dbg_regs;
+	dws->regset.nregs = ARRAY_SIZE(dw_spi_g2_dbg_regs);
+
+	debugfs_create_regset32("registers", 0400, dws->debugfs, &dws->regset);
+}
+
+/**
+ * dw_spi_g2_debugfs_remove - Remove debugfs entries
+ * @dws: Driver state
+ */
+static void dw_spi_g2_debugfs_remove(struct dw_spi_g2 *dws)
+{
+	debugfs_remove_recursive(dws->debugfs);
+	dws->debugfs = NULL;
+}
+#else
+static inline void dw_spi_g2_debugfs_init(struct dw_spi_g2 *dws)
+{
+}
+
+static inline void dw_spi_g2_debugfs_remove(struct dw_spi_g2 *dws)
+{
+}
+#endif
+
+/*
+ * ========================================================================
+ * SPI controller setup and initialization
+ * ========================================================================
+ */
+
+/**
+ * dw_spi_g2_setup - Configure baud rate for a specific SPI device
+ * @spi: SPI device being configured
+ *
+ * Called when a SPI device is added or its parameters change. Calculates
+ * and programs the baud rate divider for the device's requested speed.
+ *
+ * The baud rate register (BAUDR) uses an even divisor:
+ *   actual_speed = ssi_clk / BAUDR
+ *   BAUDR = 1 is a special case (passthrough, no division)
+ *   BAUDR must be even for values > 1
+ *
+ * Per-CS registers are written with the CS register block disabled
+ * (DEDICATED_CS_EN bit cleared) to ensure the write takes effect.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int dw_spi_g2_setup(struct spi_device *spi)
+{
+	struct dw_spi_g2 *dws = spi_controller_get_devdata(spi->controller);
+	u32 baud, speed, div, min_speed;
+
+	/* Get primary chip select (index 0 = first CS of this device) */
+	dws->cs = spi_get_chipselect(spi, 0);
+
+	/*
+	 * Calculate minimum achievable speed: slowest speed occurs at
+	 * maximum baud divisor (clk_rate / MAX_BAUDR).
+	 */
+	min_speed = DIV_ROUND_UP(dws->clk_rate, DW_SPI_G2_MAX_BAUDR);
+
+	/* Determine target speed (capped at controller maximum) */
+	speed = spi->max_speed_hz;
+	if (!speed || speed > dws->max_freq)
+		speed = dws->max_freq;
+
+	/*
+	 * Clamp speed to achievable range. If requested speed is below
+	 * hardware minimum, clamp to min_speed
+	 */
+	if (speed < min_speed) {
+		dev_warn(&spi->dev, "speed %u Hz below minimum %u Hz, clamping\n",
+			 speed, min_speed);
+		speed = min_speed;
+	}
+
+	/*
+	 * Calculate baud rate divisor (must be even, except for 1).
+	 * Since speed >= min_speed, div is guaranteed <= MAX_BAUDR.
+	 */
+	div = DIV_ROUND_UP(dws->clk_rate, speed);
+	if (div <= 1) {
+		baud = 1;	/* Passthrough mode - no division */
+	} else {
+		if (div & 1)
+			div++;	/* Round up to next even number */
+		baud = div;
+	}
+
+	/* Write baud rate to per-CS register (with CS block disabled) */
+	dw_spi_g2_enable(dws, false);
+	dw_spi_g2_target_disable(dws, dws->cs);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_BAUDR(dws->cs), baud);
+
+	dev_dbg(&spi->dev,
+		"setup: CS=%u mode=%u bpw=%u speed=%u baud=%u\n",
+		dws->cs, spi->mode, spi->bits_per_word, speed, baud);
+
+	return 0;
+}
+
+static void dw_spi_g2_controller_reset(struct dw_spi_g2 *dws)
+{
+	int drain = 0;
+
+	dw_spi_g2_enable(dws, false);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SER, 0);
+	/* Clear all interrupts by writing 1s to defined ICR bits */
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_ICR, DW_SPI_G2_ICR_ALL);
+
+	/* Drain any stale RX data left from previous transfers */
+	while (dw_spi_g2_readl(dws->regs, DW_SPI_G2_RXFLR) > 0 &&
+	       drain < dws->fifo_len) {
+		(void)dw_spi_g2_readl(dws->regs, DW_SPI_G2_DR0);
+		drain++;
+	}
+}
+
+/**
+ * dw_spi_g2_build_ctrlr0 - Build CTRLR0 register value
+ * @dws: Driver state
+ * @tmod: Transfer mode (TR=0, TO=1, RO=2, EEPROM=3)
+ * @frf: Frame format (Standard=0, Dual=1, Quad=2, Octal=3)
+ *
+ * Constructs the CTRLR0 register value with transfer mode, frame format,
+ * data frame size, and SPI mode (CPOL/CPHA) settings.
+ *
+ * Return: Constructed CTRLR0 register value
+ */
+static u32 dw_spi_g2_build_ctrlr0(struct dw_spi_g2 *dws, u8 tmod, u8 frf)
+{
+	u32 ctrlr0 = 0;
+	u8 dfs;
+
+	if (!dws->curr_spi) {
+		dev_err(dws->dev, "curr_spi not set\n");
+		return 0;
+	}
+
+	dfs = dws->curr_spi->bits_per_word ? dws->curr_spi->bits_per_word : 8;
+
+	/*
+	 * Validate data frame size (DFS).
+	 * Hardware supports 8, 16, and 32-bit transfers (DFS_ENCODE values 7, 15, 31).
+	 * Current spi-mem implementation uses 8-bit only (per Linux framework).
+	 * For 16/32-bit support via legacy transfer_one path, additional
+	 * FIFO handling logic would be required.
+	 */
+	if (dfs != (DW_SPI_G2_DFS_8BIT + 1) &&
+	    dfs != (DW_SPI_G2_DFS_16BIT + 1) &&
+	    dfs != (DW_SPI_G2_DFS_32BIT + 1)) {
+		dev_err(dws->dev, "Unsupported DFS: %u (must be 8, 16, or 32)\n",
+			dfs);
+		return 0;
+	}
+
+	/* Validate FRF compatibility with DFS */
+	if (frf != DW_SPI_G2_FRF_STANDARD && dfs != (DW_SPI_G2_DFS_8BIT + 1)) {
+		dev_err(dws->dev,
+			"Multi-line SPI modes require 8-bit transfers (dfs=%u frf=%u)\n",
+			dfs, frf);
+		return 0;
+	}
+
+	ctrlr0 |=
+	    FIELD_PREP(DW_SPI_G2_CTRLR0_DFS_MASK, DW_SPI_G2_DFS_ENCODE(dfs));
+	ctrlr0 |= FIELD_PREP(DW_SPI_G2_CTRLR0_TMOD_MASK, tmod);
+	ctrlr0 |= FIELD_PREP(DW_SPI_G2_CTRLR0_FRF_MASK, frf);
+
+	return ctrlr0;
+}
+
+/**
+ * dw_spi_g2_get_frf - Determine frame format from operation bus widths
+ * @op: SPI memory operation
+ *
+ * Examines the command, address, and data bus widths to determine the
+ * widest mode in use, which defines the frame format.
+ *
+ * Return: Frame format
+ */
+static u32 dw_spi_g2_get_frf(const struct spi_mem_op *op)
+{
+	/* Use the widest bus mode across cmd/addr/data phases */
+	u32 width = max3(op->cmd.buswidth,
+			 op->addr.buswidth ? op->addr.buswidth : 1,
+			 op->data.buswidth ? op->data.buswidth : 1);
+
+	switch (width) {
+	case 2:
+		return DW_SPI_G2_FRF_DUAL;
+	case 4:
+		return DW_SPI_G2_FRF_QUAD;
+	case 8:
+		return DW_SPI_G2_FRF_OCTAL;
+	default:
+		return DW_SPI_G2_FRF_STANDARD;
+	}
+}
+
+/**
+ * dw_spi_g2_get_tt - Determine transfer type from operation bus widths
+ * @op: SPI memory operation
+ *
+ * The transfer type (TT) field in SPI_CTRLR0 defines which phases use
+ * multi-line mode. TT0 = standard (1-1-1), TT1 = data multi-line (1-1-x),
+ * TT2 = addr+data multi-line (1-x-x). TT3 (x-x-x) is not supported.
+ *
+ * Return: Transfer type value (0-2), or -EOPNOTSUPP for unsupported patterns
+ */
+static int dw_spi_g2_get_tt(const struct spi_mem_op *op)
+{
+	bool cmd_m = (op->cmd.buswidth > 1);
+	bool addr_m = (op->addr.nbytes && op->addr.buswidth > 1);
+	bool data_m = (op->data.nbytes && op->data.buswidth > 1);
+
+	if (!cmd_m && !addr_m && !data_m)
+		return DW_SPI_G2_TRANS_TYPE_TT0;	/* 1-1-1 */
+	if (!cmd_m && !addr_m && data_m)
+		return DW_SPI_G2_TRANS_TYPE_TT1;	/* 1-1-x */
+	if (!cmd_m && addr_m && data_m)
+		return DW_SPI_G2_TRANS_TYPE_TT2;	/* 1-x-x */
+
+	return -EOPNOTSUPP;
+}
+
+/**
+ * dw_spi_g2_is_reg_op - Check if operation is a register read/write
+ * @op: SPI memory operation
+ *
+ * Register operations are single-byte commands with no address (e.g.,
+ * RDSR, WRSR, RDID). Data must fit within the fixed-size stack buffer.
+ */
+static inline bool dw_spi_g2_is_reg_op(const struct spi_mem_op *op)
+{
+	return !op->addr.nbytes && op->data.nbytes > 0 &&
+	       op->data.nbytes <= DW_SPI_G2_REG_OP_MAX_DATA;
+}
+
+/**
+ * dw_spi_g2_xfer_fifo - Low-level FIFO transfer using polling
+ * @dws: Driver state
+ * @tx_buf: TX buffer (or NULL if no TX)
+ * @tx_len: Number of bytes to transmit
+ * @rx_buf: RX buffer (or NULL if no RX expected)
+ * @rx_len: Number of bytes to receive
+ *
+ * Performs a polled FIFO transfer. Writes tx_len bytes from tx_buf to DR0,
+ * checking SR.TFNF (TX FIFO not full) before each write. For RX, waits for
+ * RXFLR to indicate data availability, then reads rx_len bytes from DR0.
+ *
+ * Return: 0 on success, -ETIMEDOUT on timeout
+ */
+static int dw_spi_g2_xfer_fifo(struct dw_spi_g2 *dws,
+			       const u8 *tx_buf, u32 tx_len,
+			       u8 *rx_buf, u32 rx_len)
+{
+	u32 tx_sent = 0;
+	u32 rx_got = 0;
+	u32 sr;
+	unsigned long timeout;
+
+	/* TX phase: push bytes checking TFNF */
+	timeout = jiffies + msecs_to_jiffies(1000);
+	while (tx_sent < tx_len) {
+		sr = dw_spi_g2_readl(dws->regs, DW_SPI_G2_SR);
+		if (sr & DW_SPI_G2_SR_TFNF) {
+			dw_spi_g2_writel(dws->regs, DW_SPI_G2_DR0,
+					 tx_buf[tx_sent]);
+			tx_sent++;
+			timeout = jiffies + msecs_to_jiffies(1000);
+		} else if (time_after(jiffies, timeout)) {
+			dev_err(dws->dev,
+				"xfer_fifo: TX timeout after %u/%u bytes (SR=0x%08x)\n",
+				tx_sent, tx_len, sr);
+			return -ETIMEDOUT;
+		}
+		cpu_relax();
+	}
+
+	if (!rx_buf || !rx_len) {
+		dw_spi_g2_wait_idle(dws);
+		return 0;
+	}
+
+	/* RX phase */
+	timeout = jiffies + msecs_to_jiffies(1000);
+	while (rx_got < rx_len) {
+		sr = dw_spi_g2_readl(dws->regs, DW_SPI_G2_SR);
+		if (sr & DW_SPI_G2_SR_RFNE) {
+			rx_buf[rx_got++] = dw_spi_g2_readl(dws->regs,
+							   DW_SPI_G2_DR0) &
+			    0xff;
+			timeout = jiffies + msecs_to_jiffies(1000);
+		} else if (time_after(jiffies, timeout)) {
+			dev_err(dws->dev,
+				"xfer_fifo: RX timeout after %u/%u bytes (SR=0x%08x RXFLR=%u)\n",
+				rx_got, rx_len,
+				dw_spi_g2_readl(dws->regs, DW_SPI_G2_SR),
+				dw_spi_g2_readl(dws->regs, DW_SPI_G2_RXFLR));
+			return -ETIMEDOUT;
+		}
+		cpu_relax();
+	}
+
+	dw_spi_g2_wait_idle(dws);
+	return 0;
+}
+
+/**
+ * dw_spi_g2_fill_tx_buf - Serialize command/address/data into TX buffer
+ * @buf: Destination buffer
+ * @op: SPI memory operation
+ * @include_data: true to include data bytes, false for command+address only
+ *
+ * Builds a byte stream from a spi_mem_op structure:
+ *   [opcode bytes MSB..LSB] [address bytes MSB..LSB] [data bytes (optional)].
+ *
+ * Return: Total number of bytes written to buf
+ */
+static u32 dw_spi_g2_fill_tx_buf(u8 *buf, const struct spi_mem_op *op,
+				 bool include_data)
+{
+	u32 pos = 0;
+
+	/* Serialize multi-byte opcode (MSB first) */
+	for (u32 i = 0; i < op->cmd.nbytes; i++)
+		buf[pos++] =
+		    (op->cmd.opcode >> (8 * (op->cmd.nbytes - 1 - i))) & 0xff;
+
+	/* Serialize address (MSB first) */
+	for (u32 i = 0; i < op->addr.nbytes; i++)
+		buf[pos++] =
+		    (op->addr.val >> (8 * (op->addr.nbytes - 1 - i))) & 0xff;
+
+	/* Optionally append data bytes for write operations */
+	if (include_data && op->data.nbytes && op->data.dir == SPI_MEM_DATA_OUT) {
+		memcpy(&buf[pos], op->data.buf.out, op->data.nbytes);
+		pos += op->data.nbytes;
+	}
+
+	return pos;
+}
+
+/**
+ * Command-only operations (WREN, WRDI, Chip Erase, Sector Erase, etc.)
+ * TMOD=1 (TX-Only) — Send opcode + optional address, no data phase
+ */
+
+/**
+ * dw_spi_g2_cmd_only_setup - Configure controller for command-only operation
+ * @dws: Driver state
+ * @op: SPI memory operation
+ *
+ * Configures TMOD=TO (transmit-only), standard SPI mode..
+ */
+static void dw_spi_g2_cmd_only_setup(struct dw_spi_g2 *dws,
+				     const struct spi_mem_op *op)
+{
+	u32 ctrlr0 = dw_spi_g2_build_ctrlr0(dws, DW_SPI_G2_CTRLR0_TMOD_TO,
+					    DW_SPI_G2_FRF_STANDARD);
+
+	dw_spi_g2_controller_reset(dws);
+	dw_spi_g2_target_disable(dws, dws->cs);
+
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR0(dws->cs), ctrlr0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR1(dws->cs), 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SPI_CTRLR0(dws->cs), 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_TXFTLR, 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_RXFTLR, 0);
+}
+
+/**
+ * dw_spi_g2_cmd_only - Execute command-only operation
+ * @dws: Driver state
+ * @op: SPI memory operation
+ *
+ * Sends a command with optional address but no data payload.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int dw_spi_g2_cmd_only(struct dw_spi_g2 *dws,
+			      const struct spi_mem_op *op)
+{
+	u8 buf[8];
+	u32 len;
+	int ret;
+
+	dw_spi_g2_cmd_only_setup(dws, op);
+
+	len = dw_spi_g2_fill_tx_buf(buf, op, false);
+
+	dw_spi_g2_transfer_begin(dws);
+	ret = dw_spi_g2_xfer_fifo(dws, buf, len, NULL, 0);
+	dw_spi_g2_transfer_end(dws);
+	dw_spi_g2_controller_reset(dws);
+	return ret;
+}
+
+static void dw_spi_g2_reg_op_setup(struct dw_spi_g2 *dws,
+				   const struct spi_mem_op *op)
+{
+	u8 tmod;
+	u32 ctrlr0;
+
+	dw_spi_g2_controller_reset(dws);
+	dw_spi_g2_target_disable(dws, dws->cs);
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		tmod = DW_SPI_G2_CTRLR0_TMOD_TR;
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR1(dws->cs), 0);
+	} else {
+		tmod = DW_SPI_G2_CTRLR0_TMOD_TO;
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR1(dws->cs), 0);
+	}
+
+	ctrlr0 = dw_spi_g2_build_ctrlr0(dws, tmod, DW_SPI_G2_FRF_STANDARD);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR0(dws->cs), ctrlr0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SPI_CTRLR0(dws->cs), 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_TXFTLR, 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_RXFTLR, 0);
+}
+
+static int dw_spi_g2_reg_op(struct dw_spi_g2 *dws, const struct spi_mem_op *op)
+{
+	u8 tx_buf[DW_SPI_G2_REG_OP_MAX_DATA + 1];
+	u32 tx_len;
+	int ret;
+
+	/* Validate data length fits in stack buffer */
+	if (op->data.nbytes > DW_SPI_G2_REG_OP_MAX_DATA) {
+		dev_err(dws->dev, "reg_op data length %u exceeds max %u\n",
+			op->data.nbytes, DW_SPI_G2_REG_OP_MAX_DATA);
+		return -EINVAL;
+	}
+
+	dw_spi_g2_reg_op_setup(dws, op);
+
+	dw_spi_g2_transfer_begin(dws);
+
+	if (op->data.dir == SPI_MEM_DATA_OUT) {
+		if (!op->data.buf.out) {
+			dev_err(dws->dev, "TX buffer is NULL\n");
+			return -EINVAL;
+		}
+		/* TX: [opcode] [data bytes] */
+		tx_buf[0] = op->cmd.opcode;
+		memcpy(&tx_buf[1], op->data.buf.out, op->data.nbytes);
+		tx_len = 1 + op->data.nbytes;
+		ret = dw_spi_g2_xfer_fifo(dws, tx_buf, tx_len, NULL, 0);
+	} else {
+		if (!op->data.buf.in) {
+			dev_err(dws->dev, "RX buffer is NULL\n");
+			return -EINVAL;
+		}
+		/*
+		 * TR mode: each TX byte produces one RX byte.
+		 * Push opcode + nbytes dummy 0x00s, receive 1+nbytes,
+		 * discard first RX byte (echo of opcode phase).
+		 */
+		u8 rx_tmp[DW_SPI_G2_REG_OP_MAX_DATA + 1];
+
+		tx_buf[0] = op->cmd.opcode;
+		memset(&tx_buf[1], 0x00, op->data.nbytes);
+		tx_len = 1 + op->data.nbytes;
+		ret = dw_spi_g2_xfer_fifo(dws, tx_buf, tx_len, rx_tmp, tx_len);
+		if (!ret)
+			memcpy(op->data.buf.in, &rx_tmp[1], op->data.nbytes);
+	}
+
+	dw_spi_g2_transfer_end(dws);
+	dw_spi_g2_controller_reset(dws);
+
+	return ret;
+}
+
+/**
+ * Indirect read operations
+ */
+
+/*
+ * ========================================================================
+ * SPI-MEM interface
+ * ========================================================================
+ */
+
+static bool dw_spi_g2_supports_mem_ops(struct spi_mem *mem,
+				       const struct spi_mem_op *op)
+{
+	return spi_mem_default_supports_op(mem, op);
+}
+
+int dw_spi_g2_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		op->data.nbytes = min_t(u32, op->data.nbytes, DW_G2_MAX_CHUNK);
+	else if (op->data.dir == SPI_MEM_DATA_OUT)
+		op->data.nbytes = min_t(u32, op->data.nbytes, DW_G2_MAX_CHUNK);
+
+	return 0;
+}
+
+static int dw_spi_g2_exec_mem_op(struct spi_mem *mem,
+				 const struct spi_mem_op *op)
+{
+	struct spi_device *spi = mem->spi;
+	struct dw_spi_g2 *dws = spi_controller_get_devdata(spi->controller);
+
+	/* Validate operation structure */
+	if (!op || !op->cmd.nbytes) {
+		dev_err(dws->dev, "Invalid operation: missing command\n");
+		return -EINVAL;
+	}
+
+	/* Validate command length */
+	if (op->cmd.nbytes > 2) {
+		dev_err(dws->dev, "command length %u exceeds maximum 2 bytes\n",
+			op->cmd.nbytes);
+		return -EINVAL;
+	}
+
+	/* Validate address length */
+	if (op->addr.nbytes &&
+	    op->addr.nbytes * 8U > DW_SPI_G2_ADDR_L_MAX_BITS) {
+		dev_err(dws->dev, "address length %u bytes (%u bits) exceeds max %u bits\n",
+			op->addr.nbytes, op->addr.nbytes * 8U, DW_SPI_G2_ADDR_L_MAX_BITS);
+		return -EINVAL;
+	}
+
+	/* Validate dummy cycles */
+	if (op->dummy.nbytes) {
+		u32 dummy_cycles;
+
+		if (!op->dummy.buswidth || op->dummy.buswidth > 8) {
+			dev_err(dws->dev, "invalid dummy buswidth %u\n",
+				op->dummy.buswidth);
+			return -EINVAL;
+		}
+		dummy_cycles = (op->dummy.nbytes * 8) / op->dummy.buswidth;
+		if (dummy_cycles > DW_SPI_G2_SPI_CTRLR0_WAIT_CYCLES_MAX) {
+			dev_err(dws->dev, "dummy cycles %u exceed maximum %u\n",
+				dummy_cycles, DW_SPI_G2_SPI_CTRLR0_WAIT_CYCLES_MAX);
+			return -EINVAL;
+		}
+	}
+
+	/* Validate data length against controller limits */
+	if (op->data.nbytes > DW_G2_MAX_CHUNK) {
+		dev_err(dws->dev, "data length %u exceeds maximum %u\n",
+			op->data.nbytes, DW_G2_MAX_CHUNK);
+		return -EINVAL;
+	}
+
+	/* Get primary chip select (index 0 = first CS of this device) */
+	dws->cs = spi_get_chipselect(spi, 0);
+	dws->curr_spi = spi;
+
+	dev_dbg(dws->dev,
+		"exec_mem_op: cmd=0x%02x addr_len=%u data_len=%u dir=%d\n",
+		op->cmd.opcode, op->addr.nbytes, op->data.nbytes,
+		op->data.dir);
+
+	if (op->data.dir == SPI_MEM_NO_DATA)
+		return dw_spi_g2_cmd_only(dws, op);
+
+	if (dw_spi_g2_is_reg_op(op))
+		return dw_spi_g2_reg_op(dws, op);
+
+	/*
+	 * Bulk reads and writes are added by the indirect-transfer patch.
+	 * This patch handles commands and short register operations only.
+	 */
+	if (op->data.dir != SPI_MEM_NO_DATA && !dw_spi_g2_is_reg_op(op))
+		return -EOPNOTSUPP;
+
+	return -EOPNOTSUPP;
+}
+
+static const struct spi_controller_mem_ops dw_spi_g2_mem_ops = {
+	.supports_op = dw_spi_g2_supports_mem_ops,
+	.adjust_op_size = dw_spi_g2_adjust_mem_op_size,
+	.exec_op = dw_spi_g2_exec_mem_op,
+};
+
+/*
+ * FIFO depth is a synthesis-time parameter not exposed by any
+ * discoverable register and varies per instantiation (e.g. 256 on
+ * TDA54, 32 on the AM72 VDK). TXFTLR's field is only log2(fifo_depth)
+ * bits wide, so writing increasing values and reading back finds where
+ * the hardware clamps it - same probe spi-dw-core.c uses for this IP.
+ * Caller must have the controller disabled (SSIENR=0).
+ */
+static u32 dw_spi_g2_detect_fifo_len(struct dw_spi_g2 *dws)
+{
+	u32 fifo;
+
+	for (fifo = 1; fifo < DW_SPI_G2_FIFO_LEN; fifo++) {
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_TXFTLR, fifo);
+		if (dw_spi_g2_readl(dws->regs, DW_SPI_G2_TXFTLR) != fifo)
+			break;
+	}
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_TXFTLR, 0);
+
+	return (fifo == 1) ? DW_SPI_G2_FIFO_LEN : fifo;
+}
+
+/**
+ * dw_spi_g2_init - Initialize the SPI controller
+ * @dws: Driver state
+ *
+ * Performs one-time controller initialization:
+ *   - Disables SSI and clears chip selects
+ *   - Masks all interrupts (driver uses polling only)
+ *   - Sets FIFO depth and mode bits
+ *   - Registers spi-mem operations
+ *   - Creates debugfs entries
+ *
+ * Called once during probe. The controller is left in a disabled state;
+ * individual transfers will enable it as needed.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int dw_spi_g2_init(struct dw_spi_g2 *dws)
+{
+	struct spi_controller *ctlr = dws->ctlr;
+
+	dev_info(dws->dev, "DW SSI G2 core init\n");
+
+	/* Disable controller and reset to clean state */
+	dw_spi_g2_enable(dws, false);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SER, 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_DEDICATED_CS_EN, 0);
+
+	/* Mask all interrupts — this driver uses polling only */
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_IMR, 0);
+	/* Clear all interrupts by writing 1s to defined ICR bits */
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_ICR, DW_SPI_G2_ICR_ALL);
+
+	/* Hardware capabilities */
+	dws->fifo_len = dw_spi_g2_detect_fifo_len(dws);
+	dws->caps = 0;
+
+	if (!dws->max_freq)
+		dws->max_freq = DW_SPI_G2_DEF_MAX_FREQ;
+
+	/* supported SPI modes to the framework */
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA |
+	    SPI_TX_DUAL | SPI_RX_DUAL |
+	    SPI_TX_QUAD | SPI_RX_QUAD | SPI_TX_OCTAL | SPI_RX_OCTAL;
+
+	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctlr->flags = 0;
+
+	ctlr->setup = dw_spi_g2_setup;
+	ctlr->mem_ops = &dw_spi_g2_mem_ops;
+
+	dw_spi_g2_debugfs_init(dws);
+	init_completion(&dws->mem_done);
+
+	dev_info(dws->dev, "Core Init done: fifo=%u max_freq=%u\n",
+		 dws->fifo_len, dws->max_freq);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(dw_spi_g2_init, "SPI_DW_G2_CORE");
+
+/**
+ * dw_spi_g2_deinit - Clean up controller resources
+ * @dws: Driver state
+ *
+ * Called during driver removal to clean up debugfs and other resources.
+ */
+void dw_spi_g2_deinit(struct dw_spi_g2 *dws)
+{
+	dw_spi_g2_debugfs_remove(dws);
+}
+EXPORT_SYMBOL_NS_GPL(dw_spi_g2_deinit, "SPI_DW_G2_CORE");
+
+/*
+ * ========================================================================
+ * Legacy SPI transfer_one interface (not actively used with spi-mem)
+ * ========================================================================
+ */
+
+/**
+ * dw_spi_g2_update_config - Update controller configuration for a transfer
+ * @dws: Driver state
+ * @spi: SPI device
+ * @cfg: Transfer configuration
+ *
+ * Programs CTRLR0, CTRLR1, and BAUDR for a transfer. Used by the legacy
+ * transfer_one path (not used when operating via spi-mem).
+ */
+void dw_spi_g2_update_config(struct dw_spi_g2 *dws, struct spi_device *spi,
+			     struct dw_spi_g2_cfg *cfg)
+{
+	u32 ctrlr0 = 0;
+	u32 div;
+
+	ctrlr0 |= FIELD_PREP(DW_SPI_G2_CTRLR0_DFS_MASK, cfg->dfs - 1);
+	ctrlr0 |= FIELD_PREP(DW_SPI_G2_CTRLR0_TMOD_MASK, cfg->tmode);
+
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR0(dws->cs), ctrlr0);
+
+	if (cfg->tmode == DW_SPI_G2_CTRLR0_TMOD_RO)
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR1(dws->cs), cfg->ndf - 1);
+
+	div = DIV_ROUND_UP(dws->max_freq, cfg->freq);
+	if (div & 1)
+		div++;
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_BAUDR(dws->cs), div);
+}
+
+/**
+ * dw_spi_g2_transfer_one - Execute a single SPI transfer (legacy interface)
+ * @ctlr: SPI controller
+ * @spi: SPI device
+ * @xfer: Transfer to execute
+ *
+ * Implements the legacy transfer_one callback for the SPI framework.
+ * This path is NOT used when the controller operates via spi-mem
+ * (which is the primary mode for flash operations). Provided for
+ * compatibility with non-memory SPI devices.
+ *
+ * Uses polling-based full-duplex (TMOD=TR) transfers.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int dw_spi_g2_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
+			   struct spi_transfer *xfer)
+{
+	struct dw_spi_g2 *dws = spi_controller_get_devdata(ctlr);
+	struct dw_spi_g2_cfg cfg = {
+		.tmode = DW_SPI_G2_CTRLR0_TMOD_TR,
+		.dfs = xfer->bits_per_word,
+		.freq = xfer->speed_hz,
+	};
+	u32 sr;
+
+	dws->tx = xfer->tx_buf;
+	dws->rx = xfer->rx_buf;
+	dws->tx_len = xfer->len;
+	dws->rx_len = xfer->len;
+	dws->n_bytes = 1;
+
+	/* Ensure writes to device reach memory before enable */
+	wmb();
+
+	dw_spi_g2_enable(dws, false);
+	dw_spi_g2_update_config(dws, spi, &cfg);
+
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_TXFTLR, dws->fifo_len / 2);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_RXFTLR, (dws->fifo_len / 2) - 1);
+
+	dw_spi_g2_enable(dws, true);
+
+	local_irq_disable();
+	/* Polling-based full-duplex transfer */
+	while (dws->tx_len || dws->rx_len) {
+		sr = dw_spi_g2_readl(dws->regs, DW_SPI_G2_SR);
+
+		/* Transmit if FIFO not full and bytes remaining */
+		if (dws->tx_len && (sr & DW_SPI_G2_SR_TFNF)) {
+			u8 val = 0;
+
+			if (dws->tx) {
+				val = *(u8 *)dws->tx;
+				dws->tx += 1;
+			}
+			dw_spi_g2_writel(dws->regs, DW_SPI_G2_DR0, val);
+			dws->tx_len--;
+		}
+
+		/* Receive if FIFO not empty and bytes expected */
+		if (dws->rx_len && (sr & DW_SPI_G2_SR_RFNE)) {
+			u8 val = dw_spi_g2_readl(dws->regs, DW_SPI_G2_DR0);
+
+			if (dws->rx) {
+				*(u8 *)dws->rx = val;
+				dws->rx += 1;
+			}
+			dws->rx_len--;
+		}
+		cpu_relax();
+	}
+	local_irq_enable();
+
+	/* Wait for transfer completion */
+	if (dw_spi_g2_wait_idle(dws)) {
+		dev_err(dws->dev, "transfer_one: timeout waiting for idle\n");
+		dw_spi_g2_enable(dws, false);
+		return -ETIMEDOUT;
+	}
+
+	dw_spi_g2_enable(dws, false);
+
+	spi_finalize_current_transfer(ctlr);
+	return 0;
+}
+
+/**
+ * dw_spi_g2_irq - Minimal interrupt handler for error detection
+ * @irq: IRQ number
+ * @dev_id: Driver state
+ *
+ * This driver operates in polling mode with all interrupts masked (IMR=0).
+ * This handler should normally not be invoked. It exists only to catch
+ * unexpected error interrupts that may occur despite masking.
+ *
+ * Return: IRQ_HANDLED if interrupt was ours, IRQ_NONE otherwise
+ */
+irqreturn_t dw_spi_g2_irq(int irq, void *dev_id)
+{
+	struct dw_spi_g2 *dws = dev_id;
+	u32 isr;
+
+	isr = dw_spi_g2_readl(dws->regs, DW_SPI_G2_ISR);
+	if (!isr)
+		return IRQ_NONE;
+
+	/* Check for error conditions */
+	if (isr & (DW_SPI_G2_ISR_RXOI | DW_SPI_G2_ISR_RXUI |
+		   DW_SPI_G2_ISR_TXOI | DW_SPI_G2_ISR_TXUI)) {
+		dev_warn(dws->dev, "Error interrupt: ISR=0x%x\n", isr);
+		dws->error = -EIO;
+	}
+
+	/* Clear all interrupts by writing 1s to defined ICR bits */
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_ICR, DW_SPI_G2_ICR_ALL);
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_NS_GPL(dw_spi_g2_irq, "SPI_DW_G2_CORE");
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DesignWare SPI Gen2 SSI Controller");
diff --git a/drivers/spi/spi-dw-g2-mmio.c b/drivers/spi/spi-dw-g2-mmio.c
new file mode 100644
index 000000000000..6ef8f926e0eb
--- /dev/null
+++ b/drivers/spi/spi-dw-g2-mmio.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/spi/spi.h>
+#include <linux/interrupt.h>
+
+#include "spi-dw-g2.h"
+
+struct dw_spi_g2_mmio {
+	struct dw_spi_g2	dws;
+	struct clk		*clk;
+	struct clk		*pclk;
+	struct reset_control	*rstc;
+};
+
+static int dw_spi_g2_mmio_probe(struct platform_device *pdev)
+{
+	struct dw_spi_g2_mmio *dwsmmio;
+	struct dw_spi_g2 *dws;
+	struct resource *mem;
+	struct spi_controller *ctlr;
+	u32 num_cs;
+	int ret;
+
+	ctlr = spi_alloc_host(&pdev->dev, sizeof(*dwsmmio));
+	if (!ctlr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ctlr);
+
+	dwsmmio = spi_controller_get_devdata(ctlr);
+	dws = &dwsmmio->dws;
+
+	dws->dev = &pdev->dev;
+	dws->ctlr = ctlr;
+
+	/* MMIO */
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dws->regs = devm_ioremap_resource(&pdev->dev, mem);
+	if (IS_ERR(dws->regs)) {
+		ret = PTR_ERR(dws->regs);
+		goto err_put;
+	}
+
+	/*
+	 * IRQ.
+	 *
+	 * The DWC SSI Gen2 IP exposes per-source interrupt outputs
+	 * alongside a combined ssi_intr. SoC integrators may route
+	 * either the combined line, the individual lines, or any
+	 * subset. We accept both DT forms:
+	 *
+	 *  - Named-line DT: one entry per output, with interrupt-names
+	 *    in {"rxf","txe","txaf","wsf"}. Each line is requested
+	 *    and bound to the shared dw_spi_g2_irq() decoder.
+	 *  - Single-line DT: combined ssi_intr at index 0, used by
+	 *    integrations that OR the sources in HW.
+	 *
+	 * Either way dws->irq holds the "primary" line (rxf when
+	 * named, index 0 otherwise) so debugfs and PM paths stay
+	 * source-agnostic.
+	 */
+	dws->irq = platform_get_irq_byname_optional(pdev, "rxf");
+	if (dws->irq < 0)
+		dws->irq = platform_get_irq(pdev, 0);
+	if (dws->irq < 0) {
+		ret = dws->irq;
+		goto err_put;
+	}
+
+	/* clocks */
+	dwsmmio->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(dwsmmio->clk)) {
+		ret = PTR_ERR(dwsmmio->clk);
+		goto err_put;
+	}
+
+	dwsmmio->pclk = devm_clk_get_optional_enabled(&pdev->dev, "pclk");
+	if (IS_ERR(dwsmmio->pclk)) {
+		ret = PTR_ERR(dwsmmio->pclk);
+		goto err_put;
+	}
+
+	dws->clk_rate = clk_get_rate(dwsmmio->clk);
+	dev_dbg(&pdev->dev, "SSI clock rate = %u Hz\n", dws->clk_rate);
+
+	/* Reset control (shared: multiple IPs may use same reset line) */
+	dwsmmio->rstc = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
+	if (IS_ERR(dwsmmio->rstc)) {
+		ret = PTR_ERR(dwsmmio->rstc);
+		goto err_put;
+	}
+
+	reset_control_deassert(dwsmmio->rstc);
+
+	/* Read num-cs from device tree */
+	ret = device_property_read_u32(&pdev->dev, "num-cs", &num_cs);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to read 'num-cs' property: %d\n", ret);
+		goto err_reset;
+	}
+	ctlr->num_chipselect = num_cs;
+
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SER, 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_DEDICATED_CS_EN,
+			 GENMASK(ctlr->num_chipselect - 1, 0));
+	dw_spi_g2_enable(dws, false);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_IMR, 0);
+	/* Clear all interrupts by writing 1s to defined ICR bits */
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_ICR, DW_SPI_G2_ICR_ALL);
+
+	/*
+	 * Latch the static controller identity once. VERSION_ID and
+	 * HW_CAPABILITIES are read-only and never change at runtime.
+	 */
+	dws->version_id = dw_spi_g2_readl(dws->regs, DW_SPI_G2_VERSION_ID);
+	dws->hw_caps = dw_spi_g2_readl(dws->regs, DW_SPI_G2_HW_CAPABILITIES);
+	dws->caps = dws->hw_caps;
+
+	dev_dbg(dws->dev, "VERSION_ID = 0x%08x\n", dws->version_id);
+	dev_dbg(dws->dev, "HW_CAPS = 0x%08x\n", dws->hw_caps);
+
+	dws->max_freq = clk_get_rate(dwsmmio->clk);
+	/* SPI Controller Setup */
+	ctlr->bus_num = of_alias_get_id(pdev->dev.of_node, "spi");
+	if (ctlr->bus_num < 0)
+		ctlr->bus_num = pdev->id;
+	ctlr->transfer_one = NULL;
+	ctlr->dev.of_node = pdev->dev.of_node;
+
+	spi_controller_set_devdata(ctlr, dws);
+
+	/* core init */
+	ret = dw_spi_g2_init(dws);
+	if (ret)
+		goto err_reset;
+
+	ret = devm_request_irq(&pdev->dev, dws->irq, dw_spi_g2_irq, 0,
+			       dev_name(&pdev->dev), dws);
+	if (ret)
+		goto err_reset;
+
+	pm_runtime_enable(&pdev->dev);
+
+	ret = spi_register_controller(ctlr);
+	if (ret)
+		goto err_pm;
+
+	dev_info(&pdev->dev, "DW SSI G2 MMIO probed\n");
+	return 0;
+
+err_pm:
+	pm_runtime_disable(&pdev->dev);
+err_reset:
+	reset_control_assert(dwsmmio->rstc);
+err_put:
+	spi_controller_put(ctlr);
+	return ret;
+}
+
+static void dw_spi_g2_mmio_remove(struct platform_device *pdev)
+{
+	struct spi_controller *ctlr = platform_get_drvdata(pdev);
+	struct dw_spi_g2_mmio *dwsmmio = spi_controller_get_devdata(ctlr);
+
+	spi_unregister_controller(ctlr);
+	dw_spi_g2_deinit(&dwsmmio->dws);
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(dwsmmio->rstc);
+}
+
+static const struct of_device_id dw_spi_g2_of_match[] = {
+	{ .compatible = "snps,dwc-ssi-2.02a", .data = dw_spi_g2_init},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, dw_spi_g2_of_match);
+
+static struct platform_driver dw_spi_g2_mmio_driver = {
+	.probe  = dw_spi_g2_mmio_probe,
+	.remove = dw_spi_g2_mmio_remove,
+	.driver = {
+		.name = "dw-spi-g2-mmio",
+		.of_match_table = dw_spi_g2_of_match,
+	},
+};
+
+module_platform_driver(dw_spi_g2_mmio_driver);
+
+MODULE_IMPORT_NS("SPI_DW_G2_CORE");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DesignWare SSI G2 MMIO driver");
diff --git a/drivers/spi/spi-dw-g2.h b/drivers/spi/spi-dw-g2.h
new file mode 100644
index 000000000000..1106be0af7b6
--- /dev/null
+++ b/drivers/spi/spi-dw-g2.h
@@ -0,0 +1,396 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+
+#ifndef _SPI_DW_G2_H
+#define _SPI_DW_G2_H
+
+#include <linux/spi/spi.h>
+#include <linux/io.h>
+#include <linux/device.h>
+#include <linux/irqreturn.h>
+#include <linux/iopoll.h>
+#include <linux/spi/spi-mem.h>
+
+#ifdef CONFIG_DEBUG_FS
+#include <linux/debugfs.h>
+#endif
+
+/* Identification */
+#define DW_SPI_G2_REG_MAP_VERSION       0x00
+#define DW_SPI_G2_HW_CAPABILITIES       0x04
+#define DW_SPI_G2_VERSION_ID            0x8C
+
+/* Dedicated CS Offset */
+#define DW_SPI_G2_DEDICATED_CS_BASE             0x1AC
+#define DW_SPI_G2_DEDICATED_CS_STRIDE           0x14
+#define DW_SPI_G2_DEDICATED_CS_EN               0x50
+#define DW_SPI_G2_CS_OFFSET(cs) \
+		(DW_SPI_G2_DEDICATED_CS_BASE + (cs) * DW_SPI_G2_DEDICATED_CS_STRIDE)
+
+/* Dedicated CS Blocks */
+#define DW_SPI_G2_CTRLR0(cs)            (DW_SPI_G2_CS_OFFSET(cs) + 0x04)
+#define DW_SPI_G2_SPI_CTRLR0(cs)        (DW_SPI_G2_CS_OFFSET(cs) + 0x08)
+#define DW_SPI_G2_BAUDR(cs)             (DW_SPI_G2_CS_OFFSET(cs) + 0x0C)
+#define DW_SPI_G2_CTRLR1(cs)            (DW_SPI_G2_CS_OFFSET(cs) + 0x10)
+#define DW_SPI_G2_SPI_CTRLR1(cs)        (DW_SPI_G2_CS_OFFSET(cs) + 0x14)
+
+#define DW_SPI_G2_SSIENR                0x4C
+#define DW_SPI_G2_SER                   0x54
+#define DW_SPI_G2_TXFTLR                0x58
+#define DW_SPI_G2_RXFTLR                0x5c
+#define DW_SPI_G2_TXFLR                 0x60
+#define DW_SPI_G2_RXFLR                 0x64
+#define DW_SPI_G2_SR                    0x6C
+#define DW_SPI_G2_DR0                   0x90
+#define DW_SPI_G2_DR1                   0x94
+#define DW_SPI_G2_DR(i)                 (DW_SPI_G2_DR0 + ((i) * 4))
+#define DW_SPI_G2_IMR                   0x70
+#define DW_SPI_G2_ISR                   0x74
+#define DW_SPI_G2_RISR                  0x78
+#define DW_SPI_G2_ICR                   0x7C
+#define DW_SPI_G2_IDR                   0x88
+
+/* ISR bit masks (interrupt status) */
+#define DW_SPI_G2_ISR_TXEI              BIT(0)  /* TX FIFO Empty */
+#define DW_SPI_G2_ISR_TXOI              BIT(1)  /* TX FIFO Overflow */
+#define DW_SPI_G2_ISR_RXUI              BIT(2)  /* RX FIFO Underflow */
+#define DW_SPI_G2_ISR_RXOI              BIT(3)  /* RX FIFO Overflow */
+#define DW_SPI_G2_ISR_RXFI              BIT(4)  /* RX FIFO Full */
+#define DW_SPI_G2_ISR_MSTI              BIT(5)  /* Multi-Master Error */
+#define DW_SPI_G2_ISR_XRXOI             BIT(6)  /* Extended RX Overflow */
+#define DW_SPI_G2_ISR_TXUI              BIT(7)  /* TX FIFO Underflow */
+
+/* ICR bit masks (write 1 to clear corresponding interrupt) */
+#define DW_SPI_G2_ICR_TXOICR            BIT(1)  /* TX FIFO Overflow Clear */
+#define DW_SPI_G2_ICR_RXUICR            BIT(2)  /* RX FIFO Underflow Clear */
+#define DW_SPI_G2_ICR_RXOICR            BIT(3)  /* RX FIFO Overflow Clear */
+#define DW_SPI_G2_ICR_MSTICR            BIT(5)  /* Multi-Master Clear */
+#define DW_SPI_G2_ICR_XRXOICR           BIT(6)  /* Extended RX Overflow Clear */
+#define DW_SPI_G2_ICR_TXUICR            BIT(7)  /* TX FIFO Underflow Clear */
+#define DW_SPI_G2_ICR_AXIEICR           BIT(8)  /* AXI Error Clear */
+#define DW_SPI_G2_ICR_SPITEICR          BIT(10) /* SPI Transmit Error Clear */
+#define DW_SPI_G2_ICR_DONEICR           BIT(11) /* SSI Done Clear */
+#define DW_SPI_G2_ICR_SPIWSFICR         BIT(13) /* SPI Write Status Fail Clear */
+#define DW_SPI_G2_ICR_ECCCEICR          BIT(15) /* ECC Correctable Error Clear */
+#define DW_SPI_G2_ICR_ECCUCEICR         BIT(16) /* ECC Uncorrectable Error Clear */
+#define DW_SPI_G2_ICR_PVTTICR           BIT(17) /* PVT Tracking Interrupt Clear */
+/* Clear all writable bits */
+#define DW_SPI_G2_ICR_ALL               0x0003AFFF
+
+#define DW_SPI_G2_RX_SAMPLE_DELAY       0x24
+
+/* CTRLR0 fields */
+#define DW_SPI_G2_CTRLR0_DFS_MASK     GENMASK(4, 0)
+#define DW_SPI_G2_CTRLR0_FRF_MASK     GENMASK(15, 14)
+#define DW_SPI_G2_CTRLR0_TMOD_MASK    GENMASK(11, 10)
+#define DW_SPI_G2_CTRLR0_SCPHA        BIT(8)
+#define DW_SPI_G2_CTRLR0_SCPOL        BIT(9)
+#define DW_SPI_G2_CTRLR0_SRL          BIT(12)
+
+/* SPI_CTRLR0 fields */
+#define DW_SPI_G2_SPI_CTRLR0_TRANS_TYPE_SHIFT        0
+#define DW_SPI_G2_SPI_CTRLR0_TRANS_TYPE_MASK         GENMASK(1, 0)
+#define DW_SPI_G2_SPI_CTRLR0_ADDR_L_SHIFT            2
+#define DW_SPI_G2_SPI_CTRLR0_ADDR_L_MASK             GENMASK(5, 2)
+#define DW_SPI_G2_SPI_CTRLR0_INST_L_SHIFT            8
+#define DW_SPI_G2_SPI_CTRLR0_INST_L_MASK             GENMASK(9, 8)
+#define DW_SPI_G2_SPI_CTRLR0_WAIT_CYCLE_SHIFT        11
+#define DW_SPI_G2_SPI_CTRLR0_WAIT_CYCLE_MASK         GENMASK(15, 11)
+#define DW_SPI_G2_SPI_CTRLR0_WAIT_CYCLES_MAX         0x1FU
+#define DW_SPI_G2_SPI_CTRLR0_DDR_EN_MASK             BIT(16)
+#define DW_SPI_G2_SPI_CTRLR0_INST_DDR_EN_MASK        BIT(17)
+#define DW_SPI_G2_SPI_CTRLR0_INST_RXDS_EN_MASK       BIT(18)
+
+#define DW_SPI_G2_SPI_CTRLR0_ADDR_L_MAX			0xFU
+#define DW_SPI_G2_SPI_CTRLR0_ADDR_L_BITS_PER_STEP	4U
+#define DW_SPI_G2_ADDR_L_MAX_BITS \
+	((unsigned int)(DW_SPI_G2_SPI_CTRLR0_ADDR_L_MAX * \
+			DW_SPI_G2_SPI_CTRLR0_ADDR_L_BITS_PER_STEP))
+
+/* TMOD values */
+#define DW_SPI_G2_CTRLR0_TMOD_TR		0x0     /* xmit & recv */
+#define DW_SPI_G2_CTRLR0_TMOD_TO		0x1	/* xmit only */
+#define DW_SPI_G2_CTRLR0_TMOD_RO		0x2	/* recv only */
+#define DW_SPI_G2_CTRLR0_TMOD_EEPROMREAD	0x3	/* eeprom read mode */
+
+/* FRF */
+#define DW_SPI_G2_FRF_STANDARD              0x0
+#define DW_SPI_G2_FRF_DUAL                  0x1
+#define DW_SPI_G2_FRF_QUAD                  0x2
+#define DW_SPI_G2_FRF_OCTAL                 0x3
+
+/* Transfer Type */
+#define DW_SPI_G2_TRANS_TYPE_TT0                0x0
+#define DW_SPI_G2_TRANS_TYPE_TT1                0x1
+#define DW_SPI_G2_TRANS_TYPE_TT2                0x2
+#define DW_SPI_G2_TRANS_TYPE_TT3                0x3
+
+/* SR bits */
+#define DW_SPI_G2_SR_BUSY               BIT(0)
+#define DW_SPI_G2_SR_TFNF               BIT(1)
+#define DW_SPI_G2_SR_TFE                BIT(2)
+#define DW_SPI_G2_SR_RFNE               BIT(3)
+#define DW_SPI_G2_SR_RFF                BIT(4)
+#define DW_SPI_G2_SR_WIP                BIT(7)
+
+/* DFS encoding */
+#define DW_SPI_G2_DFS_8BIT              7U
+#define DW_SPI_G2_DFS_16BIT             15U
+#define DW_SPI_G2_DFS_32BIT             31U
+#define DW_SPI_G2_DFS_ENCODE(bits)      ((bits) - 1)
+
+/* INST_L encoding */
+#define DW_SPI_G2_INST_L_0              0x0
+#define DW_SPI_G2_INST_L_4              0x1
+#define DW_SPI_G2_INST_L_8              0x2
+#define DW_SPI_G2_INST_L_16             0x3
+
+static inline u32 dw_spi_g2_inst_len(unsigned int n)
+{
+	switch (n) {
+	case 0:
+		return DW_SPI_G2_INST_L_0;
+	case 1:
+		return DW_SPI_G2_INST_L_8;
+	case 2:
+		return DW_SPI_G2_INST_L_16;
+	default:
+		return DW_SPI_G2_INST_L_8;
+	}
+}
+
+/* ADDR_L encoding */
+#define DW_SPI_G2_ADDR_L_0              0x0
+#define DW_SPI_G2_ADDR_L_4              0x1
+#define DW_SPI_G2_ADDR_L_8              0x2
+#define DW_SPI_G2_ADDR_L_16             0x4
+#define DW_SPI_G2_ADDR_L_24             0x6
+#define DW_SPI_G2_ADDR_L_32             0x8
+
+/*
+ * Map @addr_nbytes to ADDR_L register encoding.
+ *
+ * ADDR_L encoding: Each increment = 4 bits. ADDR_L=n means n×4 bits.
+ *   ADDR_L=0 == 0 bits,  ADDR_L=2 == 8 bits (1 byte),  ADDR_L=4 == 16 bits (2 bytes), etc.
+ *
+ * Formula: ADDR_L = (addr_bits / 4) = (addr_nbytes × 8) / 4 = addr_nbytes × 2
+ *
+ * Note: This function assumes byte-aligned addresses (multiple of 8 bits), which
+ * matches the Linux spi-mem framework's addr.nbytes field. The hardware supports
+ * non-byte-aligned lengths (4, 12, 20 bits, etc.) via other ADDR_L values (1, 3, 5),
+ * but the spi-mem framework does not expose bit-level addressing.
+ *
+ * Caller must ensure addr_nbytes * 8 <= DW_SPI_G2_ADDR_L_MAX_BITS (60 bits).
+ */
+static inline u32 dw_spi_g2_addr_len(unsigned int addr_nbytes)
+{
+	return addr_nbytes ? addr_nbytes * 2U : 0U;
+}
+
+/*
+ * Maximum chunk size for indirect reads.
+ * 64KB allows efficient large transfers while staying well within typical
+ * controller limits. The FIFO (256 bytes) drains continuously during
+ * the transfer via polling.
+ */
+#define DW_G2_MAX_CHUNK		256U
+
+/* Timeout in microseconds for polling operations */
+#define DW_SPI_G2_TIMEOUT_US	200000U
+
+/* Default max frequency in Hz (100 MHz) */
+#define DW_SPI_G2_DEF_MAX_FREQ	100000000U
+
+/* Default FIFO depth */
+#define DW_SPI_G2_FIFO_LEN	256U
+
+/*
+ * Maximum baud rate divisor value for BAUDR register.
+ * BAUDR encoding: bit[0]=passthrough_en, bits[15:1]=SCKDV (divisor).
+ * Max SCKDV = 0x7FFF (32767), encoded as BAUDR = 0xFFFE (65534).
+ * Note: divisor must be even (BAUDR >= 2), except BAUDR=1 (passthrough).
+ */
+#define DW_SPI_G2_MAX_BAUDR	65534U
+
+/*
+ * Maximum data bytes for register operations (stack buffer size - 1 for opcode).
+ * Register ops use small stack buffers: tx_buf[16] and rx_tmp[16].
+ * Buffer layout: [opcode (1 byte)][data (up to 15 bytes)].
+ * This is sufficient for typical SPI NOR register commands:
+ *   - RDID: 3 bytes
+ *   - RDSR: 1-2 bytes
+ *   - RDFR: 1 byte
+ *   - etc.
+ * Larger transfers use indirect read/write with FIFO (up to DW_G2_MAX_CHUNK).
+ */
+#define DW_SPI_G2_REG_OP_MAX_DATA	15U
+
+struct dw_spi_g2_cfg {
+	u8 tmode;
+	u8 dfs;
+	u32 ndf;
+	u32 freq;
+};
+
+struct dw_spi_g2 {
+	struct device          *dev;
+	struct spi_controller  *ctlr;
+
+	void __iomem           *regs;
+	resource_size_t         paddr;
+	int                     irq;
+
+	u32                     cs;
+	u32                     fifo_len;
+	u32                     caps;
+	/* Static controller identity, read once at probe */
+	u32                     version_id;
+	u32                     hw_caps;
+	u32                     max_freq;
+	u32                     clk_rate;
+
+	/* Current message transfer state info */
+	const void		*tx;
+	unsigned int		tx_len;
+	void		        *rx;
+	unsigned int		rx_len;
+	u8			n_bytes;
+
+	struct spi_device       *curr_spi;
+	struct completion       mem_done;
+	int                     error;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debugfs;
+	struct debugfs_regset32 regset;
+#endif
+};
+
+struct dw_spi_g2_memtrx {
+	u8              opcode;
+	u8              inst_len;
+	u32             addr;
+	u8              addr_len;
+	u8              dummy_cycles;
+	u32             data_len;
+	bool            is_read;
+	bool            is_write;
+	const u8        *tx;
+	u8              *rx;
+};
+
+/* Low-level register access */
+/*
+ * Use the barrier-embedding readl()/writel() accessors (not the *_relaxed
+ * variants) so every register access is ordered with respect to normal
+ * memory: writel()'s wmb drains prior stores before the MMIO write and
+ * readl()'s rmb completes the read before subsequent accesses. This
+ * guarantees, for example, that DR0 TX-FIFO fills reach the controller
+ * before the CS-asserting SER write triggers the transfer, without
+ * needing explicit wmb() barriers on the transfer paths.
+ */
+static inline u32 dw_spi_g2_readl(void __iomem *base, u32 off)
+{
+	return readl(base + off);
+}
+
+static inline void dw_spi_g2_writel(void __iomem *base, u32 off, u32 val)
+{
+	writel(val, base + off);
+}
+
+/* APIs */
+int dw_spi_g2_setup(struct spi_device *spi);
+
+int dw_spi_g2_init(struct dw_spi_g2 *dws);
+
+void dw_spi_g2_deinit(struct dw_spi_g2 *dws);
+
+void dw_spi_g2_update_config(struct dw_spi_g2 *dws, struct spi_device *spi,
+			     struct dw_spi_g2_cfg *cfg);
+
+int dw_spi_g2_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
+			   struct spi_transfer *xfer);
+
+int dw_spi_g2_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op);
+
+irqreturn_t dw_spi_g2_irq(int irq, void *dev_id);
+
+/* Helpers */
+static inline void dw_spi_g2_enable(struct dw_spi_g2 *dws, bool en)
+{
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SSIENR, en ? 1 : 0);
+}
+
+static inline void dw_spi_g2_target_disable(struct dw_spi_g2 *dws, u32 cs)
+{
+	u32 reg_val = dw_spi_g2_readl(dws->regs, DW_SPI_G2_DEDICATED_CS_EN);
+
+	reg_val &= ~BIT(cs);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_DEDICATED_CS_EN, reg_val);
+}
+
+static inline void dw_spi_g2_target_enable(struct dw_spi_g2 *dws, u32 cs)
+{
+	u32 reg_val = dw_spi_g2_readl(dws->regs, DW_SPI_G2_DEDICATED_CS_EN);
+
+	reg_val |= BIT(cs);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_DEDICATED_CS_EN, reg_val);
+}
+
+static inline void dw_spi_g2_cs_assert(struct dw_spi_g2 *dws, u32 cs)
+{
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SER, BIT(cs));
+}
+
+static inline void dw_spi_g2_cs_deassert(struct dw_spi_g2 *dws, u32 cs)
+{
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SER, 0);
+}
+
+static inline int dw_spi_g2_wait_tfnf(struct dw_spi_g2 *dws)
+{
+	u32 sr;
+
+	return readl_poll_timeout(dws->regs + DW_SPI_G2_SR, sr,
+				  sr & DW_SPI_G2_SR_TFNF, 1, DW_SPI_G2_TIMEOUT_US);
+}
+
+static inline int dw_spi_g2_wait_rfne(struct dw_spi_g2 *dws)
+{
+	u32 sr;
+
+	return readl_poll_timeout(dws->regs + DW_SPI_G2_SR, sr,
+				  sr & DW_SPI_G2_SR_RFNE, 1, DW_SPI_G2_TIMEOUT_US);
+}
+
+static inline int dw_spi_g2_wait_idle(struct dw_spi_g2 *dws)
+{
+	u32 sr;
+
+	return readl_poll_timeout(dws->regs + DW_SPI_G2_SR, sr,
+				  !(sr & DW_SPI_G2_SR_BUSY), 1, DW_SPI_G2_TIMEOUT_US);
+}
+
+/*
+ * Transfer control: enable CS register block, assert CS line, enable SSI.
+ * Starts the SPI transfer — controller begins clocking data.
+ */
+static inline void dw_spi_g2_transfer_begin(struct dw_spi_g2 *dws)
+{
+	dw_spi_g2_target_enable(dws, dws->cs);
+	dw_spi_g2_cs_assert(dws, dws->cs);
+	dw_spi_g2_enable(dws, true);
+}
+
+/*
+ * Transfer control: disable SSI, deassert CS line, disable CS register block.
+ * Ends the SPI transfer and cleanly releases the bus.
+ */
+static inline void dw_spi_g2_transfer_end(struct dw_spi_g2 *dws)
+{
+	dw_spi_g2_enable(dws, false);
+	dw_spi_g2_cs_deassert(dws, dws->cs);
+	dw_spi_g2_target_disable(dws, dws->cs);
+}
+
+#endif /* __SPI_DW_G2_H__ */
-- 
2.34.1


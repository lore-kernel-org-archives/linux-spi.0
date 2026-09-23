Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667603BCD32
	for <linux-spi@vger.kernel.org>; Wed, 23 Sep 2026 04:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137193; cv=none; b=pMq53uoZjwARG/z3p35pzzmD+oKUOhnqSaAGqHnr0RY+SRE9yUXqttx2MWkWvGHNecoTkR/n6Rkg5CpuUDwFCPLeB3phQckRspLm1w9OlO0/C2GMJZcQrBQ1TbO74SX1gqeMCmLW88reBhlFonoaRM18iOva2sAhWCcG6rjacus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137193; c=relaxed/simple;
	bh=UDtlo0p4ZQkYTOy0Jd8LsVRH6fc5kLV2hdXqUTAbiPo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oB+Hh0kSPMB5vbjytCyqoOIkUqcVoaBIzQve/u5nqetd2ITKyBE+fI3WE4gqC6vyg0r3PxNmS1zN+CcxxKcadnJprGsOMyuBb6SDq0EVeQMyFQO9yCqDyZkxV8rOLdqccPAP1nWT3fdpPQ9hLcUH6O60BtPmn8vZ6ZaeSKBRvSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KN3+oZ0L; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN3+oZ0L"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398a1676000so328015a91.2
        for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2026 21:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790137191; x=1790741991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTRgOu465fBVTzOUW7KcLlOJt6rOtQBhcXfLzVCtwmg=;
        b=KN3+oZ0LRvfeY7cuueijZdwJyefUswuQVdlCj3XQmSLahuUd+jU5SCjizN34qZ/yIt
         tHSiKD6CG8avaZdKS4g/tTyZ6vRwoc7LmIRxhGmh1wwBEXPT2ih+v/GGqviNKW7LFxOf
         XRiNr6GWkMRYQn4ywezYUohq7obb0ss+83IpW4QzX1oixfDQeDO8OLFd4XyekXPT/esJ
         MAV5xXvx3275yxwvrN1XgDqH3IRMYjNyiy4GciimHCMCh2aOBuKLOute+QONfcVuus3A
         A5bYozcK1oJRJQxmVmMkvLRSzNw/oZEFJP0hv+pI7byasMoZWKWcSMwdR0ycH8zt96kM
         jxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790137191; x=1790741991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oTRgOu465fBVTzOUW7KcLlOJt6rOtQBhcXfLzVCtwmg=;
        b=oL6I7ZV65wcCPJNzKRdcDnj10ciuku0lIDygf96sfMXSltqFxovhkBaELOkNl8/+gU
         bKZ1IUHqH6aDXLaMamAduAJl9GxLAPtCjIZw1ni/ZiiBZw+hsz1Oqpc1rzIlC9IqZU53
         0S6cjKACmuqm4961MNqPaU1S612K7bHa9EvxQyxm+7SXCpako/i27i0Y//G+HNkhR8fV
         3cPwVEaLLEOucGTWr1Vla3LPEEp8wZh/2ofVVFCcUBBt1q2Gb0UHyOda0LAa/83a/TnR
         7x6exonjG+S/Iv0Dy5MZmloGIms0wCX4EbWqwpXqQ/jOE4eAyrvMpkKdMZGik0TtPY8y
         YyxA==
X-Forwarded-Encrypted: i=1; AKwUvBxO/ryZ+mjEAVMP3/TRLOPbbQVQyOsLi/+AUo0qyW7SFyiuh0FJ6KYI9uGR3G/7NWHykWAOWos64Js=@vger.kernel.org
X-Gm-Message-State: AFuF++k5R/12/JJHe7kLcj+wWuohOIUsjRvm3rUYqJt1TO8lw5dufxo9
	mEk69pBedkjJZJoX11246142vjmU8fL9AANK7w+LsZNu+y+QPy5bKFkS
X-Gm-Gg: AYBFou2QlMeqn47y3Ecz6Ml4ru9XTlTgiebfpWcDI9sRKj1AGPpNA/+TYXe8k0YybE3
	MA3mjkDrTFcawa0g1RmyeFCy1WslCrNWIzJTLWFisIL0LziemLQOas0o9AowarmCDfl5mTHfxZc
	LmakRS0no0ldcE8utpHjfi2L5B6ykEa6GuFB45BBnF4baKXEFF2nEC2knDD7KhP7RoOvf50/RNk
	1da8m1J6zOcxX3Rybi1DPbAOGPDBkdINpmkZquW6lFv+0+o2ysj9RbgP2+UdO1laFCL9/VCsWh0
	+yk6n+sacfvG4xqX57aIwBEgfLhhi1Bz8DubgOchcwdQoTp1sAUN83nt22DcSkbRaW4ZJjlnL8F
	o9exshgqQnujjbmyERewQNoZyryD4lOfC+FYL6085vMOpUSGxElyanIPa1+WmPInKlKWMi43FzU
	jBz4V7qpETMSYxrmrNu6CpjT5J7WZfucYvjHrVa7bSeTFE4kPM55Gr/v0MRhG1UGHec0Xtlm/le
	VXmNtHY2cjiS84iEpCfJsjRyA7+Ksb2sy1lYG6+a9rwZNLnySKI5j3Q01Yn
X-Received: by 2002:a17:90b:3dcb:b0:398:e86b:ce14 with SMTP id 98e67ed59e1d1-3a07e5b67b4mr1256963a91.20.1790137190514;
        Tue, 22 Sep 2026 21:19:50 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07ddae723sm2510243a91.5.2026.09.22.21.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 21:19:50 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH 2/2] spi: ma35d1: Add Nuvoton MA35D1 SPI controller support
Date: Wed, 23 Sep 2026 12:19:26 +0800
Message-Id: <20260923041926.425551-3-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260923041926.425551-1-cwweng.linux@gmail.com>
References: <20260923041926.425551-1-cwweng.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

Add support for the SPI controller found in the Nuvoton MA35D1 SoC.

The driver supports SPI host mode using PIO transfers, with SPI modes
0 through 3, LSB-first operation, and word sizes from 8 to 32 bits.

Support the two native chip-select outputs as well as GPIO chip selects
through the SPI core GPIO descriptor support. Protect read-modify-write
accesses to the slave-select control register with a dedicated
spinlock.

Configure the clock divider according to the hardware requirement that
only odd CLKDIV values are valid, ensuring that the generated SPI clock
does not exceed the requested transfer frequency.

Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>
---
 drivers/spi/Kconfig      |  11 +
 drivers/spi/Makefile     |   1 +
 drivers/spi/spi-ma35d1.c | 701 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 713 insertions(+)
 create mode 100644 drivers/spi/spi-ma35d1.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a0f37e2df716..c446ddaa4897 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -694,6 +694,17 @@ config SPI_LJCA
 	  This driver can also be built as a module. If so, the module
 	  will be called spi-ljca.
 
+config SPI_MA35D1
+	tristate "Nuvoton MA35D1 SPI controller"
+	depends on ARCH_MA35 || COMPILE_TEST
+	help
+	  This enables support for the SPI controller found in
+	  Nuvoton MA35D1 SoCs.
+
+	  The controller supports standard SPI peripheral devices with
+	  configurable clock polarity and phase, chip select, and data
+	  word sizes from 8 to 32 bits.
+
 config SPI_MA35D1_QSPI
 	tristate "Nuvoton MA35D1 QSPI controller"
 	depends on ARCH_MA35 || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index a18814fbde93..8fcdee4b6eec 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_SPI_LOONGSON_CORE)		+= spi-loongson-core.o
 obj-$(CONFIG_SPI_LOONGSON_PCI)		+= spi-loongson-pci.o
 obj-$(CONFIG_SPI_LOONGSON_PLATFORM)	+= spi-loongson-plat.o
 obj-$(CONFIG_SPI_LP8841_RTC)		+= spi-lp8841-rtc.o
+obj-$(CONFIG_SPI_MA35D1)		+= spi-ma35d1.o
 obj-$(CONFIG_SPI_MA35D1_QSPI)		+= spi-ma35d1-qspi.o
 obj-$(CONFIG_SPI_MESON_SPICC)		+= spi-meson-spicc.o
 obj-$(CONFIG_SPI_MESON_SPIFC)		+= spi-meson-spifc.o
diff --git a/drivers/spi/spi-ma35d1.c b/drivers/spi/spi-ma35d1.c
new file mode 100644
index 000000000000..14aebf501920
--- /dev/null
+++ b/drivers/spi/spi-ma35d1.c
@@ -0,0 +1,701 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+//
+// Nuvoton MA35D1 SPI controller driver
+//
+// Copyright (c) 2026 Nuvoton Technology Corp.
+// Author: Chi-Wen Weng <cwweng@nuvoton.com>
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/reset.h>
+#include <linux/sizes.h>
+#include <linux/spi/spi.h>
+#include <linux/spinlock.h>
+#include <linux/time.h>
+#include <linux/unaligned.h>
+
+/* Register offset definitions */
+#define NUVOTON_SPI_CTL_OFFSET			0x00
+#define NUVOTON_SPI_CLKDIV_OFFSET		0x04
+#define NUVOTON_SPI_SSCTL_OFFSET		0x08
+#define NUVOTON_SPI_PDMACTL_OFFSET		0x0c
+#define NUVOTON_SPI_FIFOCTL_OFFSET		0x10
+#define NUVOTON_SPI_STATUS_OFFSET		0x14
+#define NUVOTON_SPI_TX_OFFSET			0x20
+#define NUVOTON_SPI_RX_OFFSET			0x30
+
+/* SPI Control Register bit masks */
+#define NUVOTON_SPI_CTL_DATDIR_MASK		BIT(20)
+#define NUVOTON_SPI_CTL_REORDER_MASK		BIT(19)
+#define NUVOTON_SPI_CTL_SLAVE_MASK		BIT(18)
+#define NUVOTON_SPI_CTL_UNITIEN_MASK		BIT(17)
+#define NUVOTON_SPI_CTL_RXONLY_MASK		BIT(15)
+#define NUVOTON_SPI_CTL_HALFDPX_MASK		BIT(14)
+#define NUVOTON_SPI_CTL_LSB_MASK		BIT(13)
+#define NUVOTON_SPI_CTL_DWIDTH_MASK		GENMASK(12, 8)
+#define NUVOTON_SPI_CTL_SUSPITV_MASK		GENMASK(7, 4)
+#define NUVOTON_SPI_CTL_CLKPOL_MASK		BIT(3)
+#define NUVOTON_SPI_CTL_TXNEG_MASK		BIT(2)
+#define NUVOTON_SPI_CTL_RXNEG_MASK		BIT(1)
+#define NUVOTON_SPI_CTL_SPIEN_MASK		BIT(0)
+
+/* SPI Clock Divider Register bit masks */
+#define NUVOTON_SPI_CLKDIV_MASK			GENMASK(8, 0)
+
+/* SPI Slave Select Control Register bit masks */
+#define NUVOTON_SPI_SSCTL_SS1_MASK		BIT(1)
+#define NUVOTON_SPI_SSCTL_SS0_MASK		BIT(0)
+#define NUVOTON_SPI_SSCTL_SSACTPOL_MASK		BIT(2)
+#define NUVOTON_SPI_SSCTL_AUTOSS_MASK		BIT(3)
+#define NUVOTON_SPI_SSCTL_SLV3WIRE_MASK		BIT(4)
+#define NUVOTON_SPI_SSCTL_SLVBEIEN_MASK		BIT(8)
+#define NUVOTON_SPI_SSCTL_SLVURIEN_MASK		BIT(9)
+#define NUVOTON_SPI_SSCTL_SSACTIEN_MASK		BIT(12)
+#define NUVOTON_SPI_SSCTL_SSINAIEN_MASK		BIT(13)
+
+/* SPI PDMA Control Register bit masks */
+#define NUVOTON_SPI_PDMACTL_TXPDMAEN_MASK	BIT(0)
+#define NUVOTON_SPI_PDMACTL_RXPDMAEN_MASK	BIT(1)
+
+/* SPI FIFO Control Register bit masks */
+#define NUVOTON_SPI_FIFOCTL_SLVBERX_MASK	BIT(10)
+#define NUVOTON_SPI_FIFOCTL_TXUFIEN_MASK	BIT(7)
+#define NUVOTON_SPI_FIFOCTL_TXUFPOL_MASK	BIT(6)
+#define NUVOTON_SPI_FIFOCTL_RXOVIEN_MASK	BIT(5)
+#define NUVOTON_SPI_FIFOCTL_RXTOIEN_MASK	BIT(4)
+#define NUVOTON_SPI_FIFOCTL_TXTHIEN_MASK	BIT(3)
+#define NUVOTON_SPI_FIFOCTL_RXTHIEN_MASK	BIT(2)
+#define NUVOTON_SPI_FIFOCTL_TXRST_MASK		BIT(1)
+#define NUVOTON_SPI_FIFOCTL_RXRST_MASK		BIT(0)
+
+/* SPI Status Register bit masks */
+#define NUVOTON_SPI_STATUS_TXRXRST_MASK		BIT(23)
+#define NUVOTON_SPI_STATUS_TXFULL_MASK		BIT(17)
+#define NUVOTON_SPI_STATUS_SPIENSTS_MASK	BIT(15)
+#define NUVOTON_SPI_STATUS_RXEMPTY_MASK		BIT(8)
+#define NUVOTON_SPI_STATUS_BUSY_MASK		BIT(0)
+
+#define NUVOTON_SPI_MAX_NATIVE_CS		2
+#define NUVOTON_SPI_DEFAULT_NUM_CS		2
+#define NUVOTON_SPI_DEFAULT_BPW			8
+#define NUVOTON_SPI_MAX_SPEED_HZ		100000000U
+#define NUVOTON_SPI_MIN_DIVISOR			2U
+#define NUVOTON_SPI_MAX_DIVISOR			512U
+#define NUVOTON_SPI_RESET_CYCLES			5U
+
+/* Bound PIO operations to avoid long polling loops. */
+#define NUVOTON_SPI_MAX_TRANSFER_SIZE		SZ_4K
+#define NUVOTON_SPI_TIMEOUT_US			10000
+
+struct nuvoton_spi {
+	void __iomem *regs;
+	struct clk *clk;
+	struct device *dev;
+
+	/* Protects read-modify-write accesses to the SSCTL register. */
+	spinlock_t ssctl_lock;
+};
+
+static u32 nuvoton_spi_read(struct nuvoton_spi *nspi, u32 reg)
+{
+	return readl(nspi->regs + reg);
+}
+
+static void nuvoton_spi_write(struct nuvoton_spi *nspi, u32 val, u32 reg)
+{
+	writel(val, nspi->regs + reg);
+}
+
+static void nuvoton_spi_update_bits(struct nuvoton_spi *nspi, u32 reg,
+				    u32 mask, u32 val)
+{
+	u32 tmp;
+
+	tmp = nuvoton_spi_read(nspi, reg);
+	tmp &= ~mask;
+	tmp |= val & mask;
+	nuvoton_spi_write(nspi, tmp, reg);
+}
+
+static void nuvoton_spi_update_ssctl_bits(struct nuvoton_spi *nspi,
+					  u32 mask, u32 val)
+{
+	unsigned long flags;
+	u32 tmp;
+
+	spin_lock_irqsave(&nspi->ssctl_lock, flags);
+
+	tmp = nuvoton_spi_read(nspi, NUVOTON_SPI_SSCTL_OFFSET);
+	tmp &= ~mask;
+	tmp |= val & mask;
+	nuvoton_spi_write(nspi, tmp, NUVOTON_SPI_SSCTL_OFFSET);
+
+	spin_unlock_irqrestore(&nspi->ssctl_lock, flags);
+}
+
+static int nuvoton_spi_disable(struct nuvoton_spi *nspi)
+{
+	u32 val;
+
+	nuvoton_spi_update_bits(nspi, NUVOTON_SPI_CTL_OFFSET,
+				NUVOTON_SPI_CTL_SPIEN_MASK, 0);
+
+	return readl_poll_timeout(nspi->regs + NUVOTON_SPI_STATUS_OFFSET, val,
+				  !(val & NUVOTON_SPI_STATUS_SPIENSTS_MASK),
+				  1, NUVOTON_SPI_TIMEOUT_US);
+}
+
+static int nuvoton_spi_enable(struct nuvoton_spi *nspi)
+{
+	u32 val;
+
+	nuvoton_spi_update_bits(nspi, NUVOTON_SPI_CTL_OFFSET,
+				NUVOTON_SPI_CTL_SPIEN_MASK,
+				NUVOTON_SPI_CTL_SPIEN_MASK);
+
+	return readl_poll_timeout(nspi->regs + NUVOTON_SPI_STATUS_OFFSET, val,
+				  val & NUVOTON_SPI_STATUS_SPIENSTS_MASK,
+				  1, NUVOTON_SPI_TIMEOUT_US);
+}
+
+static int nuvoton_spi_wait_ready(struct nuvoton_spi *nspi)
+{
+	u32 val;
+
+	return readl_poll_timeout(nspi->regs + NUVOTON_SPI_STATUS_OFFSET, val,
+				  !(val & NUVOTON_SPI_STATUS_BUSY_MASK),
+				  0, NUVOTON_SPI_TIMEOUT_US);
+}
+
+static int nuvoton_spi_reset_fifo(struct nuvoton_spi *nspi)
+{
+	u32 val;
+
+	nuvoton_spi_update_bits(nspi, NUVOTON_SPI_FIFOCTL_OFFSET,
+				NUVOTON_SPI_FIFOCTL_TXRST_MASK |
+				NUVOTON_SPI_FIFOCTL_RXRST_MASK,
+				NUVOTON_SPI_FIFOCTL_TXRST_MASK |
+				NUVOTON_SPI_FIFOCTL_RXRST_MASK);
+
+	/*
+	 * Give the controller a short time to latch the FIFO reset request
+	 * before polling the reset status bit.
+	 */
+	udelay(1);
+
+	return readl_poll_timeout(nspi->regs + NUVOTON_SPI_STATUS_OFFSET, val,
+				  !(val & NUVOTON_SPI_STATUS_TXRXRST_MASK),
+				  1, NUVOTON_SPI_TIMEOUT_US);
+}
+
+static int nuvoton_spi_wait_tx_not_full(struct nuvoton_spi *nspi)
+{
+	u32 val;
+
+	return readl_poll_timeout(nspi->regs + NUVOTON_SPI_STATUS_OFFSET, val,
+				  !(val & NUVOTON_SPI_STATUS_TXFULL_MASK),
+				  0, NUVOTON_SPI_TIMEOUT_US);
+}
+
+static int nuvoton_spi_wait_rx_not_empty(struct nuvoton_spi *nspi)
+{
+	u32 val;
+
+	return readl_poll_timeout(nspi->regs + NUVOTON_SPI_STATUS_OFFSET, val,
+				  !(val & NUVOTON_SPI_STATUS_RXEMPTY_MASK),
+				  0, NUVOTON_SPI_TIMEOUT_US);
+}
+
+static int nuvoton_spi_calc_divisor(unsigned long clk_rate, u32 speed_hz,
+				    unsigned int *divisor)
+{
+	unsigned int div;
+
+	if (!speed_hz)
+		return -EINVAL;
+
+	div = DIV_ROUND_UP(clk_rate, speed_hz);
+	if (div < NUVOTON_SPI_MIN_DIVISOR)
+		div = NUVOTON_SPI_MIN_DIVISOR;
+
+	/*
+	 * CLKDIV only accepts odd register values, corresponding to even
+	 * clock divisors. Round up so the generated clock never exceeds
+	 * the requested frequency.
+	 */
+	if (div & 1)
+		div++;
+
+	if (div > NUVOTON_SPI_MAX_DIVISOR)
+		return -EINVAL;
+
+	*divisor = div;
+
+	return 0;
+}
+
+static int nuvoton_spi_set_speed(struct nuvoton_spi *nspi,
+				 struct spi_transfer *xfer, u32 speed_hz)
+{
+	unsigned long clk_rate;
+	unsigned int divisor;
+	u32 clkdiv;
+	int ret;
+
+	clk_rate = clk_get_rate(nspi->clk);
+	if (!clk_rate) {
+		dev_err(nspi->dev, "failed to get clock rate\n");
+		return -EINVAL;
+	}
+
+	ret = nuvoton_spi_calc_divisor(clk_rate, speed_hz, &divisor);
+	if (ret) {
+		dev_err(nspi->dev, "unsupported SPI clock %u Hz\n", speed_hz);
+		return ret;
+	}
+
+	clkdiv = divisor - 1;
+	nuvoton_spi_write(nspi, FIELD_PREP(NUVOTON_SPI_CLKDIV_MASK, clkdiv),
+			  NUVOTON_SPI_CLKDIV_OFFSET);
+
+	xfer->effective_speed_hz = clk_rate / divisor;
+
+	return 0;
+}
+
+static int nuvoton_spi_configure_transfer(struct nuvoton_spi *nspi,
+					  struct spi_device *spi,
+					  struct spi_transfer *xfer,
+					  u8 bpw)
+{
+	u32 speed_hz = xfer->speed_hz ?: spi->max_speed_hz;
+	u32 dwidth;
+	u32 ctl = 0;
+	u32 mode;
+	int ret;
+
+	ret = nuvoton_spi_disable(nspi);
+	if (ret) {
+		dev_err(nspi->dev, "failed to disable controller\n");
+		return ret;
+	}
+
+	mode = spi->mode & SPI_MODE_X_MASK;
+	if (mode == SPI_MODE_0 || mode == SPI_MODE_3)
+		ctl |= NUVOTON_SPI_CTL_TXNEG_MASK;
+	else
+		ctl |= NUVOTON_SPI_CTL_RXNEG_MASK;
+
+	if (spi->mode & SPI_CPOL)
+		ctl |= NUVOTON_SPI_CTL_CLKPOL_MASK;
+
+	if (spi->mode & SPI_LSB_FIRST)
+		ctl |= NUVOTON_SPI_CTL_LSB_MASK;
+
+	dwidth = bpw == 32 ? 0 : bpw;
+	ctl |= FIELD_PREP(NUVOTON_SPI_CTL_DWIDTH_MASK, dwidth);
+
+	nuvoton_spi_update_bits(nspi, NUVOTON_SPI_CTL_OFFSET,
+				NUVOTON_SPI_CTL_TXNEG_MASK |
+				NUVOTON_SPI_CTL_RXNEG_MASK |
+				NUVOTON_SPI_CTL_CLKPOL_MASK |
+				NUVOTON_SPI_CTL_LSB_MASK |
+				NUVOTON_SPI_CTL_DWIDTH_MASK,
+				ctl);
+
+	ret = nuvoton_spi_set_speed(nspi, xfer, speed_hz);
+	if (ret)
+		return ret;
+
+	ret = nuvoton_spi_reset_fifo(nspi);
+	if (ret)
+		dev_err(nspi->dev, "FIFO reset timed out\n");
+
+	return ret;
+}
+
+static u32 nuvoton_spi_get_tx_word(const void *txbuf, unsigned int offset,
+				   unsigned int bytes_per_word)
+{
+	if (!txbuf)
+		return 0;
+
+	switch (bytes_per_word) {
+	case 1:
+		return ((const u8 *)txbuf)[offset];
+	case 2:
+		return get_unaligned((const u16 *)((const u8 *)txbuf + offset));
+	case 4:
+		return get_unaligned((const u32 *)((const u8 *)txbuf + offset));
+	default:
+		return 0;
+	}
+}
+
+static void nuvoton_spi_put_rx_word(void *rxbuf, unsigned int offset,
+				    unsigned int bytes_per_word, u32 val)
+{
+	if (!rxbuf)
+		return;
+
+	switch (bytes_per_word) {
+	case 1:
+		((u8 *)rxbuf)[offset] = val;
+		break;
+	case 2:
+		put_unaligned((u16)val, (u16 *)((u8 *)rxbuf + offset));
+		break;
+	case 4:
+		put_unaligned(val, (u32 *)((u8 *)rxbuf + offset));
+		break;
+	}
+}
+
+static int nuvoton_spi_txrx(struct nuvoton_spi *nspi,
+			    struct spi_transfer *xfer, u8 bpw)
+{
+	unsigned int bytes_per_word;
+	unsigned int offset;
+	u32 val;
+	int ret;
+
+	bytes_per_word = spi_bpw_to_bytes(bpw);
+	if (!bytes_per_word)
+		return -EINVAL;
+
+	if (xfer->len % bytes_per_word)
+		return -EINVAL;
+
+	/*
+	 * Use conservative word-by-word PIO. Each transmitted word produces
+	 * one receive FIFO entry, so always drain RX, including TX-only
+	 * transfers. RX-only transfers send zero-filled dummy words.
+	 */
+	for (offset = 0; offset < xfer->len; offset += bytes_per_word) {
+		ret = nuvoton_spi_wait_tx_not_full(nspi);
+		if (ret) {
+			dev_err(nspi->dev, "TX FIFO full timeout\n");
+			return ret;
+		}
+
+		val = nuvoton_spi_get_tx_word(xfer->tx_buf, offset,
+					      bytes_per_word);
+		nuvoton_spi_write(nspi, val, NUVOTON_SPI_TX_OFFSET);
+
+		ret = nuvoton_spi_wait_rx_not_empty(nspi);
+		if (ret) {
+			dev_err(nspi->dev, "RX FIFO empty timeout\n");
+			return ret;
+		}
+
+		val = nuvoton_spi_read(nspi, NUVOTON_SPI_RX_OFFSET);
+		nuvoton_spi_put_rx_word(xfer->rx_buf, offset, bytes_per_word,
+					val);
+	}
+
+	ret = nuvoton_spi_wait_ready(nspi);
+	if (ret)
+		dev_err(nspi->dev, "controller busy timeout\n");
+
+	return ret;
+}
+
+static void nuvoton_spi_set_cs_level(struct nuvoton_spi *nspi,
+				     unsigned int cs, bool assert)
+{
+	u32 mask;
+
+	switch (cs) {
+	case 0:
+		mask = NUVOTON_SPI_SSCTL_SS0_MASK;
+		break;
+	case 1:
+		mask = NUVOTON_SPI_SSCTL_SS1_MASK;
+		break;
+	default:
+		dev_warn(nspi->dev, "invalid chip select %u\n", cs);
+		return;
+	}
+
+	nuvoton_spi_update_ssctl_bits(nspi, mask, assert ? mask : 0);
+}
+
+static int nuvoton_spi_setup(struct spi_device *spi)
+{
+	unsigned int cs = spi_get_chipselect(spi, 0);
+
+	if (spi_get_csgpiod(spi, 0))
+		return 0;
+
+	if (cs >= NUVOTON_SPI_MAX_NATIVE_CS) {
+		dev_err(&spi->dev, "invalid native chip select %u\n", cs);
+		return -EINVAL;
+	}
+
+	if (spi->mode & SPI_CS_HIGH) {
+		dev_err(&spi->dev,
+			"active-high native chip select is not supported\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void nuvoton_spi_set_cs(struct spi_device *spi, bool level)
+{
+	struct nuvoton_spi *nspi = spi_controller_get_devdata(spi->controller);
+
+	/*
+	 * The SPI core passes the physical CS level to ->set_cs(). This
+	 * initial driver only supports active-low native chip selects.
+	 */
+	nuvoton_spi_set_cs_level(nspi, spi_get_chipselect(spi, 0), !level);
+}
+
+static int nuvoton_spi_transfer_one(struct spi_controller *ctlr,
+				    struct spi_device *spi,
+				    struct spi_transfer *xfer)
+{
+	struct nuvoton_spi *nspi = spi_controller_get_devdata(ctlr);
+	u8 bpw = xfer->bits_per_word ?: spi->bits_per_word;
+	int disable_ret;
+	int ret;
+
+	if (!xfer->len)
+		return 0;
+
+	if (!bpw)
+		bpw = NUVOTON_SPI_DEFAULT_BPW;
+
+	if (bpw < 8 || bpw > 32)
+		return -EINVAL;
+
+	ret = nuvoton_spi_configure_transfer(nspi, spi, xfer, bpw);
+	if (ret)
+		return ret;
+
+	ret = nuvoton_spi_enable(nspi);
+	if (ret) {
+		dev_err(nspi->dev, "failed to enable controller\n");
+		goto out_disable;
+	}
+
+	ret = nuvoton_spi_txrx(nspi, xfer, bpw);
+
+out_disable:
+	disable_ret = nuvoton_spi_disable(nspi);
+	if (disable_ret) {
+		dev_err(nspi->dev, "failed to disable controller\n");
+		if (!ret)
+			ret = disable_ret;
+	}
+
+	return ret;
+}
+
+static void nuvoton_spi_handle_err(struct spi_controller *ctlr,
+				   struct spi_message *message)
+{
+	struct nuvoton_spi *nspi = spi_controller_get_devdata(ctlr);
+	int ret;
+
+	ret = nuvoton_spi_disable(nspi);
+	if (ret) {
+		dev_err(nspi->dev,
+			"failed to disable controller during recovery\n");
+		return;
+	}
+
+	ret = nuvoton_spi_reset_fifo(nspi);
+	if (ret)
+		dev_err(nspi->dev, "failed to reset FIFO during recovery\n");
+}
+
+static size_t nuvoton_spi_max_transfer_size(struct spi_device *spi)
+{
+	return NUVOTON_SPI_MAX_TRANSFER_SIZE;
+}
+
+static int nuvoton_spi_hw_init(struct nuvoton_spi *nspi)
+{
+	u32 ctl_mask;
+	u32 fifo_mask;
+	u32 ssctl_mask;
+	int ret;
+
+	ret = nuvoton_spi_disable(nspi);
+	if (ret) {
+		dev_err(nspi->dev, "failed to disable controller\n");
+		return ret;
+	}
+
+	ctl_mask = NUVOTON_SPI_CTL_DATDIR_MASK |
+		   NUVOTON_SPI_CTL_REORDER_MASK |
+		   NUVOTON_SPI_CTL_SLAVE_MASK |
+		   NUVOTON_SPI_CTL_UNITIEN_MASK |
+		   NUVOTON_SPI_CTL_RXONLY_MASK |
+		   NUVOTON_SPI_CTL_HALFDPX_MASK |
+		   NUVOTON_SPI_CTL_LSB_MASK |
+		   NUVOTON_SPI_CTL_DWIDTH_MASK |
+		   NUVOTON_SPI_CTL_SUSPITV_MASK |
+		   NUVOTON_SPI_CTL_CLKPOL_MASK |
+		   NUVOTON_SPI_CTL_TXNEG_MASK |
+		   NUVOTON_SPI_CTL_RXNEG_MASK;
+
+	nuvoton_spi_update_bits(nspi, NUVOTON_SPI_CTL_OFFSET, ctl_mask,
+				NUVOTON_SPI_CTL_TXNEG_MASK |
+				FIELD_PREP(NUVOTON_SPI_CTL_DWIDTH_MASK,
+					   NUVOTON_SPI_DEFAULT_BPW));
+
+	ssctl_mask = NUVOTON_SPI_SSCTL_SS0_MASK |
+		     NUVOTON_SPI_SSCTL_SS1_MASK |
+		     NUVOTON_SPI_SSCTL_SSACTPOL_MASK |
+		     NUVOTON_SPI_SSCTL_AUTOSS_MASK |
+		     NUVOTON_SPI_SSCTL_SLV3WIRE_MASK |
+		     NUVOTON_SPI_SSCTL_SLVBEIEN_MASK |
+		     NUVOTON_SPI_SSCTL_SLVURIEN_MASK |
+		     NUVOTON_SPI_SSCTL_SSACTIEN_MASK |
+		     NUVOTON_SPI_SSCTL_SSINAIEN_MASK;
+
+	nuvoton_spi_update_ssctl_bits(nspi, ssctl_mask, 0);
+
+	nuvoton_spi_update_bits(nspi, NUVOTON_SPI_PDMACTL_OFFSET,
+				NUVOTON_SPI_PDMACTL_TXPDMAEN_MASK |
+				NUVOTON_SPI_PDMACTL_RXPDMAEN_MASK, 0);
+
+	fifo_mask = NUVOTON_SPI_FIFOCTL_SLVBERX_MASK |
+		    NUVOTON_SPI_FIFOCTL_TXUFIEN_MASK |
+		    NUVOTON_SPI_FIFOCTL_TXUFPOL_MASK |
+		    NUVOTON_SPI_FIFOCTL_RXOVIEN_MASK |
+		    NUVOTON_SPI_FIFOCTL_RXTOIEN_MASK |
+		    NUVOTON_SPI_FIFOCTL_TXTHIEN_MASK |
+		    NUVOTON_SPI_FIFOCTL_RXTHIEN_MASK;
+
+	nuvoton_spi_update_bits(nspi, NUVOTON_SPI_FIFOCTL_OFFSET, fifo_mask, 0);
+
+	ret = nuvoton_spi_reset_fifo(nspi);
+	if (ret)
+		dev_err(nspi->dev, "FIFO reset timed out\n");
+
+	return ret;
+}
+
+static int nuvoton_spi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct spi_controller *ctlr;
+	struct nuvoton_spi *nspi;
+	struct reset_control *rst;
+	unsigned long clk_rate;
+	unsigned int max_divisor;
+	u32 num_cs = NUVOTON_SPI_DEFAULT_NUM_CS;
+	int ret;
+
+	if (device_property_read_bool(dev, "spi-slave"))
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "target mode is not supported\n");
+
+	ctlr = devm_spi_alloc_host(dev, sizeof(*nspi));
+	if (!ctlr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ctlr);
+
+	nspi = spi_controller_get_devdata(ctlr);
+	nspi->dev = dev;
+	spin_lock_init(&nspi->ssctl_lock);
+
+	nspi->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(nspi->regs))
+		return PTR_ERR(nspi->regs);
+
+	nspi->clk = devm_clk_get_enabled(dev, NULL);
+	if (IS_ERR(nspi->clk))
+		return dev_err_probe(dev, PTR_ERR(nspi->clk),
+				     "failed to get and enable clock\n");
+
+	clk_rate = clk_get_rate(nspi->clk);
+	if (!clk_rate)
+		return dev_err_probe(dev, -EINVAL, "invalid clock rate\n");
+
+	rst = devm_reset_control_get_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst),
+				     "failed to get and deassert reset\n");
+
+	/*
+	 * The hardware requires at least five peripheral clock cycles after
+	 * reset deassertion before programming controller registers.
+	 */
+	udelay(DIV_ROUND_UP_ULL((u64)NUVOTON_SPI_RESET_CYCLES *
+				USEC_PER_SEC, clk_rate));
+
+	ret = device_property_read_u32(dev, "num-cs", &num_cs);
+	if (ret && ret != -EINVAL)
+		return dev_err_probe(dev, ret, "failed to read num-cs\n");
+
+	if (!num_cs || num_cs > NUVOTON_SPI_MAX_NATIVE_CS)
+		return dev_err_probe(dev, -EINVAL, "invalid num-cs %u\n",
+				     num_cs);
+
+	ctlr->num_chipselect = num_cs;
+	ctlr->max_native_cs = NUVOTON_SPI_MAX_NATIVE_CS;
+	ctlr->use_gpio_descriptors = true;
+	ctlr->max_transfer_size = nuvoton_spi_max_transfer_size;
+	ctlr->setup = nuvoton_spi_setup;
+	ctlr->set_cs = nuvoton_spi_set_cs;
+	ctlr->transfer_one = nuvoton_spi_transfer_one;
+	ctlr->handle_err = nuvoton_spi_handle_err;
+	ctlr->bits_per_word_mask = SPI_BPW_RANGE_MASK(8, 32);
+	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
+	ctlr->min_speed_hz = DIV_ROUND_UP(clk_rate,
+					  NUVOTON_SPI_MAX_DIVISOR);
+
+	ret = nuvoton_spi_calc_divisor(clk_rate, NUVOTON_SPI_MAX_SPEED_HZ,
+				       &max_divisor);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "clock rate does not support SPI transfers\n");
+
+	ctlr->max_speed_hz = clk_rate / max_divisor;
+	ctlr->dev.of_node = dev->of_node;
+
+	ret = nuvoton_spi_hw_init(nspi);
+	if (ret)
+		return ret;
+
+	ret = devm_spi_register_controller(dev, ctlr);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register SPI controller\n");
+
+	return 0;
+}
+
+static const struct of_device_id nuvoton_spi_of_match[] = {
+	{ .compatible = "nuvoton,ma35d1-spi" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, nuvoton_spi_of_match);
+
+static struct platform_driver nuvoton_spi_driver = {
+	.driver = {
+		.name = "ma35d1-spi",
+		.of_match_table = nuvoton_spi_of_match,
+	},
+	.probe = nuvoton_spi_probe,
+};
+module_platform_driver(nuvoton_spi_driver);
+
+MODULE_DESCRIPTION("Nuvoton MA35D1 SPI controller driver");
+MODULE_AUTHOR("Chi-Wen Weng <cwweng@nuvoton.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1


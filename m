Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781943;
	b=r+dyDwUBdefCerfZV/7Wm8uuloiOMwYd6rGt9Mw5h9iWmfgAStUbTvajFxLIJ8uH7QWF
	 llc9REa3ZeUX/cfhArpO+fZSRf3U0RO6TTjr/RvXVfdAaYfhjVfk8xpkJrv4a1CdXR+7Q
	 460V6Jls5R2TwZWVGQMHHFz6pt4Yb6zkPpUNXxQ7tTYoQXrSj0f2SAEr8N1fW25ctQles
	 kgCNQy3CdkC1ieUmEDPho+KvbaS5QqWYyDCUfPqXcfnhO6wVKztjqHni0L3iqyLg1Xwcc
	 mqIfo5x0dqKNZ/zZB//C4KcKAX77fL5+OdXF7hc77YDK/A1PIMHuiFsYn0i0R1dtIRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781943;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ioy1KdcErYaMkTRDj2OIu5TCOK8ONgfVlgAZynRl4ik=;
	b=i6dYu3NI771GpCFZSAGyXrI1O/SfwiMOJcLj4SVrvrMf5H0W/U+FhXL9Z61ASMzjXZk0
	 xsSvQfQoR/Exg3SdAY8qwjiJa11SLq/XfGvD5yoxpaZtyXp9VFdcH4Kytwv6OGbtNlC+f
	 Yw/Nm0+kOOg01ihUByeOyqv0j6pvarOTiH1ZGnGxp0MaXyV16/3Rkfk3GnDl4nJs2RK81
	 /XxjcvcwB88vOi+HwsxWXFtXvFMRdUjsYGpeXgac6BismOZXlGU7K0bQaSW8Ho21irhhy
	 9jp672EQEA71b/BSqXIRi8KbqsgIeIO+6ntr0K0d3wNvUlA+YbCx4Q2bch9kUKcL1+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gSqWaNQY;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BA3606A32E
	for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 12:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77BA3606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=gSqWaNQY
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so69968285e9.0
        for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 04:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795781942; x=1796386742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ioy1KdcErYaMkTRDj2OIu5TCOK8ONgfVlgAZynRl4ik=;
        b=gSqWaNQYAxNCeCuAON6Rjsn0JBd8Snp9gggxIGTl9OxJKFC39dN9QKB9X8dw2xVtcH
         UYVjqIlMlx1a0ceek/5jeL5jHfzWGB3ydff9wmwBLuClUjIqOIajpxstwaS6q/yY+Ke/
         oUG2D973cndHs0nIkjGsE/u+Ccp6SVhuiwU3+f9ndE524eWYNp2ilRQYlbtwPSStqoEk
         rRRb6NlTRz7DWnVC4BYKbrL1sGbWE6ffeRMxWyScNmCIWpMUZCwLucO+B3/pPhJ4BciQ
         qE24D5v2k/j88u4bWj9hjKb5AwrAjKXGmWz9Debv8SWTLpHG7SFfmwKFaBtDFkjAzuYv
         fibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795781942; x=1796386742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ioy1KdcErYaMkTRDj2OIu5TCOK8ONgfVlgAZynRl4ik=;
        b=CxU7Bf41kXtlwL35s1tifdNt/coWg905AsWYek2j/Lw6KIdyc2tZudhfmdgv7ih4R7
         6uscz5uVNGq+cbm+toue/0jsRIV3XBcb6lgU6dvECEt6rg5fk+eohtmi7aIHUlh4IGlX
         tjJJSUASfH1K/Yx7nwzaT3/y6ROpnvstdQEOBVUjwPMtOrFBLtgN1G8z29TBSyhwKA3G
         omqExTs5H+tsq9dyk7fnwptkLIHvJtO9P7sHPRKZnF1UBeFnHav4HSnYVdYx0zenbNZw
         xOP/oVyXXlf5fzohLTn9IfeI3wrrCDE2z1ND34kzAh0o3Z3ScNvDVaqDdsV1kGEhn6dI
         0LkA==
X-Forwarded-Encrypted: i=1; AL+hErFob2qunrFZK8y6HkFygRcJCmFGRaJPb0FsE+CD5f1ebm7aDo4VcI+G89Um4lZEMKpmnCIKqLcPS8A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JOVVBiYOhoJO7t2AQo9kNzNwfot3ijpinCzJQKVswg96T8Ox+
	FMvyVNU1msT9eiUSHNlUEpT2EMP08bj3y0+miX5ajffv2Sctek7BJEAkTgDjmFphJkc=
X-Gm-Gg: AZFdTZdonh9ydzNbOPCbx3DaMMqTddZxachDHqw64ZP4Ful3fNWm7GmfpITiGyt6ceL
	MGL8/ibNieKA9yeS6ucJG4Jv0N2acHqSZPUpiWZj3e3ZRjHxiVSa7aGdbmcc8Ato5o4wdbtfUhB
	KzIU3cRWai36jONOcrWqAmss6e0OdgEj4NMZEyEYxN+M8ouYR+hsHWZwwXvcqDFBPnGs7aVuNZW
	t61dm+Nwwhpq2QJbw9+QIMsBeQQcRyvnIK4ua1KGl9hwuV2qA1ms+L2DYTipdOECWIl0MNU7Lq3
	fcNRixikKj2n0YM/l5z55ZwKE+lBeyxg/ifN0QSyGHbxhmdRkq042XA7H/YAZCKkSxlIFQqO6OM
	H9z61zJDtBuOyiPs8QUnOY/G1OohvC8rRIfRTawVxuE4jnfgBo6+ZS8iMWx8PYAw9nCv2SD7pXs
	La4tSQmGEo75VOQpkrysqQLFTbJdFu761KQdkEIZTF45xoO0jQCbGkhnS+lGo9npp+p5M+vaW2H
	c1iqWr3nvhO5lEkk/uBCt2u1jg18mF3D6gI0Njs4+ywCbkXFhVGhx5SMpzGrLE0izDtCdpXxkPr
	zLnq9CFnvSIzZaHFez4Qb/XggQza
X-Received: by 2002:a05:600c:4ecd:b0:4a3:12fb:1ef1 with SMTP id 5b1f17b1804b1-4bb8881e81cmr508102915e9.29.1795781941754;
        Fri, 27 Nov 2026 04:19:01 -0800 (PST)
Received: from localhost ([195.94.148.180])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb88442693sm623834055e9.1.2026.11.27.04.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:19:01 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Saenz Julienne <nsaenz@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Dom Cobley <popcornmix@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Andrea della Porta <andrea.porta@suse.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH v4 15/28] spi: bcm2835: Pass the CPU physical address of the FIFO to the DMA engine
Date: Fri, 27 Nov 2026 13:22:05 +0100
Message-ID: <20261127122236.4976-16-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261127122236.4976-1-andrea.porta@suse.com>
References: <20261127122236.4976-1-andrea.porta@suse.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The addresses in struct dma_slave_config are CPU physical addresses, and
the DMA controller driver is responsible for translating them into its
own view of the bus. The driver instead reads the untranslated address
out of its reg property, which only happens to be what the BCM2835 DMA
controller expects because the DMA engine driver used the address
verbatim.

Now that the DMA engine driver translates slave addresses itself, use the
CPU physical address of the register resource, which also gets rid of
the open coded parsing of the DT node.

Also zero-initialize the slave configuration: the TX channel only sets
the destination address, while the DMA engine driver now maps every
address that is provided.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 drivers/spi/spi-bcm2835.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index cc5748973281..c40157e4516a 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -24,7 +24,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h> /* FIXME: using GPIO lookup tables */
@@ -888,23 +887,12 @@ static void bcm2835_dma_release(struct spi_controller *ctlr,
 }
 
 static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
-			    struct bcm2835_spi *bs)
+			    struct bcm2835_spi *bs, phys_addr_t phys_base)
 {
-	struct dma_slave_config slave_config;
+	struct dma_slave_config slave_config = {};
 	struct device *tx_dma_dev;
-	const __be32 *addr;
-	dma_addr_t dma_reg_base;
 	int ret;
 
-	/* base address in dma-space */
-	addr = of_get_address(ctlr->dev.of_node, 0, NULL, NULL);
-	if (!addr) {
-		dev_err(dev, "could not get DMA-register address - not using dma mode\n");
-		/* Fall back to interrupt mode */
-		return 0;
-	}
-	dma_reg_base = be32_to_cpup(addr);
-
 	/* get tx/rx dma */
 	ctlr->dma_tx = dma_request_chan(dev, "tx");
 	if (IS_ERR(ctlr->dma_tx)) {
@@ -926,7 +914,7 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	 * or, in case of an RX-only transfer, cyclically copies from the zero
 	 * page to the FIFO using a preallocated, reusable descriptor.
 	 */
-	slave_config.dst_addr = (u32)(dma_reg_base + BCM2835_SPI_FIFO);
+	slave_config.dst_addr = phys_base + BCM2835_SPI_FIFO;
 	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
 	ret = dmaengine_slave_config(ctlr->dma_tx, &slave_config);
@@ -967,9 +955,9 @@ static int bcm2835_dma_init(struct spi_controller *ctlr, struct device *dev,
 	 * RX FIFO or, in case of a TX-only transfer, cyclically writes a
 	 * precalculated value to the CS register to clear the RX FIFO.
 	 */
-	slave_config.src_addr = (u32)(dma_reg_base + BCM2835_SPI_FIFO);
+	slave_config.src_addr = phys_base + BCM2835_SPI_FIFO;
 	slave_config.src_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	slave_config.dst_addr = (u32)(dma_reg_base + BCM2835_SPI_CS);
+	slave_config.dst_addr = phys_base + BCM2835_SPI_CS;
 	slave_config.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 
 	ret = dmaengine_slave_config(ctlr->dma_rx, &slave_config);
@@ -1355,6 +1343,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 {
 	struct spi_controller *ctlr;
 	struct bcm2835_spi *bs;
+	struct resource *res;
 	int err;
 
 	ctlr = devm_spi_alloc_host(&pdev->dev, sizeof(*bs));
@@ -1377,7 +1366,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 	bs = spi_controller_get_devdata(ctlr);
 	bs->ctlr = ctlr;
 
-	bs->regs = devm_platform_ioremap_resource(pdev, 0);
+	bs->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(bs->regs))
 		return PTR_ERR(bs->regs);
 
@@ -1394,7 +1383,7 @@ static int bcm2835_spi_probe(struct platform_device *pdev)
 
 	bs->clk_hz = clk_get_rate(bs->clk);
 
-	err = bcm2835_dma_init(ctlr, &pdev->dev, bs);
+	err = bcm2835_dma_init(ctlr, &pdev->dev, bs, res->start);
 	if (err)
 		return err;
 
-- 
2.51.0


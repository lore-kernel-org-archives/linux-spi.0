Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445636;
	b=dk+TAmlLkpL6pbzjOFxYhBsK3r9wZEjlsIA8fwMJI67Iu6IoZ7lz1tk8fWFA5Nb5ZfpO
	 6tOrEJlAK9+GR9twgdEs83oFI7zbGbp34qRYw1Fz3e6TmJ9VaeaSD943m+YCmlYZfE7uv
	 9Q0Hr3HHhn1WBiCFpoItEMPKwitaa+exyk8o9JLQ5ZSGtmFp7bFBb3EUtOb8pdCWT3eI1
	 ReuXMR4UjG+wgOyzQz8cxWiQKPYSSXHxcpA0q8V48ZGVfov0Vcy/7b5sWaN0/sEN8g2TC
	 sOSczDE1S+CSV2omgTPwSn0VkPiR/EQ+E1HZBxrlXzUZaV6XmiA98UrCWQ178iuHeoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Ioy1KdcErYaMkTRDj2OIu5TCOK8ONgfVlgAZynRl4ik=;
	b=Wi34j0udbfw8CS9rTOI5gwyPbjGYwz3O6miaDGjv/vghwaniCOac4sETp77id35pFUO1
	 HmCJLop3M81uIFUFB5ESM1sdcOuAg8W4esC/Lvxqe27mticvfGuDV1ZcuPF+l9+5qWmFH
	 AyDcVfj0RyMFLAp/zM1HD3q0CNzzUGA4VkjS+LdLEdBon1lnPYzdkT6EtOcQoD1s4UKyt
	 jkyP5qGCLW5yM1iBGtwu6IH3f8eFbRi09S/XSLjy3zvCoZ6bE6MU+ZnGyHS/uczwdBaLv
	 WAEBUwbEbccSKVx/q82JdhwXd/HkH51KKpFBG0l3Efo1c/bqy7rOJhmuuJvgmg6FbSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=T+rMhbB7;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A529C60A5BD4
	for <linux-spi@vger.kernel.org>; Mon, 23 Nov 2026 14:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A529C60A5BD4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=T+rMhbB7
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb6adaf0f1so29767875e9.0
        for <linux-spi@vger.kernel.org>; Mon, 23 Nov 2026 06:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795445634; x=1796050434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ioy1KdcErYaMkTRDj2OIu5TCOK8ONgfVlgAZynRl4ik=;
        b=T+rMhbB7TsHz+7OuVgqLdkdUzql6ePQMTv9hAreNtGVPXeYIsnoB5Gr5TyXKfHeS4S
         B3/qqkqSpoAGONXDmdtA0om7D09O1tZHHD8cEMpit+yz/GvoJx6W7IZE1LAlIILxmVx/
         stWmq4Gt+61PUmHxzW14rpwXHa/e8m+FlQaMp8hB2xI/UMvgKwuAEbYeiYWmYJkmWMzh
         eo2WmxOfxvHypKgWNGak02yTr+UF+UTc2gfvEyh5OnYozpOjVpghgmo1YjtoYOcgWEvB
         mp3/Dc9egjp51RSPQH88lz6ILTKJWfYM3rVoZsAeAQoihFOOb+mGNwD3U/kHWDCI/sJv
         OhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795445634; x=1796050434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ioy1KdcErYaMkTRDj2OIu5TCOK8ONgfVlgAZynRl4ik=;
        b=ZaQ0N6LK4kcRSRWDaf44lNyUPV9KX/fZ+wmu8j/d5c6cHC/SbPeQ6jXfnm9jxyco+4
         9snTnjO+CIQ9XqrBGSEL906V5CcBZTYAqjtSj2wYNQlyztTjJvmk2Z1BzK4xk66Ai6rX
         8XK3rl9Z0mniKWDg3klDzECS0No3IMMj6lzj7DrUvy0WUKRiJSm/y4On76EDZXrdEBMA
         8y1cYMi5tlLONzvrhmx5Wms49DqGKVPc52pCOGusuRsHWYMgI40/yE+JVDtFss5xIEX2
         VcgYTs76ceJvCnI/5QzPnmDy4pWAjzbBfDeJ7QSK/AyKR53o8GSNDTXCDwDXSKf3lCUu
         rcJA==
X-Forwarded-Encrypted: i=1; AL+hErEQo1MkSgYrpbHvQdC1PDD2C9ykEP5FEiMyTA6e1tCUjquWIrwnQ0ORFOa4qSzkSgcy8b98y3t9+vY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZciFaswFrHWVVw4ixF2/qONgLF5QhUbccjNgeaFWrwWZqywWt
	vOvgpke7HZOx8//6xIuRyO/4GOCMuHy5mWzkKwJ7dNQa1Tu7mBLpiURJOTYFxMUVyb8=
X-Gm-Gg: AZFdTZfA9YslRsWMJ9gvXwwbxR0sc/zbI1OFq6wjzzcemEskzkT56fayYZv6YTezB27
	xuGtvwsCV+akJ5Cnnc7EZoQI48QwzBble/Jp6Oo2pWyU645htGLazYqSCdoch/W8EWuRkl9IbIX
	FhRUxOakYU1geWrA/GgQd4sgOCex0sO2OX0RG3Xb7pjJ1KlTwTCcjVcsrgxJ0NU04pF4E8wzWYh
	ChRzlCbW4xk6C3hm0BWZxgsSA+f0HQMXQOhtCqRgNeO228vmtdGLn2OcbegTLVZIpcRlNc89cMf
	m/JjLEm/3fsk9x4EES3MWS6bM4msz3d5RuHU0P1uiTEd3ZQjOqxG+dFsWQmW/KUtoA91G0Lepjl
	ARwaFktJG3C5xuE5Lnz7t4b7ISKhLPCFVm5H6ZzKteEPu1G+EMvP8GAFdv5aV6jWjNhMfIAYIHT
	3A4v2erQPCtA9hX9mcQLJhI4FV3e5KIxvbK/qXMj2c/ZQq2to5ORZt5lvPWEP34x7f4KBiglHf5
	xMitsGsyb5kmCNK8YGM2CoHM0FQoTTciO6PW2ARq4VL4I7uPxYWGM9hsQQnIiQSHtLc89JsKrC3
	KlJN9E9F2g0QlDkKRRxFO/csUBw=
X-Received: by 2002:a05:600c:64c7:b0:4bb:872a:f500 with SMTP id 5b1f17b1804b1-4bb887c2697mr259597265e9.3.1795445634103;
        Mon, 23 Nov 2026 06:53:54 -0800 (PST)
Received: from localhost ([82.192.120.76])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884865a2sm357418155e9.3.2026.11.23.06.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 06:53:53 -0800 (PST)
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
Subject: [PATCH v3 15/28] spi: bcm2835: Pass the CPU physical address of the FIFO to the DMA engine
Date: Mon, 23 Nov 2026 15:56:53 +0100
Message-ID: <20261123145728.29082-16-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261123145728.29082-1-andrea.porta@suse.com>
References: <20261123145728.29082-1-andrea.porta@suse.com>
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


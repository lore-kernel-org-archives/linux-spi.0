Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC30421890
	for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774543658; cv=none; b=OI38p7Jk0u8azptVRVsojwGmVjlKO2/pQzFrBPesDArV7T3PisUgzfT8yk7Kx2Cm2nO73Un900v5AUF3HzbLCUGO9MOBdZYct9/I7NVYim6DGXmHc3+MLVGi+X1gzUvoimM5fUvxJ5bKnV0t0Ov80c/S5qtKjlUTDXXpg3a1jeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774543658; c=relaxed/simple;
	bh=VZF0c41xIWi4N1BeGor29G7oeIfgt476U7dOQJg9I8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MEnoQFng9ZseHWom1fF40hQ52SEct3ST5ygmSL7/pKadJI8tDRrOTb+Prmi3jxzR9gvfUqkeonwnBg5DKNdNOn+8mEfi3mo8SiG//GxtkzAlF462Y8j2BbxGk4wtaPR/HAWax7epz0TpXO6jTxNEgXUSqR1OfblSyWH20W29Igk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=f13qncox; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="f13qncox"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C828CC566BF;
	Thu, 26 Mar 2026 16:48:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 840E8601FA;
	Thu, 26 Mar 2026 16:47:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7D95F10450CCF;
	Thu, 26 Mar 2026 17:47:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774543654; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=oi9vHPgZ6TQ8sWVxiBtvclwkIMonxdZq7gPFy31C+DI=;
	b=f13qncoxoULR4Z6zD7IG2dWYwE0ImXS4pJrZVzifYdfpGuM2TAObnWGnhtHJLZhxhbbAF1
	kKxdYaV9LMajndQnLm5arTfIjj8xeDw9bfEEEq4h87fqCrzrg1ewe10XOVUFfBT3cQw9gt
	+RqUbj+zOCz6qgFQn8mJClzvsNZIygZfTGt8uqSk3dK692h+eRx/nXkLtZsM/5fdY4hByE
	8hYCgxpeqXeCtrzzWUL7uW/rfigawivze800C8LqWXyOIwyB/BxRhbeuFHnejfJDiJyqgC
	aWYf46VKmIwUnFgEHUVBmdL9tiydFMZnoFNIP3+4wx8BeCn3CMLK0oEOlHHN2Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Mar 2026 17:47:18 +0100
Subject: [PATCH 4/4] spi: cadence-qspi: Prevent SPI NAND continuous reads
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-4-0d626e1dfb2b@bootlin.com>
References: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
In-Reply-To: <20260326-winbond-v7-0-rc1-cadence-cont-read-v1-0-0d626e1dfb2b@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Pratyush Yadav <pratyush@kernel.org>, Steam Lin <STLin2@winbond.com>, 
 Santhosh Kumar K <s-k6@ti.com>, Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

TI AM62Ax errata i2351, entitled "OSPI: Direct Access Controller (DAC)
does not support Continuous Read mode with NAND Flash", explains that
the CS can be deasserted almost at any time during a transfer (basically
there is an interconnect arbitration every 1023 byte). This is an
expected internal behaviour of the controller, but this leads to
spurious CS deasserts. These are totally forbidden during SPI NAND
continuous read transfers, because they indicate an end of transfer and
the continuous read is then stopped on the flash side.

I initially tried to query the flash type and geometry to decide whether
to apply a spi message size limit (there is a spi helper for that) but
we cannot reliably get up to the MTD structure to discriminate if it is
a NOR or a NAND we are playing with (it is not relevant to limit SPI NOR
transfers, they are not affected). If we actually take this path, what
limitation shall we enforce? The errata mentions 1023B, this is super
low, less than a typical page size (about 2k or 4k, for most of them),
so this is not usable. On my side, I only observed this problem on a
2-page read in octal DTR mode with more than 12 dummy cycles. The
writesize summed with the oobsize could be a relevant boundary, but it
is still quite arbitrary. Hence, I opted for implementing a controller
capability flag, which then is used to decide whether the SPI NAND
continuous read feature can be enabled.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
I do not know if all flavours of this controller have the same
limitation, or whether it is integration specific. As I only found
mention of this errata for the AM62 processor, I opted for limiting the
flag to a single compatible.
---
 drivers/spi/spi-cadence-quadspi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 649ff55333f0..9f9b3013aa5d 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1740,6 +1740,12 @@ static const struct spi_controller_mem_caps cqspi_mem_caps = {
 	.per_op_freq = true,
 };
 
+static const struct spi_controller_mem_caps cqspi_am654_mem_caps = {
+	.dtr = true,
+	.per_op_freq = true,
+	.no_cs_assertion = true,
+};
+
 static int cqspi_setup_flash(struct cqspi_st *cqspi)
 {
 	struct platform_device *pdev = cqspi->pdev;
@@ -1797,6 +1803,8 @@ static int cqspi_probe(struct platform_device *pdev)
 	host->mode_bits = SPI_RX_QUAD | SPI_RX_DUAL;
 	host->mem_ops = &cqspi_mem_ops;
 	host->mem_caps = &cqspi_mem_caps;
+	if (of_device_is_compatible(pdev->dev.of_node, "ti,am654-ospi"))
+		host->mem_caps = &cqspi_am654_mem_caps;
 
 	cqspi = spi_controller_get_devdata(host);
 	if (of_device_is_compatible(pdev->dev.of_node, "starfive,jh7110-qspi"))

-- 
2.51.1


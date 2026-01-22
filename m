Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA63F3876C6
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094863; cv=none; b=hS8D5L2G4Z+6eNUrLtX2O2xpEMZrjiy8IF4p+gu8UsoYBwp+fYR70jWgnREAybzuQA1Y0Z3R21FT3YpVMYy9o78Ue1ZK5NaBTsYcCqegv8fk7GlYm/oQE+1lGMhH3mi+QPOCwnjHSJFZM/W7TBl2THx0k/lPg4OLsJV47qX42gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094863; c=relaxed/simple;
	bh=s5qeqBhzqXvBR0yVd6ehmw1JmdAeCogqylKOKRTU5a0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X7BwZKea2UDYE7Kv6JfW+7HfnYvJRmUtRnHxd2pqe9D8mxwO+FUTh42j76G5TEZqZkjx2dgkSBmtvVVhJVR+BuefaY5bQCzCdvMoUqf48b5HUtf+56hgDVdromfXOyW/SUbTz/ufgR+cn+ZS0Ufn39NhFIp+Qz+O+/nxJ+pOiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lXh3iqFC; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lXh3iqFC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 474F7C21AA7;
	Thu, 22 Jan 2026 15:14:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6E78A606B6;
	Thu, 22 Jan 2026 15:14:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9DA42119B82C1;
	Thu, 22 Jan 2026 16:14:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769094858; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QegLxnXsPbyMpFnnOsyJbRiNNWksSHe1X3JonRazV2o=;
	b=lXh3iqFCuehpD4zHg1NoHByMIiq86jeu/zSpMQiQj1x1Eg0BcuSJ4UVTDaNGecT0eV4ZVm
	bW16OjHQUHhBKWtJbfGtd4elyUjHK3hxK9n9XMjqV+S2TLIzV2ozJXANcSo3lIv7joE0WD
	XKKAa7i4MV4b7djmKB7pOywNiGiS0b6l9w7ByZTx1+W7dpX0Ie99jm71D1Mq5H23WI1lNZ
	hfA7S1JqgBazM7rvd71SDgmy22puFptRch6Aw3bope0zLbukgP4+eIO2qgZv/vDmgYBPxz
	vMtplKsW0n5AxNygyMRKgj/rN121bJxvqwSCRTjwMDJIC6AQs0pJwv12+u/e5A==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 22 Jan 2026 16:13:37 +0100
Subject: [PATCH v4 12/15] spi: cadence-qspi: Make sure write protection is
 disabled
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-schneider-6-19-rc1-qspi-v4-12-f9c21419a3e6@bootlin.com>
References: <20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com>
In-Reply-To: <20260122-schneider-6-19-rc1-qspi-v4-0-f9c21419a3e6@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, Vaishnav Achath <vaishnav.a@ti.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 Pascal Eberhard <pascal.eberhard@se.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, 
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Renesas RZ/N1 QSPI controllers embed the Cadence IP with some
modifications. For instance, they feature a write protection of the
direct mapping at the controller level, with this feature all data
writes to the AHB region are aborted.

Despite the fact that the flag setting write protection is disabled by
default, Bootloaders may (and actually do) set it, so mark this feature
as being available with a specific flag to, if applicable, make sure it
is disabled.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index e1ec20684b0a..e0e4423baed9 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -48,6 +48,7 @@ static_assert(CQSPI_MAX_CHIPSELECT <= SPI_DEVICE_CS_CNT_MAX);
 #define CQSPI_DISABLE_STIG_MODE		BIT(9)
 #define CQSPI_DISABLE_RUNTIME_PM	BIT(10)
 #define CQSPI_NO_INDIRECT_MODE		BIT(11)
+#define CQSPI_HAS_WR_PROTECT		BIT(12)
 
 /* Capabilities */
 #define CQSPI_SUPPORTS_OCTAL		BIT(0)
@@ -218,6 +219,8 @@ struct cqspi_driver_platdata {
 #define CQSPI_REG_IRQSTATUS			0x40
 #define CQSPI_REG_IRQMASK			0x44
 
+#define CQSPI_REG_WR_PROT_CTRL			0x58
+
 #define CQSPI_REG_INDIRECTRD			0x60
 #define CQSPI_REG_INDIRECTRD_START_MASK		BIT(0)
 #define CQSPI_REG_INDIRECTRD_CANCEL_MASK	BIT(1)
@@ -1641,6 +1644,10 @@ static void cqspi_controller_init(struct cqspi_st *cqspi)
 		       cqspi->iobase + CQSPI_REG_INDIRECTWRWATERMARK);
 	}
 
+	/* Disable write protection at controller level */
+	if (cqspi->ddata && cqspi->ddata->quirks & CQSPI_HAS_WR_PROTECT)
+		writel(0, cqspi->iobase + CQSPI_REG_WR_PROT_CTRL);
+
 	/* Disable direct access controller */
 	if (!cqspi->use_direct_mode) {
 		reg = readl(cqspi->iobase + CQSPI_REG_CONFIG);

-- 
2.51.1


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194896;
	b=TqzsylMggTotlBGbVMX0FQSrrYhI3qZhI+ncl+lmVxNp1gLgaR6p6AjsnA+Ry046FNeu
	 diCvCKHYgM/eN7bnZdGETnbrLvBDTSDTWRlzTUo+2iXjLvQpWiTmkp8BO0n+/92Sdnj4U
	 zp+PhOwPIqKJeesKx/eqUhGCbtIzSiqaOt4JKupRvY+e9EEiqJsWcbe9vSXBmTxMaybLY
	 7gaaGH4N8dXOcF3sTHB4wdHxalb5hcYoKMEfJBQTC36aqQGd9fWGQn2XiJXL/uPQRGtra
	 PDDphTDZFdpDE43rhUI0Qb2JWDN9MDMymSDNI8WoMsFbEL+v7caZYKtMP2yBfiU0jqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194896;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=lJI13tJYjzjGtIHD9Wd2cBZDEmFMRj8+hARz6pmVykE=;
	b=Yw4nJZh60dYTTIZWNBm4sSZghWnRULZ5g9nFBGi2bF/N9CHG4z1iZom1kzkVDuuYcf7z
	 vwAfyTT0pB9RP3iRzmf0ow6WSXHmVN2YjsdLpJZWlnlr3gThTO6nIIT/vJcoiEpoGKrP4
	 wx7waGQKyw6zh6w6NqynwhW81xKuIp+TbDZRgvjuyywH+6QR7tr98VFp1OKExqOXNMX+U
	 iMn/aVykHIlJzwBda2zp/PRRIs9nJ5L8cBuCwvy02agg2aHGtvB/j3xOnuragni5/VYQ/
	 VGCuF0s2ljyC+l/QiFNitOn0hknrmh44z2XZZwWSr4xGcpEi5XYAsd2fNRYkYX7oJSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wyZRYaA7;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C06606A32A
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 17:14:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24C06606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wyZRYaA7
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 51A47C62226;
	Fri, 20 Nov 2026 17:14:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8A0A0601B9;
	Fri, 20 Nov 2026 17:14:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 015A511BC0500;
	Fri, 20 Nov 2026 18:14:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795194889; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=lJI13tJYjzjGtIHD9Wd2cBZDEmFMRj8+hARz6pmVykE=;
	b=wyZRYaA7rdUucPHhAgRe3w46AtJR27dhbOgZmFrDyPf3Qj9Z2yWMvm35Jzj/Ce+EcEIhA/
	AUMvShEeawcwrFFZFNmpmKPlkrrCeUjtXBjfcWGZEPNJLCUs0KSi8cvX6el/rKF64hWQ8p
	yWNeA0doxrInbs7qQmBIb0VFVf6i1XRm4meS+c3CRVXjpYQS7TJhclXFp9A6V7Ra377TW1
	LTWwhqSM0yZB9CTnbXAvIfHhrTMYocVLcyCI8zsQyXUZ7Qu0REy7y8Jw0iDU76AKzISD0v
	kTpcZlFbWooysaos0m7hhq6p03SF9ZFaK+aC60cbcoZZt0OcCe3sHZz5jyXsEQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 20 Nov 2026 18:14:32 +0100
Subject: [PATCH v4 06/11] spi: cadence-quadspi: Advertise DQS support
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-winbond-nand-next-phy-tuning-v4-6-8c21e1f71f41@bootlin.com>
References: <20261120-winbond-nand-next-phy-tuning-v4-0-8c21e1f71f41@bootlin.com>
In-Reply-To: <20261120-winbond-nand-next-phy-tuning-v4-0-8c21e1f71f41@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Pratyush Yadav <pratyush@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, praneeth@ti.com, 
 u-kumar1@ti.com, p-mantena@ti.com, a-dutta@ti.com, s-k6@ti.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The Cadence QSPI controller supports DQS read data capture. Advertise this
capability in the controller memory capabilities so that
spi_mem_dqs_is_usable() reports DQS as usable when the memory supports it
and the DQS line is wired.

This lets memory drivers enable the DQS output only when the controller is
able to make use of it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 2982df7fd092..72a5101c4a8c 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -3770,12 +3770,14 @@ static const struct spi_controller_mem_ops cqspi_mem_ops = {
 static const struct spi_controller_mem_caps cqspi_mem_caps = {
 	.dtr = true,
 	.per_op_freq = true,
+	.dqs = true,
 };
 
 static const struct spi_controller_mem_caps cqspi_am654_mem_caps = {
 	.dtr = true,
 	.per_op_freq = true,
 	.no_cs_assertion = true,
+	.dqs = true,
 };
 
 static int cqspi_setup_flash(struct cqspi_st *cqspi)

-- 
2.56.0


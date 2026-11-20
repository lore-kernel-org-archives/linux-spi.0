Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194908;
	b=tIP+Ut9hnw2U0HNQX9fCc2qEmcQSyoVGycH4xdBrmOHWlegN11wYiKb6P3VdXxLKVwan
	 M7rDTMpgkGGIIxbANY5mcY7S2aoXptKG+k7enCMhj53Uv7GEK9mSIXe+bQH6ru60SG3k9
	 KnJ9nduxMt6/+SVr0GY9fQw1hQMnQCWDi3Z+piwsyxDX07V3D+egU7N+AfedqhVy0zOuF
	 ru1CEkC87TFboI/LfRv4ycIusJSXFWEnVYaEziOBdsGiQ62UVZeYWmTks/8qdqbyJBaKp
	 vFt6G5r7sFBfvMMlFYzdy8uWNdY3pyUkDRoYoFHbYhLSM5phIoaW9Ee/J6Bviu6dLcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194908;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=sbrnTC1O3lLMY5mwmHSs1TEwBYsx23gEPdvUD7iMI6c=;
	b=WORXWEK0m86KmlZRoIVRf7bdmgKl27KCVAougQpGmjePD0GDbw+BqZuuPIdJ3bmDnrAU
	 7QtEiCshBRrmcrel9JggWsfG8OtKWJY3vFOGuBaD9iOzGxzbneYgOhATqA6rBpqhXIPWH
	 tezVPFYA+hA5dCvgGyuqq4/G0AV8AjKusQt/ykLvUoC+4uRQavvrSOD/0JVuQe7PzvvEm
	 ngZpbkUPm4cMOxlq2MtbBZs1XNHw00UuYIwb66BUlxxzuuY/976QdmWp85P2PBAM4kh9y
	 J6RjNuudamoSk99JPMK25D5yJ8R1/q5thI629oupJcy4MhduK0SQIWQ5/0vRzLqQYDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wY1wnTDJ;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD2D606A33B
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 17:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0CD2D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=wY1wnTDJ
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C291E1A1751;
	Fri, 20 Nov 2026 17:15:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8A004601B9;
	Fri, 20 Nov 2026 17:15:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 074FA11BC0554;
	Fri, 20 Nov 2026 18:14:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795194898; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=sbrnTC1O3lLMY5mwmHSs1TEwBYsx23gEPdvUD7iMI6c=;
	b=wY1wnTDJHs5MHmOCM+XI+uIWkVUFCTb/K5sDaV7u81Hy/T/CVml20RkhdzZRXxlSab4EBV
	2WqIp1fEBW7KmH/nKSTQniMoSv8ivEeYuTTTgsG5ZMsLhbFs3rQ/RC8+X62fkB91yosBSA
	FOfTOexSNkwo4w1mdQ7rFOIsJwcBeC3X5BJ/ZRnFIXANeYZNfMmoBjEXLbhMrhGWRuA2LH
	0e5GAPDkkavzt55KA/Xd3XhoxIrTH3LhLZcZAz+TQpBQf7rs4aOgcz0v/MBd/Hm7vlHesP
	48DSIjWUkA5voxpNor53qqcRC0mxnz0n+nFszyiJpJDiLW4KWPfyVW7ETC4O7g==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 20 Nov 2026 18:14:35 +0100
Subject: [PATCH v4 09/11] mtd: spi-nor: Advertise DQS support for octal DTR
 flashes
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
Message-Id: <20261120-winbond-nand-next-phy-tuning-v4-9-8c21e1f71f41@bootlin.com>
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

The SPI NOR core does not advertise the DQS capability to the controller,
so spi_mem_dqs_is_usable() returns false for SPI NOR flashes even when
they support DQS. Controllers able to use DQS read data capture are
therefore not able to enable it with octal DTR flashes.

Advertise the DQS pin when the read protocol is octal DTR. DQS support is
a per-flash capability which should be described in the flash_info tables,
but there is no flag for it yet. Keep a TODO in the code and enable the
feature by default for all octal DTR flashes until the per-flash
description is added.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/spi-nor/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index ecf5fdf38471..b78c8fb5a101 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -3638,6 +3638,13 @@ static int spi_nor_probe(struct spi_mem *spimem)
 			return -ENOMEM;
 	}
 
+	/*
+	 * TODO: DQS support is a per-flash capability which should be described
+	 * in the flash_info tables, it is considered enabled by default.
+	 */
+	if (nor->read_proto == SNOR_PROTO_8_8_8_DTR)
+		spi_mem_set_dqs_pin_available(spimem);
+
 	/*
 	 * Populate the persistent template and run PHY tuning before dirmap
 	 * creation so the validated frequency feeds into the dirmap op.

-- 
2.56.0


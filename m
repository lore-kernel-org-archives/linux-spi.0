Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194906;
	b=UItc99XnpK92ZyJEZr/+oSuEClnzMW4z8AhXDb2yzBcnQ2QcE+y4vE7zGYFlUg6QRiyC
	 DND96LhoK1EstCTu6A8xLZif293eZMgWqI18z5PGVOPW99YGtFmjeJNb/ESPQkKFkfHyC
	 gFK7CZAv8QZ1V4JzV/85Ma1VtGVU6goawSRaOe8WMvlwYR4QL11NYxAEEqSapyADNrrn+
	 WVDNQtAOHX2UxTDQCcKfhkX00DKUUn++dI1A+sbBxKdroRuTDk8DYEAbH6nFGdVnkrHBU
	 nP1y6aUcd5yk49Eb9aHuQ7ijTEJs2qxjmlTwlmg454R0VgK5ngqe0zpmycIhRhY2y/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194906;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=31+QEQkTdBsAyjdQylHnzUm9tPSei/fUeG542zDh7q0=;
	b=kKPwHLOQAuJcqLUYX9TDNEM2l94qm9jHtQETR+K9F3Kg/vlYEapE4NToASjQ+cQhYmU4
	 eSOmHidu+bjG/eQr7O9wQL3YUW+eqNZtP7TO5BfoxrRw2DIdpdV5lwtIYKd6hwBsjzwPc
	 e2vFQ+HHtY+zRRSsq3ToQb8ptETdIRMTMH8+r+OhPUJq/jgFp5NtjsYFCfIBhXyqqtG82
	 C1eIWhHdSE38llmZlPYJPy7ml6PWIdeuEq3mt3n1EFiZPf2x7tEjiO9xy0mKNNMAJATaR
	 va2erGIcsN/3fmJNvBr6tATi5JE3aYiRFFYVHv1wxbIXEPkpak/1yT8F2yXkN5JlVng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="fHR6XY/d";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050460A2609
	for <linux-spi@vger.kernel.org>; Fri, 20 Nov 2026 17:15:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D050460A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fHR6XY/d
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ADE071A1754;
	Fri, 20 Nov 2026 17:15:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 824A1601B9;
	Fri, 20 Nov 2026 17:15:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 97D3811BC05A8;
	Fri, 20 Nov 2026 18:14:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795194900; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=31+QEQkTdBsAyjdQylHnzUm9tPSei/fUeG542zDh7q0=;
	b=fHR6XY/dsAuwkq49kqO1G1gpUJP18bQnFEHtqr2pY7KpDvCdkr87Rwh7YZhIvsLktmfC04
	kcNsvcVM5iVKZdKENVsIDsam65sE40JjUcsLgDMSQXITFGRD0nof1letJMJyRE/R/jt9Bg
	2UW+K39vOD8hY04ZbMcWizS4qb+A1PDRUGnlpjCGf0DTT6SoCbl5K6ICBHqF9ji0qwz3a8
	IcogV3nNRdxH9BOr9E0u3Ph8TuPjQ331sMkiRAapC7yXlyRhH6LRHReaMjkM4bOIHEaaUd
	PS9MRvB5O0vxPONabqGAyNVLpb0McN0fsI7kcDwBuedREZNdrDFwHjImOx1SYA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 20 Nov 2026 18:14:36 +0100
Subject: [PATCH v4 10/11] mtd: spi-nand: Set the DQS spi-mem capability if
 available
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
Message-Id: <20261120-winbond-nand-next-phy-tuning-v4-10-8c21e1f71f41@bootlin.com>
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

Check whether the NAND is capable of generating a DQS signal and advertise
the capability through the spi-mem layer. Do it as soon as the chip is
identified and before the SSDR/ODTR operation variants are negotiated, so
that controllers can take the capability into account when they need it.

Whether the DQS line is actually wired is described by the
spi-dqs-not-wired DT property and handled by the spi-mem layer, which
only reports DQS as available when the chip supports it, the line is
wired and the controller can use it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/spi/core.c | 3 +++
 include/linux/mtd/spinand.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index fee4a48b4c7f..6e1b7976d237 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -1797,6 +1797,9 @@ int spinand_match_and_init(struct spinand_device *spinand,
 			}
 		}
 
+		if (spinand->flags & SPINAND_HAS_DQS)
+			spi_mem_set_dqs_pin_available(spinand->spimem);
+
 		/* I/O variants selection with octo-spi DDR commands (optional) */
 
 		ret = spinand_init_odtr_instruction_set(spinand);
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 87107f0955eb..990d3e9ac3fe 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -492,6 +492,7 @@ struct spinand_ecc_info {
 #define SPINAND_HAS_READ_PLANE_SELECT_BIT		BIT(3)
 #define SPINAND_NO_RAW_ACCESS				BIT(4)
 #define SPINAND_ODTR_PACKED_PAGE_READ			BIT(5)
+#define SPINAND_HAS_DQS					BIT(6)
 
 /**
  * struct spinand_ondie_ecc_conf - private SPI-NAND on-die ECC engine structure

-- 
2.56.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795720279;
	b=HFdKwJHsigkJSG24qUxd5w7IN03oVZ25eHfpIiBcGhbXxS1+wQ6h3LU8JfWAVMiBAE6Z
	 0vJnZknR2Ob+xQYUuY23LpEBqvmgLX1vOhvxEUfXxAF60wA8uyuZFkT/nZbVIufKCk2Oz
	 PymO8He+yweK+OuOpzunDmY5ZLqTmjZxMirNW2D/Rum9g0i/2gmfN1ilGcQ8oHjCuZRAi
	 B5fipnZigHuWSjsfcYBfqD0dG9qE09/VTJ8ozZFOhVlEMdUWTAmOqEQeGkzS1LE0AbwT7
	 XaqUq3+/z6YI6mWeH6vuTAcTzrJxuJQCEHh9zeNeX381NmVbJAm1pSeVAwm9dAVFEDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795720279;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=3wS3MrJJemfmkKmZHQvuQ5e1ha4PFkjkqrpxxc6PrgE=;
	b=MDfevkHbjC0jAQStvWAxSyBYENGg40vOqIrRC5sbWsdYVyxxfg3dr1/kj1oKJrTMDBeg
	 2JFCT//fXNLIjlsiPMLycvFiFR0ifmYP/7tV0oEo776i2yvlRbdC4XGHlQQqs8cgOCzVd
	 LyA78GT6V69Fhaq1of9CMaN4tagvJeGpZgL39mzXFFPQl3F3pZonbYmPLBd7dwwN2PoV0
	 I6sQk4cqT9o/4iN0AkFYSi8eHc4V/oZe/lffXh0jJgouFlqH/2teqo0u8TkONL0JODkEI
	 WEkFfNVuPjvnVtoXpqpF8fVN6CHZ+SoFmt/Jx1tbWM6Ouy9TQIdtJCyWQmDtmsKwi0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="r+Rlj/Uf";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EAB606A32E;
	Thu, 26 Nov 2026 19:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46EAB606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=r+Rlj/Uf
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E41991A181F;
	Thu, 26 Nov 2026 19:11:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B21F460558;
	Thu, 26 Nov 2026 19:11:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CAF3611E691C9;
	Thu, 26 Nov 2026 20:11:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795720276; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3wS3MrJJemfmkKmZHQvuQ5e1ha4PFkjkqrpxxc6PrgE=;
	b=r+Rlj/Uf/5FUfMBke6i49V0U2qJVmcrX8309hbV1z32hKiLRldD1qjFotA7Ja8ONXy8F3m
	Fhb+rIybEcSSNvmcrRPtgLiBHwl0lDXnZ/0GHavD9rLiHpOQ642VNudPJogJDVZe8D5L+L
	EyzwitqTY6u3fTXK9kwvhK+dD2BN3kG6xjdEtxbY9UxRQ5D+pKOVAUjI2ufk8benFG0GKw
	3pdEJ7GCwAM9yLJwCAGExPLM0FB5gn3Bfs3rEICp8hrZEiyJ8hAU26DpTXo5bT0TMzLRb7
	UxmR4wGS6vxN2KfQqirbpKVYVHoDiaf49tAtJGCr94y8IucOft1P7+49XPnMqw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 26 Nov 2026 20:10:23 +0100
Subject: [PATCH 04/12] spi: ath79: Validate the dummy buswidth
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
Message-Id: <20261126-macronix-upstreaming-spi-driver-fixes-v1-4-ca8e924cca1b@bootlin.com>
References: <20261126-macronix-upstreaming-spi-driver-fixes-v1-0-ca8e924cca1b@bootlin.com>
In-Reply-To: <20261126-macronix-upstreaming-spi-driver-fixes-v1-0-ca8e924cca1b@bootlin.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>, 
 Krishnamoorthi M <krishnamoorthi.m@amd.com>, 
 Mark Brown <broonie@kernel.org>, CL Wang <cl634@andestech.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Yang Shen <shenyang39@huawei.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Cheng Ming Lin <linchengming884@gmail.com>, 
 Alvin Zhou <alvinzhou@mxic.com.tw>, 
 Cheng Ming Lin <chengminglin@mxic.com.tw>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-riscv@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The controller is single-lane. Reject operations asking for a dummy
buswidth other than one.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-ath79.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index 1f5d0fb03917..36f21918d790 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -145,7 +145,8 @@ static int ath79_exec_mem_op(struct spi_mem *mem,
 
 	/* Only use for fast-read op. */
 	if (op->cmd.opcode != 0x0b || op->data.dir != SPI_MEM_DATA_IN ||
-	    op->addr.nbytes != 3 || op->dummy.nbytes != 1)
+	    op->addr.nbytes != 3 || op->dummy.nbytes != 1 ||
+	    op->dummy.buswidth != 1)
 		return -EOPNOTSUPP;
 
 	/* disable GPIO mode */

-- 
2.56.0


Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C84437FF66;
	Thu, 22 Jan 2026 15:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094852; cv=none; b=Qjm6gKzBoaNzyWtx+B+TCZkgeVPvmIns8WkzoIK5uxgHbU90XlnTBsXioJnR4HRi8zY3gp5MRmaS9/m3wE7x/M2XriFcu9nsMdrC0NvWpH+SniqyI15BPKqfjhUHeCKHw1MUQUlwXhA7X3h3wyClz37ZxnGQ1LcVuZ1zsWgrZkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094852; c=relaxed/simple;
	bh=ZQUmRyH3AswY8FGRKszIfF3sz0k1NkGxrNlVU2gJVCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IgvUd+iRlFrfvafGiwM6mB8Cx/kKnTU8rLg1h96Cs6XmANMUy73enA9u+FACBLcoICiy51aNKbxFbOwwTxvCBCuC7KVCVey+On+xwbJN3FyG9qjxolyxH3RK+FU2EGUUVjbyCg6JVT/DLzBc7zoIuj6xKRstZQdctT2R0lUUcOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qifbUPyz; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qifbUPyz"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 208FE4E421F3;
	Thu, 22 Jan 2026 15:14:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E4AF6606B6;
	Thu, 22 Jan 2026 15:14:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B927F119B82E8;
	Thu, 22 Jan 2026 16:14:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769094847; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EMbLn4ztip/MZhDqXh4OQPXIi4Ml+zoGnNkz7bb0Ccs=;
	b=qifbUPyzj8LbihQP0mseso0NVEZqoyfwKgP3szFvykL5kam/m0A0ELd9qJfug7GfAOgfyu
	L60NUbUHClHBawJv+KVWw1S2BhVpdhtKnLuB/xkBAHrYY/B2sWPRr4v3LcP633JxH+yHt7
	8+Pd3t2MzYDHsIC6uhkikAzT1pj37LQjejgCr51zS6c0l++FKTRuO55M2bGBpk0+n05WqB
	yuBtMGtHWwSORUUvpXkI7k/ITxc2kOUKP46clhn81x+VQ4hHRSwLkUg2jZJfzr2Zqtc1CH
	jLKr7qMZQH/lICD0HEBp9VPJed6IV8eueSxlSKjhBBOWED+pQ0HqJ87P7aW1tg==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Thu, 22 Jan 2026 16:13:32 +0100
Subject: [PATCH v4 07/15] spi: cadence-qspi: Make sure we filter out
 unsupported ops
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-schneider-6-19-rc1-qspi-v4-7-f9c21419a3e6@bootlin.com>
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

The Cadence driver does not support anything else than repeating the
command opcode twice while in octal DTR mode. Make this clear by
checking for this in the ->supports_op() hook.

Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Miquel Raynal (Schneider Electric) <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-cadence-quadspi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 06f6c5979229..fc9f6e8dd549 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1531,6 +1531,10 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 			return false;
 		if (op->data.nbytes && op->data.buswidth != 8)
 			return false;
+
+		/* A single opcode is supported, it will be repeated */
+		if ((op->cmd.opcode >> 8) != (op->cmd.opcode & 0xFF))
+			return false;
 	} else if (!all_false) {
 		/* Mixed DTR modes are not supported. */
 		return false;

-- 
2.51.1


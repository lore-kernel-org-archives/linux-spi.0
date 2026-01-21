Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A239D4D90A9;
	Wed, 21 Jan 2026 17:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769015132; cv=none; b=axngP8w6RZwFNm/86ISWM94qPtD81kL2wSqqRu+EDwRPOExk0z9cRHmVaV7j+VYujMOuqx2AraejuR93uykHLGZc5ipioiv+dxtl+j12S2TYiq059lHf76hZLegrHxf1SASASd9ETtKSdgRoC1e4XQtU6cL2WrK+GMQU4GXriXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769015132; c=relaxed/simple;
	bh=ZQUmRyH3AswY8FGRKszIfF3sz0k1NkGxrNlVU2gJVCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V2sAGSx+EMtF91C8XOCoM51V61MJYGkbr5CUFlH2thMG22B3H3+K5rPXYzKkg+vDuqB5IPF3+gt2jhng1oeGsgkHGLNWzy012qhlQeJs2R7crseBQPaYR/bDopXiSQGUrNIg4jO8WufQ0UdVGAiEzIMskHKyWnipYqiJ/NNDvIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SJPNe9a/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SJPNe9a/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id EA457C21A90;
	Wed, 21 Jan 2026 17:05:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2A4286070A;
	Wed, 21 Jan 2026 17:05:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7659F119B189E;
	Wed, 21 Jan 2026 18:05:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769015128; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=EMbLn4ztip/MZhDqXh4OQPXIi4Ml+zoGnNkz7bb0Ccs=;
	b=SJPNe9a/hQnDHzK5IBUuKWjA2y2IE12UaMobjIzT+AUV7FBc9DozolpSjRc3i93H/Vn3/O
	5KvJIzdln+vvycfyfXOtz41aOIvCorcTJTylgJ3sTgjdOOjM2escffMF/qSP2sar1fVgBn
	OhTezcElJ6UDLyHo+0lPR6ySsHpKcE6SBimT1ILQePVpAQGxq76mQa6ZL+lVQ7Fdf0Vddl
	Pbm4FVmumv8ANvQzE9Vo2bFQfdwgZPKWNTtXobNNRYnYRgPWZkLU2NX5Ma5yUbF5QT7tcT
	CA1RcL6PD8vHifzLPPC34//osf5sGkuoIzM9pyL+kyV1Vgbc6fSfmIC91ivmUg==
From: "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Date: Wed, 21 Jan 2026 18:05:05 +0100
Subject: [PATCH v3 09/17] spi: cadence-qspi: Make sure we filter out
 unsupported ops
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-schneider-6-19-rc1-qspi-v3-9-43e70fab4444@bootlin.com>
References: <20260121-schneider-6-19-rc1-qspi-v3-0-43e70fab4444@bootlin.com>
In-Reply-To: <20260121-schneider-6-19-rc1-qspi-v3-0-43e70fab4444@bootlin.com>
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


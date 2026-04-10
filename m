Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE03ACA7A;
	Fri, 10 Apr 2026 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842880; cv=none; b=ODOeh0KgQcSrX0RhlrmVasDneOIj5f0CHP2397WKuHZlbdBKSKu6oBiyZW8mtNzc552T+8czB7oYpFDpQpMyVjEhQPp6rIkkcH/DntzkyXnzMstdt+kKnXyibX5J9Tqtvh/2XkhYbN+3grNnBLKdwkAwobQACMLBrEzO15kjuo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842880; c=relaxed/simple;
	bh=sanbJOvhkoyHWzuJ2bZpEVZZm2Hzp/7V9o49waG+1RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJg51iZIb/obWXL2vJia6bSiqgcmRZgfeR/vS+Ek9Qgq5w7jg1L3HxH/fbHivx6/EMf6gNxkVWP+cEDllRiUi8GTnTSMfZsdiMsIcwEVzTI8BHiGKnXgumbdHkqOA0wKKMvh3v2OPPPJMwOZGRxAuaGO3bGMqMWjL2d0pzg0urA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xCTfkMry; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xCTfkMry"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 26D914E429B3;
	Fri, 10 Apr 2026 17:41:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F3378603F0;
	Fri, 10 Apr 2026 17:41:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F281010450082;
	Fri, 10 Apr 2026 19:41:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775842876; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=KwQcWNOtwSww1tE4Ej8T9s6pqrHBg9EZ9z5kc47zF+c=;
	b=xCTfkMrymL7P7nBQyGQfECaGcvz4IFCFaydu29//TvtvzOMR/p6/NZbHpKfUoI+rHF5seq
	E4svM5ZGM/TArGt1N8OV6wV7MxYQ0JtdS/FWVjtqgGScjfOghwarKUM1qPmAXkVQfGAyfj
	pYHHo+XGDhKl6bLmGj9Ot9FtHjcD0LqFLqSYVhzyvBYHNqBwugPMtTHstiVI8LylpKLbA0
	TKxV/3dGFRzOG/aghhRLcIMxR8sIRwKKWg83mYfjDIqr1tqrEMLY6VswGCPc6tfZ6mJ8/M
	buMw+mygFJzGPeDkrrNU1mUd1FRe8Xh8Bnbn3fM9t7QqDd1v/rW5389uFSRJtw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Apr 2026 19:41:01 +0200
Subject: [PATCH 1/5] spi: cadence-qspi: Revert the filtering of certain
 opcodes in ODTR
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-winbond-6-19-rc1-oddr-v1-1-2ac4827a3868@bootlin.com>
References: <20260410-winbond-6-19-rc1-oddr-v1-0-2ac4827a3868@bootlin.com>
In-Reply-To: <20260410-winbond-6-19-rc1-oddr-v1-0-2ac4827a3868@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Pratyush Yadav <pratyush@kernel.org>
Cc: Steam Lin <STLin2@winbond.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

I got mislead while analyzing the driver by the fact that the second
opcode byte was in all cases smashed:

        if (op->cmd.dtr)
                opcode = op->cmd.opcode >> 8;
        else
                opcode = op->cmd.opcode;

While at a first glance this doesn't let a chance to the second byte to
be shifted out on the bus, this is actually the second step of an
initialization, where the byte being apparently "ignored" in DTR mode
has already been written in a dedicated "extended opcode" register. As
such, the comment and the extra check that I proposed were entirely
wrong, remove them.

Fixes: bee085476d27 ("spi: cadence-qspi: Make sure we filter out unsupported ops")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
My apologies for this mistake. Until now I never had to deal with "non
repeated" opcodes. Now that I do, I realize that this was wrong.
---
 drivers/spi/spi-cadence-quadspi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 649ff55333f0..87e49d913591 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1538,10 +1538,6 @@ static bool cqspi_supports_mem_op(struct spi_mem *mem,
 		if (op->data.nbytes && op->data.buswidth != 8)
 			return false;
 
-		/* A single opcode is supported, it will be repeated */
-		if ((op->cmd.opcode >> 8) != (op->cmd.opcode & 0xFF))
-			return false;
-
 		if (cqspi->is_rzn1)
 			return false;
 	} else if (!all_false) {

-- 
2.53.0


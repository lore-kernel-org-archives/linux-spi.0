Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2033E3C7D
	for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 17:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842886; cv=none; b=VKrOyf5Fi0WdovsZvRqMDLk/x0EyYuKEvB01Y2VV/e9AkZLOK0t24BptKIELdMe3notQG2y4CeOsm/KwuEaBbhR4Dbn2G3bAuRfIUEkvJaBI8EP82FCGMughr0Z5LoPGmrRxS2L+ZbdZ19S2+wB3HSlMa2t1yUleHBrdTmB3Mqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842886; c=relaxed/simple;
	bh=DxNUiAV8QQbcL1W9BD88f5w8fzduKyF8UwyVtXxgIH8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BzaP/HkZ0Gj6W5nADOyLG4KiNgiO21YcjsZyblL1BN/rwkjrIXaxAzM8BKyI8nYWN+gWGvn8wKbkJWGHUZJT54yeoolK5t8sHod9nYWVyp79u3mcSJdY07RnyInSX0tvSfFsl5i/5QsPEj5ytIVDXfrulC5sLpfUnI6uzrWMMXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=COUm0kju; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="COUm0kju"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8F6941A326A;
	Fri, 10 Apr 2026 17:41:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5EF95603F0;
	Fri, 10 Apr 2026 17:41:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7639510450087;
	Fri, 10 Apr 2026 19:41:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1775842877; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2AC6qYaca5YIbXnwFi4AJhlPo8WH9aZ0yyO5uwUoPUg=;
	b=COUm0kju/z4kounke5nkPkUbc2iDip1hKvyMU9ThOfb6jduocKZ2+iRGdV+IO541mLXQMO
	TY3rpGKID5axBXVIDek0Qzn8Kf9r3c2WLVvyyYruFCFh/wHmfQFvcsS68VcJWQ3+0LMTxk
	Gr0NgenSplV/EfP3kQ4JpnwAEG1dd8kyk5S/dvJPp6LZlW01B5yc4U3xLuh7zpcUz3CBaD
	fLCx+FCFGe1wWNq1p38QrLiQ/J/o0GzLn6JiJYikU+gYqDzcxpaPLFdv/kfvJgUEe7ezEE
	xja0RYFQugTkG4MtV60mj6sdqbSW1OOECiF8gqZ9O/s/fTsrcqFL4RXvAfm1xw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 10 Apr 2026 19:41:02 +0200
Subject: [PATCH 2/5] spi: spi-mem: Add a packed command operation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-winbond-6-19-rc1-oddr-v1-2-2ac4827a3868@bootlin.com>
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

Instead of repeating the command opcode twice, some flash devices try to
pack command and address bits. In this case, the second opcode byte
being sent (LSB) is free to be used. The input data must be ANDed to
only provide the relevant bits.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 include/linux/spi/spi-mem.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
index 5774e554c0f0..f54c708f4c50 100644
--- a/include/linux/spi/spi-mem.h
+++ b/include/linux/spi/spi-mem.h
@@ -28,6 +28,14 @@
 		.dtr = true,					\
 	}
 
+#define SPI_MEM_DTR_OP_PACKED_CMD(__opcode, __addr, __buswidth)	\
+	{							\
+		.nbytes = 2,					\
+		.opcode = __opcode << 8 | __addr,		\
+		.buswidth = __buswidth,				\
+		.dtr = true,					\
+	}
+
 #define SPI_MEM_OP_ADDR(__nbytes, __val, __buswidth)		\
 	{							\
 		.nbytes = __nbytes,				\

-- 
2.53.0


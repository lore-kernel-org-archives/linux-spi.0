Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6662643BDB5;
	Thu, 13 Aug 2026 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608058; cv=none; b=N1qOU3xaYovd7CwuJ6PDaCMvAVCouCTwVm6cle3EF4hZmTo0vQmjtI7giHQaBpL5cZWrrw7S8G3nqNefdchvJXt+9CCqFiqQbwgO7cVw1eDinUjTefvl9PKOCaT4PyH3DsZb0eOSf7f8aaBHc5FNNJTfSRSElNt0xLb8lSDZ2bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608058; c=relaxed/simple;
	bh=Y6GyRy+pYwVlujyYu458ZLcw0pidccVC75fZb2hUsC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kre9aOjHAeRgqK3cb/H7oLHuKvmYCKOi/eWixy3YIU6X2hG+5rdA8yfSXPcdgdawNS2H3wjP50kOfzUpzQzuYbgahTCin1yGwQCnAzuIRxlf9iunuYQ9yaMlYOIHbjuPtk4O1nSVQ7AioYQ4kAZUppPWlhc/IDycFwxrUOzRv8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=beVUD+L0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="beVUD+L0"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 896DC1A15F0;
	Thu, 13 Aug 2026 08:00:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5E70B602B8;
	Thu, 13 Aug 2026 08:00:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EAB3011C4DA82;
	Thu, 13 Aug 2026 10:00:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786608046; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=V50cHfNVXO7uf9mb9fH4B1oU3NTB/2Ru1jMT/LE3OM0=;
	b=beVUD+L0htQxAeOyD+aibag5BufjMqNXsaV6iGVbTrUpPVr6IVnDzn+UYLD7F8JtfghM1g
	2WtZo5RGM6ypbRBvAbFdgMHU7mcSDUFT2/koNehb3kRcmD+MIC0/9xJqA4H6Y3ZGKM8aio
	AmtdZ7rSAUjPy2GfF83Y+1/UC1oY4eeKHV1EiVPeGSBoBsrfLh/ob7KtbqP9fsjki5tRLe
	kkKLRcNAslbvtio0MDy7ZBw16Q4U+hbanuOxtJDfYnVMYIoEUYknDCP5BXzcYy3yC3izzN
	HpF7ya91N02K9H2yIlxkrbfWYkcUzLpRGRzGBINuv3mPXerdEcoQPcnN/aPK9Q==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 13 Aug 2026 10:00:23 +0200
Subject: [PATCH 3/5] spi: ma35d1-qspi: Allow several command bytes
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-perso-ma35d1-upstream-qspi-v1-3-b217b9870eb1@bootlin.com>
References: <20260813-perso-ma35d1-upstream-qspi-v1-0-b217b9870eb1@bootlin.com>
In-Reply-To: <20260813-perso-ma35d1-upstream-qspi-v1-0-b217b9870eb1@bootlin.com>
To: Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Mark Brown <broonie@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Steam Lin <STLin2@winbond.com>, linux-arm-kernel@lists.infradead.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The controller is capable of sending several bytes for the command, it
does not even know this is a command. Just mimic the address steps here
to allow double byte commands, which may be needed for DTR support.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-ma35d1-qspi.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-ma35d1-qspi.c b/drivers/spi/spi-ma35d1-qspi.c
index b4fd0ab4bd31..027a9433f2b1 100644
--- a/drivers/spi/spi-ma35d1-qspi.c
+++ b/drivers/spi/spi-ma35d1-qspi.c
@@ -395,9 +395,6 @@ static bool nuvoton_qspi_mem_supports_op(struct spi_mem *mem,
 	    op->dummy.buswidth > 4 || op->data.buswidth > 4)
 		return false;
 
-	if (op->cmd.nbytes != 1)
-		return false;
-
 	if (op->addr.nbytes > 4)
 		return false;
 
@@ -459,8 +456,7 @@ static int nuvoton_qspi_mem_exec_op(struct spi_mem *mem,
 {
 	struct spi_device *spi = mem->spi;
 	struct nuvoton_qspi *qspi = spi_controller_get_devdata(spi->controller);
-	u8 opcode = op->cmd.opcode;
-	u8 addr[4];
+	u8 cmd[2], addr[4];
 	int ret;
 	int i;
 
@@ -470,12 +466,15 @@ static int nuvoton_qspi_mem_exec_op(struct spi_mem *mem,
 
 	nuvoton_qspi_mem_set_cs(spi, true);
 
+	for (i = 0; i < op->cmd.nbytes; i++)
+		cmd[i] = op->cmd.opcode >> (8 * (op->cmd.nbytes - i - 1));
+
 	ret = nuvoton_qspi_configure_bus(spi, op->cmd.buswidth, SPI_MEM_DATA_OUT,
 					 op->max_freq);
 	if (ret)
 		goto out_deassert_cs;
 
-	ret = nuvoton_qspi_txrx(qspi, &opcode, NULL, 1);
+	ret = nuvoton_qspi_txrx(qspi, cmd, NULL, op->cmd.nbytes);
 	if (ret)
 		goto out_deassert_cs;
 

-- 
2.54.0


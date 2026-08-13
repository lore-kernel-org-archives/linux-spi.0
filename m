Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B7743CE66
	for <linux-spi@vger.kernel.org>; Thu, 13 Aug 2026 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608070; cv=none; b=iAjz/ggQ5QN1mFDI1BHRp7OyIIZ5N6nCJBJueRQ11yk2srLDegyyki/q4CozITC7teqCmXYRhbzRZPmG+mUpV0phsMLvrrR0lQtzGqYnj/NdTEGBlmwQD4NUz90VdnOcP7fI3fzufDiVLWCFhgXOpI+CglC3ush8j4d0oRZlDk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608070; c=relaxed/simple;
	bh=nK/NHuU1xXkaVbgaeuL+VrC9Bacw7Wnb6/yhTL5rXvc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MjEICWFJcNiSihg3s+Emm1H2n94X3eic6DKDr/ERovQMKHh4MWSkT4z0YVIW4rWEDJ56Yu6hnW41ekvl0eaKxh2Xv6xAAb45Tn+r8drfCl5ORHpKsp/OHH6Bd5eeXRaBom+qxpLbYE6Y/sqkqccN/jAhQ2s4w/wJ7bg2Ygid2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1dB4TCyi; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1dB4TCyi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 745094E411E3;
	Thu, 13 Aug 2026 08:01:03 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 49918602B8;
	Thu, 13 Aug 2026 08:01:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 81A9511C4DA8E;
	Thu, 13 Aug 2026 10:00:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786608058; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=zj84OFZz5gnRYignK4t6ga1YzryGPYdWrXYJ76F0Jgc=;
	b=1dB4TCyirgki1jlciw49iYZSNvLXgM7koNktnDBZ611HsvioCX0gRZAiKyKx9a40KIbJC/
	JHoUGwNV77a/Vw4/88K5I9nyU3kzvgsfoaS1T/ffkUBxx7FBsnUqSIquXB8VoJs5mQZSSC
	dEoBEQXLKsZ60ZbvnkGixXC6XTgWl8jepBtTD8WaCxi6M97cmLaCQqSo/K9pQhKxuRrrho
	4MlCbI1EMeH/Bg7VnRS8D5+BqfWOQesZ92bar/EEMS9eJ29+AFcZZzoTmHrs4oUlmQo8WX
	p+7WJGxXy5fBaSATaYUFno78WuIdzSmPXx4eQPfMbac+8F8LrjETyusVy2zmDg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 13 Aug 2026 10:00:25 +0200
Subject: [PATCH 5/5] spi: ma35d1-qspi: Use the existing update helper
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-perso-ma35d1-upstream-qspi-v1-5-b217b9870eb1@bootlin.com>
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

Read modify writes are already covered by a local helper, so use it.

No functional change.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-ma35d1-qspi.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-ma35d1-qspi.c b/drivers/spi/spi-ma35d1-qspi.c
index 9965a11573d8..7f938d0c6f1f 100644
--- a/drivers/spi/spi-ma35d1-qspi.c
+++ b/drivers/spi/spi-ma35d1-qspi.c
@@ -115,10 +115,11 @@ static int nuvoton_qspi_reset_fifo(struct nuvoton_qspi *qspi)
 {
 	u32 val;
 
-	val = nuvoton_qspi_read(qspi, NUVOTON_QSPI_FIFOCTL_OFFSET);
-	val |= NUVOTON_QSPI_FIFOCTL_TXRST_MASK |
-	       NUVOTON_QSPI_FIFOCTL_RXRST_MASK;
-	nuvoton_qspi_write(qspi, val, NUVOTON_QSPI_FIFOCTL_OFFSET);
+	nuvoton_qspi_update_bits(qspi, NUVOTON_QSPI_FIFOCTL_OFFSET,
+				 NUVOTON_QSPI_FIFOCTL_TXRST_MASK |
+				 NUVOTON_QSPI_FIFOCTL_RXRST_MASK,
+				 NUVOTON_QSPI_FIFOCTL_TXRST_MASK |
+				 NUVOTON_QSPI_FIFOCTL_RXRST_MASK);
 
 	/*
 	 * Give the controller a short time to latch the FIFO reset request
@@ -356,9 +357,9 @@ static int nuvoton_qspi_hw_init(struct nuvoton_qspi *qspi)
 				 NUVOTON_QSPI_CTL_LSB_MASK,
 				 NUVOTON_QSPI_CTL_TXNEG_MASK);
 
-	val = nuvoton_qspi_read(qspi, NUVOTON_QSPI_CTL_OFFSET);
-	nuvoton_qspi_write(qspi, val | NUVOTON_QSPI_CTL_SPIEN_MASK,
-			   NUVOTON_QSPI_CTL_OFFSET);
+	nuvoton_qspi_update_bits(qspi, NUVOTON_QSPI_CTL_OFFSET,
+				 NUVOTON_QSPI_CTL_SPIEN_MASK,
+				 NUVOTON_QSPI_CTL_SPIEN_MASK);
 
 	ret = readl_poll_timeout(qspi->regs + NUVOTON_QSPI_STATUS_OFFSET, val,
 				 (val & NUVOTON_QSPI_STATUS_SPIENSTS_MASK),

-- 
2.54.0


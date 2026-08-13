Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0742943B4B5;
	Thu, 13 Aug 2026 08:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608050; cv=none; b=flLTFjvZ1FCEl5ijZ5ZCh9mWT11ZMGR7NlEmzFxKnXcPuxx+aEQ02JgVJPZYcoKl5xKDcyrdtYarOHOtsAiMPiD8UY9BVS8TWEUAdHYSVrzQ0YuIosJ3/Uw5gJkGGJs2Ln4PO/gKCmp8w0E1vYWd8rFfCOGbwvI0A0qTS/tmPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608050; c=relaxed/simple;
	bh=yHdmiAPQ/DLjafhN20LGUa1e7GGdEALSGNUKB9tN76Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UGY8Wz6q9kGlw4NNyhBgqfWfgox2W4qFFKKnL777c001a+J5jDky8PsioRyid1UiUcSD6/+xqCvKuZONVCz+/O0MlWWU9Ma9pnqxRa0+lswmlU1N7mHvyxTggmS8vifbUxpoZlKuQKqYb7FORCSlE2UQd77yORb2S/8hVpEFDIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bb1b5FEI; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bb1b5FEI"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E407E4E411E3;
	Thu, 13 Aug 2026 08:00:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B08EA602B8;
	Thu, 13 Aug 2026 08:00:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5993711C4DA89;
	Thu, 13 Aug 2026 10:00:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1786608036; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Mj1W4Xh6Pt/T1x73ejVnasGPl6YiZcBTAo3uVZZ4NOU=;
	b=Bb1b5FEIZYGBz0uAdmssUhx5XFWabH/TcHg7k5nqBIOsBpbBvirf22v69K97X7FgdzXckZ
	flVYaixqOcd9U/A7oMi3o6gCvy1tTIg/d7araEKDUgVSYtUM1p8Upfe5j2saWulaJtfMPP
	08ZWLAXw9Xa2GyB5JeBddmOJ/PwYXTSqqoNlxEXeWblu4HltHCt2TF8h5hKxj2zx8kWCC5
	6ibH3Yti1balIiHyYxai+ClTjjR6mSObVqro60SRz109Ild5duXolQhFOoP7Aor/hibQ2V
	0fqErLPm1hLZ/Kf/u/K5X8hjN3CwFZFRKwCKs7SyhpHGp0WuVcPwSzY85PWkHA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Thu, 13 Aug 2026 10:00:21 +0200
Subject: [PATCH 1/5] spi: ma35d1-qspi: Remove redundant reset operation
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-perso-ma35d1-upstream-qspi-v1-1-b217b9870eb1@bootlin.com>
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

The bus width is always set before every operation, no need to reset it
manually at the end of each transfer.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-ma35d1-qspi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/spi/spi-ma35d1-qspi.c b/drivers/spi/spi-ma35d1-qspi.c
index 541d5d72484c..929546dbe38f 100644
--- a/drivers/spi/spi-ma35d1-qspi.c
+++ b/drivers/spi/spi-ma35d1-qspi.c
@@ -502,7 +502,6 @@ static int nuvoton_qspi_mem_exec_op(struct spi_mem *mem,
 	}
 
 out_deassert_cs:
-	nuvoton_qspi_set_bus_width(qspi, 1, SPI_MEM_DATA_IN);
 	nuvoton_qspi_mem_set_cs(spi, false);
 
 	return ret;
@@ -556,7 +555,6 @@ static int nuvoton_qspi_transfer_one(struct spi_controller *ctlr,
 	nuvoton_qspi_set_bus_width(qspi, buswidth, dir);
 	ret = nuvoton_qspi_txrx(qspi, xfer->tx_buf, xfer->rx_buf,
 				xfer->len);
-	nuvoton_qspi_set_bus_width(qspi, 1, SPI_MEM_DATA_IN);
 
 	return ret;
 }

-- 
2.54.0


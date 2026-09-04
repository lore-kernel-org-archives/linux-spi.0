Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE204A3F17;
	Fri,  4 Sep 2026 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788538534; cv=none; b=WXLHoIs8DLFFNuZpMTgWF1aIBAfH0Y0sgK3W0v5Nyo0uv2iEHT+/+djOri/RVOBuFr7jw91KDN9J0RMC9IKLXycK7m8bdXBzWXzKa2JPciwgxRCxPMTtwPsHA3pJ5UDdQRft9Lrpb3py3scTib8YhVr8qjWFEqTQktYJwirR9gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788538534; c=relaxed/simple;
	bh=jXlLT8SaK+Ps3N5vV4xJEUHEU3WB8mRODl7Q9bkHRKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rraqdV1rK0Z/e/k5R3ZJ0QPzVzPpc3LmP0NIUr1cpo4EED9KuiToeW7aPUCpIdU2WSWbhJ3t7awTa5X6l0GzBC6V2ViDtzA05vYuJDWqwjeTMMoFgyMrduj/bOpqRo/1OzjmjgzsDstqOlPoGR7FFlURtj6W02cKgoldeho6pFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IAl74W7I; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IAl74W7I"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 16F961A19AB;
	Fri,  4 Sep 2026 16:15:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA2B36057F;
	Fri,  4 Sep 2026 16:15:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C09211C78767;
	Fri,  4 Sep 2026 18:15:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788538526; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SYNMh+wlYQbXqey/rgOB5yDcItmOFPFcTITbDauYbKE=;
	b=IAl74W7ImszHKs0rHmLq7TC01B3a+fipQqD9OUxGgAnar6XLleRvLssoJa/mjAme5IvCUg
	fz4n1vWwsLgHlEbXwZkqPlxG2nfPVcoC5Qq6hS4hvzn61FID2DVqso+cNUKTx7WQgR5/Pj
	wyNBOXVQLrby+Azn+5uvOAdJUYWFbQGtXs4fR9YfK/BRlBGO771PasLZarWIyvWIfqtpqp
	4KbSza2273Afyy8XYuHkRqYsHFywo6n+TQQIa7OkNJ/auftcZ92cgvYoL+m0RMxsIO+ob3
	oJ5AAhX3nzcfiDQIxlnz1h/6+r18+80n3l4eeL0F2ocVyUowS8QOxFO1xn0THA==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 04 Sep 2026 18:15:11 +0200
Subject: [PATCH 2/2] spi: ma35d1-qspi: Allow DTR operations with the
 regular SPI API
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-perso-ma35d1-master-v1-2-b6936e8c6fa1@bootlin.com>
References: <20260904-perso-ma35d1-master-v1-0-b6936e8c6fa1@bootlin.com>
In-Reply-To: <20260904-perso-ma35d1-master-v1-0-b6936e8c6fa1@bootlin.com>
To: Mark Brown <broonie@kernel.org>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The feature was implemented but not actually enabled for regular SPI
operations (as opposed to spi-mem operations). Make sure the missing
capability is actually set.

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/09c3928f-4b58-4ac6-8e1a-84dfe3ff6b92@sirena.org.uk/
Fixes: 15e9362f6190 ("spi: ma35d1-qspi: Add DTR support")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/spi/spi-ma35d1-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-ma35d1-qspi.c b/drivers/spi/spi-ma35d1-qspi.c
index 7f938d0c6f1f..ee3427640f3a 100644
--- a/drivers/spi/spi-ma35d1-qspi.c
+++ b/drivers/spi/spi-ma35d1-qspi.c
@@ -645,6 +645,7 @@ static int nuvoton_qspi_probe(struct platform_device *pdev)
 	ctlr->max_message_size = nuvoton_qspi_max_message_size;
 	ctlr->mem_ops = &nuvoton_qspi_mem_ops;
 	ctlr->mem_caps = &nuvoton_qspi_mem_caps;
+	ctlr->dtr_caps = true;
 	ctlr->set_cs = nuvoton_qspi_set_cs;
 	ctlr->transfer_one = nuvoton_qspi_transfer_one;
 	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);

-- 
2.54.0


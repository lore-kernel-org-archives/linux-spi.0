Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7F818FDBD
	for <linux-spi@vger.kernel.org>; Wed,  4 Mar 2026 12:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628460; cv=none; b=tScUNDK8hSJ57T9Cn+xNn9W8DoIZb/YiwGJTMRsEe0OIQaF5Bsh8ox9QNim15YXtgMl8rOm9hUIqkmcG7m+Hmki6Z2WzE5bQtmj7gf9qSYweg69UtHlUDVnAbLV2cLu39CinUkNKcgbyjOovLQKAX+Fd5iykOnfCC5yKEFViagg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628460; c=relaxed/simple;
	bh=bhwo7r9j37LyAs4Cos8ri5eXa2weRve1tYt/Mk3XGVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a7lY78Z2AUwM+UQdMLtENmLrG23X6pWakOvQAD01pPttvNWkaZ8ncTMX8tekHDaxdEpw8eLZuiPG04QvD/fVJnwuY/dO3XGeXRXQUcsj5PN2owB+9FU0gQQBV5Y6SM8lh62HGHXdRnMZgNSQHtFz2pqwvqo+B7yeNOiBPPFfrlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cp/ak8/W; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cp/ak8/W"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3598c008455so1953357a91.3
        for <linux-spi@vger.kernel.org>; Wed, 04 Mar 2026 04:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772628459; x=1773233259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gqJ5CYeF/S+wuXTqSQYoaQnBXp96lA01eWpg1TT40+g=;
        b=Cp/ak8/WCQ0KnkrRfKqT2b53aBpQGoR7Jn7KUXn7s82FO5Wi2ddDnmfAdlDHvFC7GI
         zXDaH2PsePZBgNdhOjtHrsLkX2mR61wZxvO7nNm30VBAJ5PrR9eEQUyteGIwfZ3CiNEA
         9u/8YZKEygvKPU+KqHbrM8Fgh1wCyP6vi4b0KUliwtwzeLMHweUAeUIsxt/OCPXHIVyT
         3Y6bKvilO4TqU3WTkg4nG9twwZKv3SJbbwZlWuD3S1QGebdo6svWSlOLrfh0OeH4WMmj
         mD7dlxo4CU2iVzAzS5md1GfuLtLJYU8FFZjdD73DDA+7E0+rGt3+hXD/FH2iBJ5WbiUj
         JFsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772628459; x=1773233259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gqJ5CYeF/S+wuXTqSQYoaQnBXp96lA01eWpg1TT40+g=;
        b=c8jeEVSCutd0eDuKikhT69r8GIzcysc1cKz92XWfpBuDRxKIZfckyg8Sl1+V/CP8yf
         dmqvLhSDwj53G3g2WCBFiNSHmP4h5M9iDm0fy0FRoFnsFiYUD3PYJ1vi7dM2cigZUPpB
         kKfrMJwD54QyS3TR9pZHMzYqKian7DnmgV4KupY4UXVQoOAEtaR6POL7PhEA+EvmLF4/
         C1u1YA1+pGe7MRLs+I5ihQDnjRoTeGqzsdoNTM8MUWpgzZ91DP3gR0flXyWy53BYsvNE
         GeUYUVmoimdwyAyYzIlTjLP4G9LZJMe1/A6JPK1apQg8bpGn2aBHtHF6gM+ZfS6ipBDz
         UppA==
X-Gm-Message-State: AOJu0YzDCBTiW86OXPaD09koknI9pJ6VaNKnHoCotNnOdhm7yfPDKhIf
	aPNMiyBbpS3hS7Y9N2dO3JDcFY7va6RutY652pVdtSuU/zGqDuZWIVZwGZIV9b2xt44=
X-Gm-Gg: ATEYQzyKmUBIXGxyGUjr9OkjbMG3a1gchzJ1ZkFp9BMtx/fGZSAbR33Htsn0T69Cvu4
	+jztyXXHq5BhAHsGZC/BiKZpiPaqX0IAC6vWoTUFJBfb4aSDccDL32hUtW0+hERQnFN2wrZpmQI
	gHJzLQMrX3V9HHGSXKSyIoKTixdT6vCIzElMNrFywEClcowd6KN/9tPLQ42W5j4pnMGCEkoeWJw
	0hzSFcVeJ/AbCEgRmbxOG/6R9jDGQC9Zp7rUXWNbLwLvTH3mrZ4oEddsu/HK7sSWst6IiUesvj/
	wwgBrMs7yU4ctt7YzZx56rrh8+XcQNVhv15b54lDq54aSZx8hjCV32uVlnkqiYVTfV/0yeiY4xe
	wLOyM49kEtKZWexdV+Q0Wi+MfZuEY4+QNFYQrPF9Ng69N1800Rak8SPYORyYylFNmVglP2dyz8G
	BMRTS0nhl5idwVpp2dsfCavD/5gHvhYa5JIBmmumJhObTUgqY=
X-Received: by 2002:a17:90b:4e8c:b0:354:a662:47ff with SMTP id 98e67ed59e1d1-359a6a851a9mr1665118a91.35.1772628459128;
        Wed, 04 Mar 2026 04:47:39 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:c48d:9c04:d04e:c13a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0625sm5000450a91.13.2026.03.04.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 04:47:38 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 04 Mar 2026 20:47:19 +0800
Subject: [PATCH v2 1/3] spi: nxp-xspi: Use reinit_completion() for repeated
 operations
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-spi-nxp-v2-1-cd7d7726a27e@gmail.com>
References: <20260304-spi-nxp-v2-0-cd7d7726a27e@gmail.com>
In-Reply-To: <20260304-spi-nxp-v2-0-cd7d7726a27e@gmail.com>
To: Han Xu <han.xu@nxp.com>, Haibo Chen <haibo.chen@nxp.com>, 
 Mark Brown <broonie@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
 Yogesh Gaur <yogeshgaur.83@gmail.com>, 
 Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772628443; l=1530;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=bhwo7r9j37LyAs4Cos8ri5eXa2weRve1tYt/Mk3XGVE=;
 b=UXeHZ7i8c5JkwX6pvPTKD0/+H4rZvNXPd4odiwy7izmbwaQIhobe5vN0odSCPtB2GwkiVvVdT
 yd7yQZUlfIzCwmRpJyL7jb47up+yXAW3H/ST92CfQtRicN7Lo3jKNp1
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The driver currently calls init_completion() during every spi_mem_op.
Tchnically it may work, but it's not the recommended pattern.

According to the kernel documentation: Calling init_completion() on
the same completion object twice is most likely a bug as it
re-initializes the queue to an empty queue and enqueued tasks
could get "lost" - use reinit_completion() in that case, but be
aware of other races.

So moves the initial initialization to probe function and uses
reinit_completion() for subsequent operations.

Fixes: 29c8c00d9f9d ("spi: add driver for NXP XSPI controller")
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-nxp-xspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-xspi.c b/drivers/spi/spi-nxp-xspi.c
index 06fcdf22990b..385302a6e62f 100644
--- a/drivers/spi/spi-nxp-xspi.c
+++ b/drivers/spi/spi-nxp-xspi.c
@@ -958,7 +958,7 @@ static int nxp_xspi_do_op(struct nxp_xspi *xspi, const struct spi_mem_op *op)
 		writel(reg, base + XSPI_RBCT);
 	}
 
-	init_completion(&xspi->c);
+	reinit_completion(&xspi->c);
 
 	/* Config the data address */
 	writel(op->addr.val + xspi->memmap_phy, base + XSPI_SFP_TG_SFAR);
@@ -1273,6 +1273,7 @@ static int nxp_xspi_probe(struct platform_device *pdev)
 
 	nxp_xspi_default_setup(xspi);
 
+	init_completion(&xspi->c);
 	ret = devm_request_irq(dev, irq,
 			nxp_xspi_irq_handler, 0, pdev->name, xspi);
 	if (ret)

-- 
2.43.0


Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B2F1B6D08
	for <linux-spi@vger.kernel.org>; Wed,  4 Mar 2026 12:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628470; cv=none; b=fDNE+P0eflZfRtzBpwbdcEtW/O9PYxH/EKG4nIbHYtSS3Le6SraTC0W9gWRYPmk6B14uPeARU+KklANY6WMNdxZ6ScUFUZU2xV+yM5fd4JxRoAoIlK7vQABT0pR00RbsF3qSz4hn8WfUwsm6L5N4prMbC/lJkfrf5pT2hf2Xgpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628470; c=relaxed/simple;
	bh=I4vOzBPfyRSgU37i3aopPtXd8O/uvXcLF9y6LnFAAr8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fVI1UOacmb+6V1gvCzPnBH39Z5M7xsvbWiMb5tPD5D/A7iN3bmjGUFlwN1sBrUy8WxG9UQdd7Gz3QsO4OiRniQY/ao5VpTeXFkHgHUaaeODY+cBJ8V+vIasOy4wdY66qipXXRRe8P2kjT6B8+1Qd2sZ3SWKjaxysLP8o1zg9dzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JB+hiRac; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB+hiRac"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3598df39444so1935910a91.2
        for <linux-spi@vger.kernel.org>; Wed, 04 Mar 2026 04:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772628467; x=1773233267; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tH0w/azYrKeQPVCZ1zt90CBX6B2rnF1FZuHhCMgUyjQ=;
        b=JB+hiRacDbzsZbe5rAi5HzMOUoPScV5gZfK0T5aj163OOqFOAvZDwd96cvdeljSP/V
         eY+OFp2imE0RJaH096Mi3XqumtsHaCkONi4nKmRcw2jGO4A+P+nHoFirynhYjZbFSWin
         FyP9MUr3M9XdX1RcCXP06kVZmg0QnVqfS6kC11CbqSH1EAMgjGNYYTdYrHw1i14ucnDc
         uwMMwfVAtLbK80bmir8LoTasJwCzrBLlFp8O18fCbflUhbGpEhTzWmd6ylAstzyBmiPK
         NPiLRuHqVM/s3GuiilKlqs3wwuqBjDLqbvwVeZoZXObJ28gXNmbkmy1NZpTxKYEZ9ai6
         TUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772628467; x=1773233267;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tH0w/azYrKeQPVCZ1zt90CBX6B2rnF1FZuHhCMgUyjQ=;
        b=O+Nfl7hp3EdThz/6/TzMFzRLgzFGjI6ww8fFfy/ch9iucJxJ8D6rEC61a3vWc1Aaa5
         nDLfZd6pkR4nWjAgRORZJetAAViTbKiMEAWWrztpRXbMH1yWtBdEO5PIFueygTjuxpcF
         KqM4uGDAMkCxNKRjQesUcOZLlu5UxN+GcdUyr6BRmfWhtDX7Fmvq1hAwseI7sOG8FUgM
         1JWzEP/JfsBa1KqGLxDCcbZU5v+zb8eSGP5fznz+ZzP94BOo+K/UG4+pXcFF1+6CRmn+
         t1GF8OpfnLWt1TY+OGwRK+5lg8RJmMpNoKfhS3IARn8UM7KWji1h7m9PvxXoXAHBDcAe
         XZAA==
X-Gm-Message-State: AOJu0YwE9sqj5zWK37trvzzg9lOSTieRrT/eeRYCBtqfizd7EksL5uJH
	gOy14ssOIMfbMf2/ZFVySIw2IGS28Mdddj/QRNmEBWwgshwLjl/m4FhJ
X-Gm-Gg: ATEYQzyRHo+BTpl84o0Zjr6OTn++ylfgdejCHwIDa0RJ4mvm5U6ytaFWf5hE5of8z0i
	r0Ux4nzVul17Tv83M+N41JzcEguFBV9vk+kFdwvAOFm/sKRiS3IpdcN1Ly01a9PbcW7sy9zBtbd
	wwdPuP8ACBN2dEel25A7takHxtjkIF4pc6TMrn7PvtkfzPgkyvWECcJ8s03owWPhoePKkcrgL1j
	IZsqBmPlll6ZiHr7boCXDHQTSHDNsDjEd5NvK3jdf+rFse4+YEMrCB7b4GQMWQV6oywzSI/qSlF
	vFYudDygSm2UCiKKVOicx/QkZtPZmzjwdK7K8pmPi3Ne9EBP/O1rx5aT1TNQreVBTjlhG+hZM1w
	o9yLQpKNFNkYiJAhlASbo9+YeYOPXlD8MDi0TvY2fPW7/BHJHVA438dTCUIrdgwAdnPfN4h5QGN
	TchIjbu8aIcTOR2OnR5dTGsI5jaSr9SP5OtSlX
X-Received: by 2002:a17:90b:4b0b:b0:341:6164:c27d with SMTP id 98e67ed59e1d1-359a69a9621mr1926831a91.3.1772628466940;
        Wed, 04 Mar 2026 04:47:46 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:c48d:9c04:d04e:c13a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0625sm5000450a91.13.2026.03.04.04.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 04:47:46 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 04 Mar 2026 20:47:20 +0800
Subject: [PATCH v2 2/3] spi: nxp-fspi: Use reinit_completion() for repeated
 operations
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-spi-nxp-v2-2-cd7d7726a27e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772628443; l=1518;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=I4vOzBPfyRSgU37i3aopPtXd8O/uvXcLF9y6LnFAAr8=;
 b=+d38z2mcF5Zfsco/fBNqzjJQTm1HzU5pjmt2nyVbqbt58+MfVPZ6k2e7b+nSvIsSE44r17bZb
 Ff7Z2kvb1uZDFhgUbIYroXvqGEJXEHeLroYd5j1pY8Eco6ed7Inrp1l
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

Fixes: a5356aef6a90 ("spi: spi-mem: Add driver for NXP FlexSPI controller")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-nxp-fspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 320b3d93df57..1e36ae084dd8 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -996,7 +996,7 @@ static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
 	reg = reg | FSPI_IPRXFCR_CLR;
 	fspi_writel(f, reg, base + FSPI_IPRXFCR);
 
-	init_completion(&f->c);
+	reinit_completion(&f->c);
 
 	fspi_writel(f, op->addr.val, base + FSPI_IPCR0);
 	/*
@@ -1365,6 +1365,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to disable clock");
 
+	init_completion(&f->c);
 	ret = devm_request_irq(dev, irq,
 			nxp_fspi_irq_handler, 0, pdev->name, f);
 	if (ret)

-- 
2.43.0


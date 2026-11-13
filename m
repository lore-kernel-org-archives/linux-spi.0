Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588450;
	b=ODpLDdzz5GrDAhe+G/N+BK/HAY9v34t3iBtwZKlorgO2tngczemwPzklJdYSDYn3rs1K
	 WkWBPJ0n8c6Fo2EPnbdIUjnMZEVmWfVvQh8mPn9P9dtWS9oatRXe+iLBaccTPPGxqynti
	 fvm3BQWYXbkUVd6gFBh/yCMv33iAEvncMZTjx+5/oYx0RmwW5b6WH5JTna+B8N9eLwUXN
	 h2C9y3vdgPP2mfApcETd29WgafoxzX49GznORUpg8tM/XnIdEc6qFSs26aJenLwcS1r0W
	 kXLUYoooKfl7CRdvMy/FbQHADptLHk3UOx/itdVGBYnC31WYk45H5ZpFRW1WtiaaLPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=5A95SHcauoTnuHojbhqI9VffDrdxRgwLa4QkgyckIoA=;
	b=jOsCITWcSkf1qbLsz2lz3650NbPjAlDFuqjTGFQ1wzIwKz5ovKNTfdAKkDaYqs+iulGA
	 axNIgnwsQk/EwPJFTAMhBWZZqsudLBRweYPmVTLJwyloaXO1MiRgdbQpth/3eejGYAZd2
	 jRkT8+YwjHhEZEc67Mlkqn6LiFlWl+Z7H/nTqHpWbgOd9bm7sYx0OYdkY1OlWMXzdnPfQ
	 EXQL9snyMdN98FYnyPnk/8s0Zq+41G5tDpHfhHpnloxUTXzSX37XW6FQEkzGiK1Cz0ubQ
	 lXA6g9nUHHMqvQjSMPa8uyzD8AiWnjZhNR7kMYFH2xxKal2LC6lQonwHcJyPwF+POXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jlfjqfLf;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B5C606A881
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 16:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05B5C606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jlfjqfLf
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso1577280a91.1
        for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 08:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794588449; x=1795193249; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5A95SHcauoTnuHojbhqI9VffDrdxRgwLa4QkgyckIoA=;
        b=jlfjqfLfYOy1yFLSilCSpkrKAGpO52d/W8N5CvfIvgF9xg8ctmCnObko507JQk7OtD
         2MAUHkf83N1p0ojbIKNYQLSHweUidf6UP+DYAOskK7J0gyLR80KqcIM+4ERXRttlCpT4
         kHC8EYq8VErFwOm1iYGiuz/UmXLuwlRjLxTCI4pGdt2WSmLFYRi4FwYKas/lHaJVw/a4
         V7cEQ0mbn8Bu+DDvRElYNoczoOP+KP5fjQL5AobmL/8IfYDvL38IgZHVcWJj/a8e4UUV
         dqMSQQYLptGT+TBS3VzDx+pntiw5AExtkDo1F/Dv2y4E+hatnI3ObDBDMs07WG6aJ6k3
         9oZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794588449; x=1795193249;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5A95SHcauoTnuHojbhqI9VffDrdxRgwLa4QkgyckIoA=;
        b=oWyiGZjBg/C076zCG0Ak//jwavqe7o6XdZANLxpJAJaUok4i2l6uUx/k+gOCg/Mc7h
         FcruYslf/5pBkTg5fvSzWJSlmjJBXms6D2couAUMyUHq19IEwhUHzQxsC+73HBIpWwsS
         wHKY7rKtkbsVZzWxXoamZ691hvXa9Dp3O/Ih1RFZhqQcj9gicvJU7TL5Cz+EowT2tunR
         k7HP8U8V4r3hH1LfEt4KDTT8+aZlm3ad8G//YeWR6VOwCr2TTGFFIdX2bC3hwELBo93Q
         CIv+RAUti8ZArdQvgvlgDlAhLeoAkMHTDJ+oes2iBwo7ppVtnQD/SdkWR+BfEizJDPHC
         6SRw==
X-Gm-Message-State: APuU4Z8iYzo/kt7mIlqzFlCq18YwI7+K3+KLpfMawoPLZ994E/+95Ffa
	w/ErlDFnZ256pRAKHpBdklmD47/b201BkHw3tYsL1L/y4fXDwLRhpIXX
X-Gm-Gg: AYBFou1Ff1dAoS8FFylUXusmmC1Sb6BZV6ZV/DWiHTo0O9YLSkvjeWBUJgNmmIlBj5z
	EOuprCN8J1n72VrbNu1ckEJeovsIyGti2UF3F9lG52F2PCGPHCKXpWk1Hr0qNYdYmmhGXx6o6vH
	wjnDdmELmK/q2MXJqa+Ag56IxjWyGUuG/kf1I0bHGquePES6lRUUWUDrtG5X04psWltc7wfZGkV
	AnKXlcYqx+baFIPaYYo2hD9bfOG05t5lruePgTmThmGK8NvYa13up6Dpa24Aca4PEhTn7Iadq2s
	bqVnrRx2PzLeL7nwU1K3JAHKNzBB2Fz+L1xEmOryWGNEw9uAWcxgp+MLPPQWguqr5BoXO6flZ8n
	ANPXSu6+jkuas3FwQiYl2Lcs7HLz0O384Vv916Sf3U9Ei9cAdsNjGpBtSVm5WSLEf0KeDX6MryK
	fSKHw8uxG8SQIMPokox2Ze/hhaa8GhctQSbkwRHXetCDbVTP52CV7ryK6b1V1Zw+gw3s1yZpCMd
	sNvRYngkbexQc8nWRWoGcvbr8TbvVHFggTrQVbnHTA2j3cDrZJ9hiXdtacd0yu8myJQkGc+CI+v
	yiw12V/YWja0frgnn/s0zp+AQpPjsMBQcQ/2wOuRqPRJFvkVSMDqU4Gd3tKRcrzTH/GMPe7bCoz
	vhp+XITtOFHW96ma81Rata2RnkQ==
X-Received: by 2002:a17:90b:4b88:b0:3ac:80de:44e8 with SMTP id 98e67ed59e1d1-3b1b0ccc955mr2999783a91.43.1794588449260;
        Fri, 13 Nov 2026 08:47:29 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:b6e2:c438:aa16:9bcb:8e43])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3b1aeb179fasm5208924a91.4.2026.11.13.08.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:47:28 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Sat, 14 Nov 2026 00:47:18 +0800
Subject: [PATCH] spi: sunplus-sp7021: use
 devm_reset_control_get_exclusive_deasserted()
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-sunplus-reset-cleanup-v1-1-115e32fe8c1a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTtJhyAQr2JcQP2RIaQ2HWpMC
 He36vJbvLeTISmMLtVOCS81fYYCOVXk5yE8wHovptrVrYg0bDnENRsnGDb2K4aQI7eTOzedG53
 0oNLGhEnfv+/19rflcYHfvjM6jg8hFew4eQAAAA==
X-Change-ID: 20261114-sunplus-reset-cleanup-6f05470b018e
To: Li-hao Kuo <lhjeff911@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794588443; l=2080;
 i=ustc.gu@gmail.com; s=20261030; h=from:subject:message-id;
 bh=JcZjEJ1TO/syuDGRI66mvFtAh2Bdb9V+mCpS/CvpiNg=;
 b=0ZOADtSIFnLqUjn6nFxYBbpXzP7GerWKdiSC4u2ccRs/jro+2b1l2OrKvkF8aH6tzL9ttaNjT
 YDdXrg0g4ahAefejX6yx9y/+UBqmabD6ku+cXGhPs8QRJd6zBx7Kvre
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjDJtbnSeysEBjmOfNYqYUUDS6g7Tfov9W5oGngTBfo=

Use devm_reset_control_get_exclusive_deasserted() to replace the
explicit reset acquisition, deassertion, and cleanup action registered
with devm_add_action_or_reset().

This simplifies reset handling and removes the custom reset assertion
callback while preserving reset assertion during cleanup.

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-sunplus-sp7021.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-sunplus-sp7021.c b/drivers/spi/spi-sunplus-sp7021.c
index 54431c363bbc..abb272dd7250 100644
--- a/drivers/spi/spi-sunplus-sp7021.c
+++ b/drivers/spi/spi-sunplus-sp7021.c
@@ -393,11 +393,6 @@ static int sp7021_spi_target_transfer_one(struct spi_controller *ctlr, struct sp
 	return ret;
 }
 
-static void sp7021_spi_reset_control_assert(void *data)
-{
-	reset_control_assert(data);
-}
-
 static int sp7021_spi_controller_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -463,17 +458,10 @@ static int sp7021_spi_controller_probe(struct platform_device *pdev)
 	if (IS_ERR(pspim->spi_clk))
 		return dev_err_probe(dev, PTR_ERR(pspim->spi_clk), "clk get fail\n");
 
-	pspim->rstc = devm_reset_control_get_exclusive(dev, NULL);
+	pspim->rstc = devm_reset_control_get_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(pspim->rstc))
-		return dev_err_probe(dev, PTR_ERR(pspim->rstc), "rst get fail\n");
-
-	ret = reset_control_deassert(pspim->rstc);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to deassert reset\n");
-
-	ret = devm_add_action_or_reset(dev, sp7021_spi_reset_control_assert, pspim->rstc);
-	if (ret)
-		return ret;
+		return dev_err_probe(dev, PTR_ERR(pspim->rstc),
+				     "failed to get and deassert reset\n");
 
 	ret = devm_request_irq(dev, pspim->m_irq, sp7021_spi_host_irq,
 			       IRQF_TRIGGER_RISING, pdev->name, pspim);

---
base-commit: 793807ca13bf3072fc6d16ce6d90e9ab9beff2a5
change-id: 20261114-sunplus-reset-cleanup-6f05470b018e

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>


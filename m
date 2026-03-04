Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC0D1DF256
	for <linux-spi@vger.kernel.org>; Wed,  4 Mar 2026 12:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772628474; cv=none; b=qjH/lGe2G3qDMcA/3OoxgpKiPN6rhlugLbDOhv1xCNqi1xTws0iV6m4lSXxxN/LbIzzAMOLB8t0ec2QoZxuGUG5X+w9UhMYt58FJfJf2X070ywHvMnyJ/nF/l1QTiPxV/r49wFq6e2GVFJE/t4gDJWlFVFRTSkwZgqTVCvNvEDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772628474; c=relaxed/simple;
	bh=I4G5BmiSRVnXsdaiwq2zZZ8p2iMKTYQ+oZxjqJ+xHa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUv8w16LZGmbe1F3NWOQYuW8foU7jPNSJH+aIYNC7wcS6JPF04mHZjle5tUrm4K9ld+PWsURUKYxXl2MqV8EtqOfEADByYOLplcCffxbGeur+kjqPRtoCtSu9q5rXwBTWkBKV9EO+Zy89oRB+iaulIlzE1u3RPBn2JjQawmUcDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNWGGQuA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNWGGQuA"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-358d80f60ccso3144434a91.3
        for <linux-spi@vger.kernel.org>; Wed, 04 Mar 2026 04:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772628473; x=1773233273; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pXrbV0EXDox64nj0mJqXgXN5XJkcx97TQuO0RxgmpN8=;
        b=jNWGGQuA1FJiQ+3+qQa92d8rjiw1l+jgJ4XqzTGN9OsoFw2CN8s6ox/LazUdGyeuTJ
         ZabBnXZoQmg3hVbmzLX4GH2buEgL+wKre1+VIc2zptPsTOjOq/WdhULAF2hrnK6RJ2UD
         JL9FWs7WXxKbneXQYJwttRLKmMy9QnDEp73AwFiBV2tmEHx0G35EpWWgevi0uNG9Woj8
         FVwE/iEivO2KNRfkHib1kxR9MojreWMrHcx4L1I6374jFB0mACqB1z3wvoroOonVBjMM
         s8CwLlppdrchtmwWAqUSqM33x5t+z+Sv6sStcrqGvSTdmugkaTsdLA/LxF7BoVA8/XG1
         E5lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772628473; x=1773233273;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pXrbV0EXDox64nj0mJqXgXN5XJkcx97TQuO0RxgmpN8=;
        b=XO0tGk22e6qPi9nlv7eA/Dp1B4szep02xSR4RgEnc/NCLU/UyP3tQ5zlYL1+oznptI
         UdD77yyjL/o1cd3r3wV231wBb8bxFiehYaXVeh5C3/zKpyU4CyjeJPhobw2iYiGDn0Y0
         kEVVk+NSho0w3TCyBoD4RLUmrNCEY1X0b1wNnmEXy+aQNhH+43gPxZ+R13u24eGbjF+M
         7HFm6w+MbRf5j6gUkQM+DCLk6ExCrXTa+m7Mt7/psjsqwYaIVWpeGVRNOMs+VZFqobxz
         Q5RFMvtZshIr/qgGEdkAEsIKKoPhFWLazheNE+ll+RFLeB7KoytOD5vOZDJbfbJaPyF8
         dvPg==
X-Gm-Message-State: AOJu0YxEnkUvvuoIFpIwXYcdZ4XSviwkJ5ABIbSn1Afdq3FWzuj+65c+
	IEQ19mmQJ/QAr6mFnJGf63WZhEva41Pfwkl578jxZdrGiVuK1zTWSpHz
X-Gm-Gg: ATEYQzwM5sk6pXLdSMFV11CbD8oUUVBkGiGxMHzt4eNYWWkpdnrJavG6DOvQcCe/Fu4
	sPywzfaRagXIf+6hQoafaFVBCBUwVtJw6G0VjwFLd59aluOfFV6EWVpw+0BsRtpvmg9PO6FJ03r
	+iBauo9/e2kdtqYGsp3ov/2PJ4F1VGoG9bRGhkNlNn3sQ0vEKZ0mgP0mKlYVFrV/UU/OLUs4Ozb
	YAHaMNhAFhTeB5B51P9sDz5rp8Aq0m3n9rqMivds134DyszUyiEKWIfbFENFEbKPN4/FWWTC/RG
	wqGD2q8ABbEOYSbXWFOW1hhjJkAl/9NYRraI/vPNcEefi5WONZp2u1XbO+IqAFROGI/O1Gy3ho4
	tXrjG/6DVuuBcJ2/VJ2DACWxYgF2L9Nb8NUlvau/9FGjh0Xu9lH0d6WyjvZp9txc3nbqGhJyOym
	olw3d1OqOpQKtpNWgDcLY5ruF/BzD1Gr0docFF
X-Received: by 2002:a17:90b:5630:b0:34c:fe7e:84fe with SMTP id 98e67ed59e1d1-359a6a6433fmr1633791a91.28.1772628472939;
        Wed, 04 Mar 2026 04:47:52 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9009:3f2:c48d:9c04:d04e:c13a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c4c0625sm5000450a91.13.2026.03.04.04.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 04:47:52 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 04 Mar 2026 20:47:21 +0800
Subject: [PATCH v2 3/3] spi: fsl-qspi: Use reinit_completion() for repeated
 operations
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-spi-nxp-v2-3-cd7d7726a27e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772628443; l=1465;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=I4G5BmiSRVnXsdaiwq2zZZ8p2iMKTYQ+oZxjqJ+xHa8=;
 b=cJacyzDOyUDA2/PYdVXT/xwkdqZtYGL92jgOWdz/UHbRz0p1Vee9zlUm0eB+D2wf9urWa55bX
 Dl/LD5HOTwmDNyfe1VujlN6zBz8uoMBAbxcOfG4c99bRs7+xjA+zsa2
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The driver currently calls init_completion() during every spi_mem_op.
Tchnically it may work, but it's not the recommended pattern.

According to the kernel documentation: Calling init_completion() on
the same completion object twice is most likely a bug as it
re-initializes the queue to an empty queue and enqueued tasks could
get "lost" - use reinit_completion() in that case, but be aware of
other races.

So moves the initial initialization to probe function and uses
reinit_completion() for subsequent operations.

Fixes: 84d043185dbe ("spi: Add a driver for the Freescale/NXP QuadSPI controller")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-fsl-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index a223b4bc6e63..57358851029b 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -633,7 +633,7 @@ static int fsl_qspi_do_op(struct fsl_qspi *q, const struct spi_mem_op *op)
 	void __iomem *base = q->iobase;
 	int err = 0;
 
-	init_completion(&q->c);
+	reinit_completion(&q->c);
 
 	/*
 	 * Always start the sequence at the same index since we update
@@ -965,6 +965,7 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	init_completion(&q->c);
 	ret = devm_request_irq(dev, ret,
 			fsl_qspi_irq_handler, 0, pdev->name, q);
 	if (ret) {

-- 
2.43.0


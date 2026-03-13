Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE0832C937
	for <linux-spi@vger.kernel.org>; Fri, 13 Mar 2026 13:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773409980; cv=none; b=Vb7ASMqkNPMMg7oN/9ytiLOUlgIgatZjwbvqaqEx0Af5UL0ZpX0mF3ZWo5BcrAzAH1facQHBGRjcX23eSCGUdBTYT6dVUxkizL2fsWlB+NcBr0t9IVBoBItCR3aNfp2Gdlu0xQjSBwD3uKPcEo0KJyIbp3DSR0d7Xwud5lYQ+uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773409980; c=relaxed/simple;
	bh=l0zF3ej8aQms2XTunb0vRjXBt1VP0mDbI74gU5Fkie0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rvo8pB4NPz0MHZknO4nLb7UOVI2SvQgfuxDWaAehGLSqDpC/hlBrTUBtOWdN0NaIE+Qt9/TuuSUnh1Zp2RfV7c/i6w9fyxjJg+RQCucpWCmhmHdx18hQTKFmyo00xKl9AzCLRwILS6fdQbHBsHcas9gPo4+ZBEk1/Evj/fYxFPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/qvAEqr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/qvAEqr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso19977295e9.3
        for <linux-spi@vger.kernel.org>; Fri, 13 Mar 2026 06:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773409973; x=1774014773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dX48aVLfTgFvgth3UwNoAcH/+u5VTaLKWTUPbGKCPbY=;
        b=W/qvAEqrNLJfCc+Nn6Rmr7/Ar5Iq4HQ0V/tpYpizC+C3Z4Blr4Af38Um7UlKJTCUEV
         DBAL2Dg8wJXvqozJcLmXM6HlI3eSFCQVXwe5GXaSf/AtmIw720K83PxLjNdGkCM7a323
         YSyZUc2A95r1YON0pjCDEHOO5/kAikHZmpFX1zkw+fIAhJ8WGnOnPIbssjwpe32AmWcG
         O6WZ3UmTgAX+cyvYp0t0N6xAlAxEXWaeJCq7hBVxXca5isZ70jmSz5pKH3UzzrgV1OF2
         zLeeyJIqhtTaln8tbevWOc2d4ObQcmjumQ0CVGpF5YBLZtcKb/qatSWnwfvD16ugTRlN
         tfVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773409973; x=1774014773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dX48aVLfTgFvgth3UwNoAcH/+u5VTaLKWTUPbGKCPbY=;
        b=T81+AQ3ndWvvRExisNeHijqvzfRF3fOWeiPKLLlUriLNyBB1VPD+Xm4w7te+5O7eBg
         hydr6vgl0FobvEhclk7y2+CF10rZRa4XtTLHI7eEOI357QiNbhTXCfjeAgY5Igy8yxYr
         FSwHR+I9xryCG9gnGPm7sqd6BDnZXmg3KoivjElAiGmmpVsp+GBPt8A2HgOvbJk8GGpr
         iC5tWUz0yLcuz0jIN9NZXq6OzMuonO2FdeLXjqWWrJhtd0DRpj7Mv0TykS4mTT1SR8yy
         YHXk+JPiXyJ2gQ5OHW/im7AtDO3LM1QGkxnA4C7piYHqdtN43QJTQyo8ep/PvGIvGuod
         uQFg==
X-Forwarded-Encrypted: i=1; AJvYcCUAZvAF5KCCs8GkU4DuhZ6M1JzD/vhq0nlK8XFiQYya3iK/EHDoD7PTGrU22aLxr36gkdGKDmzxU18=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvGDd82Wm9J3uNCkf9sac18zVLaKa6WBsqC0R2sBn8TkGoCd8g
	GRYLc+UAsLpMx58F4wnKpSUhCjwA2/cZI1qbzbFOjhnzy9+Yf9Z0a8kP
X-Gm-Gg: ATEYQzzEorzxmt07Ugw2IWf1garZ/Kg6K5319sNrb9XFlVEwvQN9JUikq+h2KK02Mk1
	Inyti01C34xpSvHSlT3WVc974w0sPl+Huut+gI53OeGM2SwiXQ+Co9CfWs4PzWT2A9fChNrWPpL
	3c6KMKM7RORVWufufF2SMPlCsxiWcB1+2rjUMbKgU+H2Qbwy7JiVwt8svHeYwjqTYjD1olMuWcG
	wKdf9KSV7MyISdrPjEQE7KGgHWSmacrnm3vGoeBvzL1U3Szf7rqi1viUmcd768y/BzyvtrpSaVb
	J5r3u2ArMuEGznwJkU5DvyRQuBHbxKyQm/u7eXMx7EiJq+rjJXDdczXvBgbZ8GxmuPBQABHTfFd
	E441Ft9XFYI5nKAP1S1N6wXjB803NKpE4DMhNZ8nJFIWl/lNt3t2qIBaQyOvu5cegoKgobNM/5o
	OOVs3UfQXDyDIQd/p6jaBsDaciB5+NAP+avRUyqeQmWlVvDePlUQ//IbTP+5VqHQRIXzlX
X-Received: by 2002:a05:600c:1395:b0:485:2fc5:3a5 with SMTP id 5b1f17b1804b1-48556709d85mr52860705e9.26.1773409973305;
        Fri, 13 Mar 2026 06:52:53 -0700 (PDT)
Received: from emanueleg-nb.. (93-34-120-147.ip49.fastwebnet.it. [93.34.120.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48556414295sm39850805e9.3.2026.03.13.06.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 06:52:52 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	a-dutta@ti.com,
	s-vadapalli@ti.com,
	mkorpershoek@kernel.org,
	khairul.anuar.romli@altera.com,
	stable@vger.kernel.org
Subject: [PATCH v1] spi: cadence-qspi: Fix exec_mem_op error handling
Date: Fri, 13 Mar 2026 14:52:31 +0100
Message-ID: <20260313135236.46642-1-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

cqspi_exec_mem_op() increments the runtime PM usage counter before all
refcount checks are performed. If one of these checks fails, the function
returns without dropping the PM reference.

Move the pm_runtime_resume_and_get() call after the refcount checks so
that runtime PM is only acquired when the operation can proceed and
drop the inflight_ops refcount if the PM resume fails.

Cc: stable@vger.kernel.org
Fixes: 7446284023e8 ("spi: cadence-quadspi: Implement refcount to handle unbind during busy")
Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 drivers/spi/spi-cadence-quadspi.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 5fb0cb07c110..2ead419e896e 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -1483,14 +1483,6 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (refcount_read(&cqspi->inflight_ops) == 0)
 		return -ENODEV;
 
-	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
-		ret = pm_runtime_resume_and_get(dev);
-		if (ret) {
-			dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
-			return ret;
-		}
-	}
-
 	if (!refcount_read(&cqspi->refcount))
 		return -EBUSY;
 
@@ -1502,6 +1494,14 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 		return -EBUSY;
 	}
 
+	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM))) {
+		ret = pm_runtime_resume_and_get(dev);
+		if (ret) {
+			dev_err(&mem->spi->dev, "resume failed with %d\n", ret);
+			goto dec_inflight_refcount;
+		}
+	}
+
 	ret = cqspi_mem_process(mem, op);
 
 	if (!(ddata && (ddata->quirks & CQSPI_DISABLE_RUNTIME_PM)))
@@ -1510,6 +1510,7 @@ static int cqspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (ret)
 		dev_err(&mem->spi->dev, "operation failed with %d\n", ret);
 
+dec_inflight_refcount:
 	if (refcount_read(&cqspi->inflight_ops) > 1)
 		refcount_dec(&cqspi->inflight_ops);
 
-- 
2.43.0


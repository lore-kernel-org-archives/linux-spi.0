Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166803F9277
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 10:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001010; cv=none; b=lCQdpY5FcxjoL6uKpbaH/ZXwpFMFWma1elqpxzp//wGfd/OYhKhCsdWIAg3snpnKRNXQ03c3jLp/Olk98IUgPq7RsHFHyZ26omSjuKZEZ0DiWhOMnvUqZjXFlFs5z/oNl1qEw1rjlQgnefSEugYCUmtcK72OjzPk9pV7Tu/Mn9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001010; c=relaxed/simple;
	bh=L2oliIFC4oKO91SZyPLNwn39SqJ1zt98y4XKspRGfxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UXTWc/5MBwcHiowZudspcuYiLMrg/LeyS/X9SmYvmghEPt0NlMOJJuJRAfSnNJTSlXgShp1CPN2bcyh4Uqe4EE9cO1DRhScaDH0u4SxNG/Tay3aoyfR7Q0z7paIk5zlhTnWV+WQPK7DIzHAyDfxEKtCA+UWsIThcnYhGBChwuOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ie+3PcQK; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ie+3PcQK"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c8583b8fd89so3277624a12.0
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2026 03:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781001008; x=1781605808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hHqL/YSEXhmKRvM7PhCW92N+t8/AtMxfb6dfA2XpOXc=;
        b=Ie+3PcQKDFyzuMZjJd/xEUGt9HZQfaMYDWkiqm+y1J2X5/QyWL4JxOInpfN4aYcHlC
         fC5PlsSx3EjdlwCC7h7J17XW59iRtdQqXk/HF3MQ/nmfnoWIkXAZPB0JQzXG5GLrzHEQ
         nG5fJcnhbXWns0I9SqPxsMAI82lFTB6L52GysqbPmfxIGZ+oT1JdNWgW3KZu4EtRDXKJ
         rgMJKCgGlZ0542gL2cgwozd+4d6PXnjSb0wxxpZqt1jinZsstnbYKk/gqsr+yPo8zzxS
         AlHSLvwuOltmXmqb6ZUKrnaxLF+D8CGXEAn52WfXy3QXlAEfHlPnGxd7vBlHdK30ky2P
         QY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781001008; x=1781605808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHqL/YSEXhmKRvM7PhCW92N+t8/AtMxfb6dfA2XpOXc=;
        b=fZjM9oL7O//wpg9RgKnpsj8AvZhlJMNBwVayN47xKc42bv1pzwAlkN75bFmjD/bFBN
         u9CIVwbE92kQRtvN7W2lYZDSmBIknOnRY6cuMxrtmQWNX8y97X1FFOL+QhCemxPPlnKy
         Zg2K8Py80PI2qQU4JEdieUrLmiP74s8zEALwlVGDxNDNqOtDg+ZHzZenYfidXE29fDHy
         nVmtKB0aRPi3N5nc6fscimLNHQEOeAaJn1SP5CDY30+gG8EFzmFkDCF2+6yX8Rby1zpg
         RIUTrjVvqnY+QEt+JTfHDHM6s/DFS0OSCuRKtgn7QFfg3JSBVA+zwCoDbFesny5ssKA5
         vRcg==
X-Forwarded-Encrypted: i=1; AFNElJ8m6+AXAVq5lhOGS4laRuWQJ2O8QZCZt/wpy2VAiZu50S7zivfRoFIL+KVN1es/lLbkCGJwsBQ6PpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRjJ3wE7/O0ZDu8fvldvDKaoQEZE2MjqZiQXzgv1hVL0ku6sA6
	GJxE2yHCInKWOUK/1dkH7kjNTs7zvLHFxcM0ntvJ9bcnWUr9FLL58UBtS5wPHOZ7Nl56AWum
X-Gm-Gg: Acq92OFAp2RjK1gmEgQDYbPsNSMqR6LDbRuFmhj6pLsmXpjaJvfX5O2N4alNI8/jLhB
	jFI5ivgAQiktwbL2cg4/YFUiuiNzIFGkBXb10D6dPNPcCoceR4HytwBgtsej3qfRkuyLjIJZghj
	o/+FL5liUviLK9jfyxRi531bIgx5s1EjJ/y+PLbn2t0de67LH/cNzZtXhX34CTNMrpIBEjb55bf
	bh4Rlj36M/O75lF5GEwbZNCVZ5dbI3RZbk7VwobvnVdI3u7uxs/xPD9fB3Bl62M/uWJbatXrV0X
	moNduqexa45tlptqtx5f2aJiqIOGIKqA+lpOoHFdI2Zync3mvuL/0DwC2+ceUokp2t1eRKW9RgZ
	CntFKOwdcDeNG93HzRGjfhqP/jMAtLrysBzeaTcdc/BKO6dXjG7VFzzgdAUpCBYvvQcgssoFKgy
	UGLlGzYSm4DkCKwgMVDXibDXiHCn4=
X-Received: by 2002:a05:6a21:9d4c:b0:398:89b6:1b41 with SMTP id adf61e73a8af0-3b4cd066bc8mr23132697637.32.1781001008433;
        Tue, 09 Jun 2026 03:30:08 -0700 (PDT)
Received: from Dell-5540.. ([2001:926:3:e0:b19c:a6f:385d:df2d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df04ff24sm18328762a12.14.2026.06.09.03.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:30:08 -0700 (PDT)
From: Peng Yang <pyangyyd@gmail.com>
X-Google-Original-From: Peng Yang <pyangyyd@amazon.com>
To: Mark Brown <broonie@kernel.org>
Cc: Serge Semin <fancer.lansen@gmail.com>,
	Jonathan Chocron <jonnyc@amazon.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pyangyyd@amazon.com,
	pyangyyd@gmail.com
Subject: [PATCH v2] spi: dw: fix race between transfer IRQ handler and timeout handler
Date: Tue,  9 Jun 2026 18:29:55 +0800
Message-ID: <20260609102956.2811-1-pyangyyd@amazon.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On SMP systems, dw_spi_handle_err() can be called from the SPI core
kthread while the IRQ handler is still accessing the FIFO on another
CPU. Resetting the chip via dw_spi_reset_chip() during an active FIFO
read/write causes a bus error.

Fix this by calling disable_irq() before the chip reset, which masks
the IRQ and waits for any in-flight handler to complete via
synchronize_irq(). This ensures no handler is accessing the FIFO when
the reset occurs.

Fixes: 0b6bfad4cee4 ("spi: spi-dw: Remove extraneous locking")
Signed-off-by: Peng Yang <pyangyyd@amazon.com>
Suggested-by: Jonathan Chocron <jonnyc@amazon.com>
---
v1 -> v2:
- Replace spinlock with disable_irq()/enable_irq() as suggested by
  Jonathan Chocron. This avoids touching the IRQ handler hot path
  entirely.

v1: https://lore.kernel.org/linux-spi/20260522095727.18307-1-pyangyyd@amazon.com/

 drivers/spi/spi-dw-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -468,10 +468,12 @@ static inline void dw_spi_abort(struct spi_controller *ctlr)
 {
 	struct dw_spi *dws = spi_controller_get_devdata(ctlr);
 
 	if (dws->dma_mapped)
 		dws->dma_ops->dma_stop(dws);
 
+	disable_irq(dws->irq);
 	dw_spi_reset_chip(dws);
+	enable_irq(dws->irq);
 }
 
 static void dw_spi_handle_err(struct spi_controller *ctlr,
-- 
2.40.1


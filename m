Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E613B777D
	for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2026 09:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912797; cv=none; b=jWtWCQSf6U84jENGHAAzETZGb7OBuOQO2o4eUZV7wBNDJzUpZiZhnFWTu8xOBDTEoaHLO5EtYk2sVWQEzfHaQ20wXKK8G84jaaAQA8JaW6sN1n6qx78xPIbm5vaHks/aCtiqukGHaXjg3PspvWloOKwyUC6fFgspMG6h9czqOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912797; c=relaxed/simple;
	bh=3DMHlif6D4DfLvCePQxsIN4IqNVqfqYm9sKyNXeKoEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbxyIRBoRQdS1UbHlznkbDiTKo+RoPzCnvOP8OzF8e3m0i+eCf1f61uZa7054XOxwxmvZA6HmTg/AkWe3Endp4MUWmbIM+9e77mSOXW2HtZrLQ5aI2aN3NCMTpeZUq/j/OnI5ck+wTPFQQc+0SeJiTXL7LFKydKEgCMPtortUQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxiERF3V; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxiERF3V"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2bf18c30bb2so27528575ad.0
        for <linux-spi@vger.kernel.org>; Mon, 08 Jun 2026 02:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780912795; x=1781517595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVd2AaoJGqTRVKwD7P0aNxJISugeECwM8N4yUGguhWk=;
        b=jxiERF3VCseTQhwv5zMgTqQwTtLamXTc7GbXqXyKTMdV4PvNfZ7Teisr5K/T7m20YM
         y08ZTqeR+NxRUKcswU3njsfE7EdaU/snaqkOtlUe4sKQ5Kg4x04iJWqUEbOY1wk0KZGq
         ft5pXewM1svErYonsT+ogW3M05AWDKE8hM/xv7LoWyg78Wnx4jHdnaIKcc/Q0rolBdvH
         KdVDxp1LuNAHN/SD3SDQxzp87PwCFDWP33Q8ztslbtMrYxK4cvXwRThKY47kleln4ICG
         3rzV4UbYbgi1lEf0mOVtRgQzkTVCzF1I9UKsiPCLq4oIQYwHWdfFT7KzykF+KUewTDXB
         Ymbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780912795; x=1781517595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mVd2AaoJGqTRVKwD7P0aNxJISugeECwM8N4yUGguhWk=;
        b=FeyYES90ygt+rWsxxKB5Kbp/AbJd0o73TkppYrghTRwag4QVGVz9C+w6+iGLqu3MNk
         PvVd1b9/3Q0aECUBP8xY4Wjq4UXAJ5gNkGBett6sB/4fmGuRYEV+xfytHnDBopia2Ec8
         KZrHaWx0MGzj6c7QUCIgAQRq38CAoKil/p2fI657IrUndB7bInkAMkw9rUdl+Rp07Eas
         +3XSEhrogSWjgL4U46dLgofG/mLsxOzBThj1CXHdC4RD8IziP/GYwCPVFMAdQqpzflTr
         j+0ufDE/MxATK9Z3uFjjsKhMCthEypAgj4svMGst7ln/q+NZVoEvqlF5piWThtG7xXNQ
         4miw==
X-Forwarded-Encrypted: i=1; AFNElJ//iCPfMqEYp8yA18cDVPnEGoMAAuTsI33Sjd/COUZRvmcTbOV0ljh43LmWuJr5PS/+VC8T4vCSGBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+45d63sW1XCkw+WhAJOK2ew5N/XYKydWwlQY7sBEPEP9Oxqw
	/wXtW+EeRWihz21cdeUOSPmRUBW72luTBKj5ia3EGuHa2T/fxrfvSiRU
X-Gm-Gg: Acq92OEIPDvbDx74Oypz7weSDHJWpRi17lPGfuKgO/h29aHxCrQD0wo9hF72EbXgfvV
	A7UpMAbFnIOPkGlY3/sVYCKC+q2ABtMNb9dhdDmJi4yXp8ppIdN5hbd8zE9e+K7r+EIMtb7p1pH
	91Q8bk0y/5JjLDBm6j0HVkukIgDw54wVnMLgJRxLHg/Jw73YlsvH3PsxDTy1pccQnmYZ7raGszs
	mpeECS3c/hgKB/jkfiytd99YgU2x2VSpjSK9XWkavKUUNMjqnIFsWyV4EUL4BCqb42RgvugKScC
	YEC3Zwb8zg+u/dqLws80/jUGQ2J/dl4xUw63Cjzf/s2QwZQUgRydPZ4YUxfNl/HODRp7vh9QBpP
	/BPtIzCvJlAt4jV//5yyXf6v9m3MSSyN5WfhVxsbIn8aH64VEzXvCOwKivD7wQeZCCNn8M6DCdh
	oPXxSPHP/LbzP1AJQdvAZIKqsMDj8=
X-Received: by 2002:a17:903:4b50:b0:2bc:b80f:6782 with SMTP id d9443c01a7336-2c1e821dd0bmr148842095ad.11.1780912795021;
        Mon, 08 Jun 2026 02:59:55 -0700 (PDT)
Received: from Dell-5540.. ([2001:926:3:e0:fcd:c60a:85be:2fba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f87920sm178573055ad.24.2026.06.08.02.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 02:59:54 -0700 (PDT)
From: Peng Yang <pyangyyd@gmail.com>
X-Google-Original-From: Peng Yang <pyangyyd@amazon.com>
To: Mark Brown <broonie@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Jonathan Chocron <jonnyc@amazon.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pyangyyd@amazon.com,
	pyangyyd@gmail.com
Subject: [PATCH v2] spi: dw: fix race between IRQ handler and error handler on SMP
Date: Mon,  8 Jun 2026 17:58:49 +0800
Message-ID: <20260608095849.3446-1-pyangyyd@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260522095727.18307-1-pyangyyd@amazon.com>
References: <20260522095727.18307-1-pyangyyd@amazon.com>
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

Signed-off-by: Peng Yang <pyangyyd@amazon.com>
Suggested-by: Jonathan Chocron <jonnyc@amazon.com>
---
v1 -> v2:
- Replace spinlock with disable_irq()/enable_irq() as suggested by
  Jonathan Chocron. This avoids touching the IRQ handler hot path
  entirely.

 drivers/spi/spi-dw-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
--- a/drivers/spi/spi-dw-core.c
+++ b/drivers/spi/spi-dw-core.c
@@ -486,10 +486,12 @@ static inline void dw_spi_abort(struct spi_controller *ctlr)
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


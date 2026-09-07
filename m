Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D014CCDEC
	for <linux-spi@vger.kernel.org>; Mon,  7 Sep 2026 00:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788742673; cv=none; b=GQePCltWe5bMh+Mu8DBgQcBOpK85BiIWMYtfHvV/O/qv/SN8sNk+ms/yMnsw5km1EjPlEFENhlkKJVlrQMN5fJhBJX6j1CMTbsIRsEz+FyXGOwZ+Bny/GkAle9Stj7cN6mq0ZKlVnUoGFUmPXwNUedaOjGqnKAjEdEd9Td/g+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788742673; c=relaxed/simple;
	bh=AZjom2PB7UknyQo7QhwjHMw2wFDh4BjnRhyJ255BnGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXWIfGz6/voBLGZEMs5cujsp8Gg/S7g90Y9hq6CSXZyf0zeaa9MeBs0D9sYwip9eZG61ZYoyXRNrXYcHQc2dWmKRbXGT3E//cfzOsI/LQLjMTnLNBeph3ztBGZAvACaLo8gldQZfMiFamm69c1TIWUDmkrBevE+EabAR8TxTp/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpaAu4Cd; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpaAu4Cd"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1bcdb3c4cso1937800a12.2
        for <linux-spi@vger.kernel.org>; Sun, 06 Sep 2026 17:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788742672; x=1789347472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9KBRkywu7hyFM0XGKbQfON7bqnqwREZTWQJYpAcPCSE=;
        b=fpaAu4Cdv4RTm6b59pTmqomJgi50fltH3/2znfQKDt3Vf7LsegSdBqy7rpPlKvVDQ1
         13DyNStq81j0beBE3l+ErgNnrlBHMOZ9s8e+vrMktr966WfpcqLldVZEWKFw5KQ90Y/P
         OKI1cIvuDzgdL7E8f5ufCHVKHrEWFxDdN6pjZVe5e2eQAVMgurX0GGLGQtR31ydOOUPl
         szse+PDsbW7am+gtIAer8QfU1Jsze3smFqlEjxTRJ4k1YKXlI/ko0WoZIuIsMIvXmQ50
         QA5S6yQTfJ7rjtP+I6gXY2cy4eKmtVWn8GAYTvkX7dfBr6qxi8XKvtY9Ph61decIg+as
         DXvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788742672; x=1789347472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9KBRkywu7hyFM0XGKbQfON7bqnqwREZTWQJYpAcPCSE=;
        b=Ea2u1Kas1GIc75kpi5GISumgwNs0KjVdS72MW2FR2+6XrGb6afzKv+YUJE6DJtAo6c
         CfwfIKUp8DEJUtH635EaUPIXC+igX0batkEJmnonVGX33NuEeaKQRv4oYMqrA+JpVgLP
         3f3Yii4ET9yvufVA7PJMmAx0wfCmMM1tYr6Ron3MlQJS1W4Mj/eAnU9PDylGhc5HcK0f
         2y/NYlVOIRn8zPqvI44MJCtB/xZJ6lb/X3M1/NGS4oCPEajz9qpLnw5FKZTo7sZzMTDr
         SDlzjAkyIezUPZCUrbx1nQm6Z2NT5RNl7w7gb7nDn/E324mXkZh5RVExMJZ62IssO4Gr
         nlRQ==
X-Gm-Message-State: AFuF++lXtT3hgZW1Qy1feiC9NiWhM8WTQ3UU6nvQqNXrSIDCEwDjoaUr
	kPxZcnL71LM2nZf0Y0KXPm7hELarO4DgIjvQ9lU8CQShT/lBwArrm2r2MBhA9A==
X-Gm-Gg: AYBFou1pDfmHJF89sili3m8B+XEj7aQVfv+nkA1TBOat8M6TajrrFFs5EJUrB3byEdk
	DkKmSC+mAyBceVLih79Xr338ECdr/uPdmXe/IkpFn7whsXwDaBHeHoObq6iKz2qZT9flJMTj1rW
	ahHN1YzluqnuJeP1rnkfCLE4EDdsQkYmSnRriMKvu0mTyqZc8/KP0IXK96nGNFoc+KfImsPWBxs
	WbPvNZjbTCC21qpEcnITF1bBpdOXlJRk26WYKuTUfJGzhuDtPBzDPs1/WgSGg2JnSWcQfiCDvmN
	9lV/miJsOrro2MT0mK/GUYK4Qjb5hIRwRbIumKzE8WzHNi1PbOLWQpyPRuMOki/69t0ULRSUWm1
	IM1WkEyEStAP+TTdA469Q3D5VB1NlXqRNYfbFu0qP+G0TeWEOcCvjEitCoT6EstNdwNFpCfaJHW
	NnBQ08tLxWNT2/Jz0bq7Rnc/H6nAsK4gyLf6RKC6+x+1cP42uCUIMlLugiCvct1yH+Q/W+iwDoZ
	ktUMfkJH3ro1jbETEikc9AkVF3P//6vks1Sr4Ubk7++Hn8/BlBG6NcAR0ft+ub5P37JHaIzdTUp
	OicSTKgmrTQA8JocL0YxGcuOpB2hPhcu4iygIQ==
X-Received: by 2002:a17:90a:149:b0:39b:2b10:d05c with SMTP id 98e67ed59e1d1-39b2b115ba1mr20193005a91.5.1788742672057;
        Sun, 06 Sep 2026 17:57:52 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b2612ba2bsm16853496a91.14.2026.09.06.17.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 17:57:51 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-spi@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [PATCH] spi: orion: yield to scheduler in transfer wait loop
Date: Sun,  6 Sep 2026 17:57:50 -0700
Message-ID: <20260907005750.230103-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

orion_spi_wait_till_ready() busy-waits in a tight udelay(1) loop, up to
2000 iterations, and is called per byte from the polled, byte-at-a-time
transfer path. On SoCs such as the Armada 388 (e.g. SolidRun Helios4),
which also run SATA over the shared internal MBus fabric, this stalls
the CPU for the whole transfer and delays servicing of SATA interrupts.
Under sustained activity this can cause SATA timeouts and link resets
(sometimes renegotiating down to SATA II, 3 Gbps).

Add cond_resched() to the wait loop so the scheduler can run pending
IRQs between polls. This is a no-op at runtime unless the kernel is
built with CONFIG_PREEMPT enabled, where it lets other peripheral
interrupts be serviced during SPI transfers.

Built with LLVM=1 ARCH=powerpc; passes checkpatch --strict.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/spi/spi-orion.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 26a9f268b2d3..b8882229c054 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -370,7 +370,16 @@ static inline int orion_spi_wait_till_ready(struct orion_spi *orion_spi)
 		if (readl(spi_reg(orion_spi, ORION_SPI_INT_CAUSE_REG)))
 			return 1;
 
+		/*
+		 * This is a polled, byte-at-a-time transfer loop. Each
+		 * iteration busy-waits in a tight udelay() loop, which can
+		 * starve other time-sensitive peripherals (e.g. SATA) of CPU
+		 * time and interfere with them if they run on this SoC.
+		 * Yield to the scheduler between polls so pending IRQs can
+		 * be serviced.
+		 */
 		udelay(1);
+		cond_resched();
 	}
 
 	return -1;
-- 
2.55.0


Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F16481A8B
	for <linux-spi@vger.kernel.org>; Wed,  6 May 2026 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778092523; cv=none; b=YYyzhupmDI3DKYzHWfvXlV3aTG7ajxlRtbWwWItYSOfZD2I7l5QiufNKjXL2hfUssdhYJDFky/o/PR4qIxM3KtYC5RIZq3m+1yG3MUxajco0VesyMN8JjJzyEy+DHi2n/yWSykzbXjEsqbruyAsSuOxyZIC3S7c5gEvm3E6lblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778092523; c=relaxed/simple;
	bh=+WMqCy21w3Lz7NVM3I657Lea12MlKzLhBcyc8rycgYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D1vlKEqPQ9gUK6lCCMgmh/PubSUSpJLZCBdY7SWZVOUTt3kuzNFmmxjc7DTehY1Pz4Qmg3fz0X18ejqzQB1oyEU28/cNBrxC6oyzv+PgWKwkhMQTE1ebB0/g5IH8xIuAW+JXZngXjPQmiz2Y61EiqagzPTFyonJly+esn2XKUvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUjRk2m+; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUjRk2m+"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48d10c981e4so39085e9.0
        for <linux-spi@vger.kernel.org>; Wed, 06 May 2026 11:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778092521; x=1778697321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9aiXsZhpAfPQ3ReCQcd6NEJTNdjNAL2vg0ii0mpvxDg=;
        b=kUjRk2m+OcCTNMc3PYRVG7Pkxt/btwHZxBMzmMbOJBDpi3AnknmXMKwehQtNmbLrW8
         1p8ZlNPbZOqvFYyU61egrRYv28F0hs16kqJdjzWFJtFVh9vSqQ/sWCvs04ADzWwELqid
         RndDWe6RgxxdSLIiFEqL5TQlpzojPdQS2g750VDBubqIMm5LyFX8LafAooj2sYZAbmhP
         DAwEUyg8fJZ3FdgZ/CbH8fEuZ0YCGeeRAL2QLDgAgWR4XxUr1VF21MQCX9AL7W6QL+YX
         HrVStAa2RdSw4pg6blqgKtCM5KqaSTtyU1GmJ/4d3TXIBXLLbkK23Q9NIMM2dZU/zoWr
         SCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778092521; x=1778697321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aiXsZhpAfPQ3ReCQcd6NEJTNdjNAL2vg0ii0mpvxDg=;
        b=SWFOh2rLMDJaoZAHxa7VmDiwa37jrMhgmmQNaLaNCdh+sIu6PV08Cii79seNPp1UUS
         4+QGJbhKt3jG6AlCkX7kS6A2hxKbD8K6VrBgc+bqzRHzW8iGNfTvDjCxwBYPbCTY4nI3
         Wcah8NZu+lLyjuZXWxwyluQA9NL4RnHn1wRKrubJ0+z1s1Ku9Dv/DpFOOZIgd0vDQeJ4
         tFiAHGZA/7gz6owvCFTnh3wWB5OWpj5fWUz7UThzm7o1lwf++kIj+iV5Wv2gfEbMG1tY
         x6oROnPpbBBzCJP+CT7rYg3KMq29+tElTOuTEPxnFSnKnVaSU4wVFoxORyj3GLji6ekp
         FxPA==
X-Forwarded-Encrypted: i=1; AFNElJ/1pSTkf0rBW/agutEnxOhYBVQ4psk6uiFw3x6AtMXWsBJ8puk3gCkwrWG0vUE83NMTEqEPBAQAfms=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1I7oEf7TOdVuIWvfxNikZed3KccvVIW1+mSeqd3tff5WVk2/
	zI2F0uiIiK8DbTRVZoPeg6reGQmpiA2XIequm14tQJEulmW0+7XGt0ip
X-Gm-Gg: AeBDiesz8oJCuXDmLdphdTW4YPJYAZwJv0MGrEGUfRJ+9H6ksOXKc+4Hg26A967GFEu
	DNVS+Aokh3rngKJRO7Envv8RmteIkYCWB9XNkQA9/0/t16/UDwFQzsEYbhhvL5PLVocqhJug97V
	/NkkFcVGdb0b5ff1sb0Fjdp+ariFNo+ighrMHNk7jz6y6jxJm6bUUK/pDoOD7TzT1zqsfL2HdOW
	3BHG3CWM6K8J/ToWocsvFFpLvDAATzobfiUudkmxBtu9DAHhasaUsk184TK2AyEKB3SGkvwDQES
	UE2Lw73tDUfEdf3vCWziPsFFiVPdj6zrGOTB6qEqtpt6Xi8nOfD+IwNMg2t+TR4iYLsTgy8gC48
	GjjBkYxZiIPzeSQqke5Xnmwo4zf3yXWi4LSCt7cxJl4ccSv+O0Og64yYfbqY8uGI3x8b0ebhQHZ
	BwcN1/ihOFUhB2E9B+OYn2PZmW37wZjxx1qT4oCyNwrNTjJhwHWRxU
X-Received: by 2002:a05:600c:1908:b0:489:1ca4:c999 with SMTP id 5b1f17b1804b1-48e530d8a88mr35424575e9.8.1778092520483;
        Wed, 06 May 2026 11:35:20 -0700 (PDT)
Received: from LAPTOP-9UC0RPH4.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48911sm14398468f8f.11.2026.05.06.11.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:35:19 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: sunny.luo@amlogic.com
Cc: xianwei.zhao@amlogic.com,
	broonie@kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>
Subject: [PATCH] spi: amlogic-spisg: drop misleading NULL check on exdesc
Date: Wed,  6 May 2026 23:35:12 +0500
Message-ID: <20260506183513.482-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aml_spisg_setup_transfer() takes a non-NULL exdesc pointer; the
function dereferences exdesc unconditionally later in the body to
populate the SPI scatter-gather descriptors (tx_ccsg / rx_ccsg).
The sole caller, aml_spisg_transfer_one_message(), always passes a
valid pointer derived from kcalloc().

The "if (exdesc)" guard around the memset() at the start of the
function is therefore dead and misleading -- it suggests callers
may pass NULL when in fact they may not. smatch flags the
inconsistency:

  drivers/spi/spi-amlogic-spisg.c:314 aml_spisg_setup_transfer()
    error: we previously assumed 'exdesc' could be null (see line 261)

Drop the check; the unconditional memset matches the unconditional
dereferences elsewhere in the function and removes the inconsistency
that smatch reports.

No functional change.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/spi/spi-amlogic-spisg.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-amlogic-spisg.c b/drivers/spi/spi-amlogic-spisg.c
index 19c5eba41..b2a916496 100644
--- a/drivers/spi/spi-amlogic-spisg.c
+++ b/drivers/spi/spi-amlogic-spisg.c
@@ -258,8 +258,7 @@ static int aml_spisg_setup_transfer(struct spisg_device *spisg,
 	int ret;
 
 	memset(desc, 0, sizeof(*desc));
-	if (exdesc)
-		memset(exdesc, 0, sizeof(*exdesc));
+	memset(exdesc, 0, sizeof(*exdesc));
 	aml_spisg_set_speed(spisg, xfer->speed_hz);
 	xfer->effective_speed_hz = spisg->effective_speed_hz;
 
-- 
2.43.0


Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216F43E022B
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 12:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093304; cv=none; b=psG8JA8nqO6axIUrnuxEQQAAp1v8DhzgVIYmWgqIUY/Ju/JzvoRLwNEL4pmiA7AYFl7Pj/9MbpLD88tbXCABUQa1lP0EDmA6tb2FnSY40vDKsLMDpIWsXNGQvq9pPVcTfE9c1m45KTtA0/+iZo/gw69bIcHZ4rnFkigEvW7na5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093304; c=relaxed/simple;
	bh=gRYmgtFz61CTrLJuMU4IYn49sqh/BxMTge3k2DLT6VI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mOVe3yVIBdeSfFA0GNg9+SI9XSXwHb0ynFfKBza8cT2jrrB1vq1JDCuA67bAhY/O1x1vgA8ZdoZ/dYgG1Fr3bHp2GaVxj3TYHXrOQkt7RNMNiX8wYiHPw9I21EuOtCZwoqnVfY+4fTrPotRF/9IogZwezu9NgRP202pEGkXHu/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjuG3zTN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjuG3zTN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf20f6be6bso52640925ad.3
        for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 05:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781093302; x=1781698102; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=80QEDLORROQQ3BtM7atufx0QxPfqyLlC7mZSU27RJko=;
        b=mjuG3zTNUBLBgsU8IRHbC/KxEhLb9EvKhWRQ3zzw4UCyE3WsmhIvmzUKejEsTjwtLj
         4slYDGA9dKxPgFfNWp4vi925PpOVptqgLRk/qFu/CLI53NtVu+dsa43yuhKdpzZOkGYg
         6lRZS5V49SsiwRLe9975mKlCef/2eFHL60j+pMf+vso0oZ6C0Pq3sUCCi1yi3dRc9pw6
         RTsTugwej5zGkkzBbgK1dxHolLFQ6LDOH3wCKst+ZeG6keI/0RrppQiz55m2K7HS0eRe
         sv6KPDhig03jCoVv6jYdhiivs0gQUCH5TaJcvTlwKdeKEQ96unI3yR+PQ1qkxO3hpeeS
         W6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781093302; x=1781698102;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=80QEDLORROQQ3BtM7atufx0QxPfqyLlC7mZSU27RJko=;
        b=qPMkf8XC97PKFLogPqnZFXuqJfSx3VuZDQBIhhKXS7+jbB/8vADsxRoEbO/EiCuiSD
         DE7RZslNe5BQHgU8/kRgI7Zi7Y1FKHbPMt4ZtYDfAEjNTQY98jRO63L+CBFSOTH73G5R
         bfcTLSF03rERMwY8HnFo/AtF9ymKGhsKW+AMkhP+iG/e5tTG1u8SJpiuXEIqvR5IPxxl
         IJ6cxBsK/oAhBRODl8daB2xJEETPMcgnvRq6WoKnqMOFtJYp/zRyS37zx5A2wYTJHaX9
         YgJik3r+8bZVaoI6xWg+WJeESvXm8ASZypf+em3BgZY/Olf0mnnxAyMWUTPZIVEOF4xk
         WOIw==
X-Gm-Message-State: AOJu0YwK90Bw4M2vbAvS58+GJbW+HBTHecTwvWPqN/eAY5OzulH+BR+V
	lWgi33jDF5xrkzYVaziJ6o7CRLhJC9wNPn0Gysq1F3xcv0t3qK73wob5e39+Eozfi4Q=
X-Gm-Gg: Acq92OG+YgTAtHK29QNaW2PozcGHQr6m9MKlNjaoEhfFVwu8tfnpGWeSwoxvs/jk9qI
	8q1AhdXM3KLKkWxilLSNJeGhkShVmjGfS1UEKpUBEOAZLVzFJ7WxEU4HYWyz2ak/V30P9djo2S2
	CDrhiY+FZiMx1TRNrFKRQU6VQesIfRF70JqSaUJqlj+5kYm1PUzFOPJ3EM8ObH1hmwFNsbog+vN
	y+PLEX+SnNgLgWn8747fRyjJr4mujmD1VYxiTk4YRj3gUsNFNXHEbXwcaMB+CA4gZo0iA0Zak8n
	jQr75FhkG+XU4GDpZYIkB6ZgdazDT1NJQGLo3DECW8MZgaqxQ0k2vFv9D2vGoEFWb3ShF348LGC
	RZFyKCFeDkw57ZWlZ7Pf1bqJTaztuNk6lTs57JekUdLXsdcjoMwse3AJvIDUHLOKUhfl3ykdere
	4g4ljF7f/ErDtAVgxbVWmhZbSvt4FzM77++/vJvYIEIBf0hpsJ+At0dZsC9zyFvPo+Vo7OtOtqY
	RnZUmSGCCVFjH3b1bkKZMWXkSC0
X-Received: by 2002:a17:903:291:b0:2c0:bcff:e191 with SMTP id d9443c01a7336-2c1e8332c1amr297123285ad.36.1781093302066;
        Wed, 10 Jun 2026 05:08:22 -0700 (PDT)
Received: from junjungu-PC.localdomain ([223.166.246.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f8679esm236919415ad.21.2026.06.10.05.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 05:08:21 -0700 (PDT)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 10 Jun 2026 20:08:17 +0800
Subject: [PATCH v2] spi: rzv2h-rspi: Fix SPDR read access width for 16-bit
 RX
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-rzv2h-rspi-v2-1-40c80b4a2c90@gmail.com>
X-B4-Tracking: v=1; b=H4sIALBTKWoC/22NQQ6CMBBFr0JmbQ0dpaIr72FYQDvAGKGkxUYl3
 N0Wty5f8v77C3hyTB4u2QKOAnu2YwTcZaD7euxIsIkMmKPKVV4I9wnYC+cnFgddGiNV2TYnhDi
 YHLX82mK36sf+2dxJz6mQjJ79bN17ewsyeX/DQQoptDQFmUIhHs/Xbqj5sdd2gGpd1y+FR3q5t
 gAAAA==
X-Change-ID: 20260605-rzv2h-rspi-3c8dd168fb72
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Mark Brown <broonie@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781093299; l=1688;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=gRYmgtFz61CTrLJuMU4IYn49sqh/BxMTge3k2DLT6VI=;
 b=Z+SHh11T+eA5g1RF+ZYwJotSyzA1VacKym9Yev1/NlWp0pPW5TEmvnNIb3baEQ7riX6bDcxvJ
 Drcb+TNYyiJAB5polxXgzeDhTZuIsPh+/B9R+yBMqobOTRs1uvBPCAW
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

The RZ/V2H hardware manual (section 7.5.2.2.1) specifies that read access
size for the SPI Data Register (SPDR) are fixed at 32 bits. The
RZV2H_RSPI_RX macro for the 16-bit data path used readw(), violating
this requirement.

Switch to readl() for the 16-bit RX path to conform to the hardware
specification.

Fixes: 8b61c8919dff ("spi: Add driver for the RZ/V2H(P) RSPI IP")
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Changes in v2:
- Fix comments from Geert.
- Link to v1: https://patch.msgid.link/20260605-rzv2h-rspi-v1-1-c1d5ed562249@gmail.com

To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/spi/spi-rzv2h-rspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 1655efda7d20..6ed3fad873b8 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -135,8 +135,9 @@ static inline void rzv2h_rspi_rx_##type(struct rzv2h_rspi_priv *rspi,	\
 RZV2H_RSPI_TX(writel, u32)
 RZV2H_RSPI_TX(writew, u16)
 RZV2H_RSPI_TX(writeb, u8)
+/* The read access size for RSPI_SPDR is fixed at 32 bits */
 RZV2H_RSPI_RX(readl, u32)
-RZV2H_RSPI_RX(readw, u16)
+RZV2H_RSPI_RX(readl, u16)
 RZV2H_RSPI_RX(readl, u8)
 
 static void rzv2h_rspi_reg_rmw(const struct rzv2h_rspi_priv *rspi,

---
base-commit: a225caacc36546a09586e3ece36c0313146e7da9
change-id: 20260605-rzv2h-rspi-3c8dd168fb72

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>


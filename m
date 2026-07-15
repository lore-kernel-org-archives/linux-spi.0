Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13C3D3D0E
	for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154267; cv=none; b=jCPEIPdkgvlA0rHvRk843dOUk+yoMt7MgGf3WrLsqlIGpOeEY+N9jH92CBTzDAM+K2Ptp1TIoAs45E9OTKh5WS2HgGMVgDmtc3M2jPELv94+UQe34bDLvzUT141T5atNotLbjolpZZeUH8fMzClCWQhKYP6TtU08wBv7JLNB0Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154267; c=relaxed/simple;
	bh=xf98bmANgzyLY7d0vN8PC/XFmQgSnyrCVMnzTAoeOLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4Voq/Vb/zDRa1joivhYaDnNAjE5ptQBXnlP/mF/Jd/BLNe71939JzcbsOJwugeoALPQ9caaZ74U66JYeVsPIPxN6sgy6wxfwsal/G3CVvV7H3oMcRFb7CD8YvNsSdvGJpbkxq2addEwrJ13s9PxOVGn5ScSS3VErWAgodUxxPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJt6Gx3d; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJt6Gx3d"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4758bd3731bso2040536f8f.0
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 15:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784154263; x=1784759063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x19+TAQDChfRjtz7x9GYQXd2WO2WRgrIM4Fdlb0t5zQ=;
        b=XJt6Gx3dxKdpiGFr9YB3gZFf17X/CDRrZU9of3eq/4EwHXaLjXQBpVMpzXw6uSztmf
         Wn3uxx5O+YxUlFr8+xZJR5ip+p89WtalvryJ1YTGIE4rBJAsWi4HzvJl8js8Ca2rTqud
         pvzFTSg4k1qLHPqVFYjGqPagTQfq4Tks80uSw6XGSSSw2ERQulxHSCfcrAI/8hPhjdOs
         1DmNxsOAIB3WoQWI2fHsb7iaCTDrkHYZrnN/p9XX20hEStgt2C1lo233nG+A8ogNJmha
         NqKuuj6mwiJWqQoL/h3pjjh7vbD8pfw1rNlzChP96l8PpwV0lN77al7vRhyE/SUjEq9r
         SnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784154263; x=1784759063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x19+TAQDChfRjtz7x9GYQXd2WO2WRgrIM4Fdlb0t5zQ=;
        b=DajhucWsWb/cvwcPRxHPM848D2R93ZwNkYrXoMhKNBQZLBt+/Ad4IGO6Ebsp/iWvTc
         9alfSd/77TueccI42OFlflYFMbVzx+ZwHpkH+QwmDgkFN1hKLuIsKSzxTd9hdT2l5+Fj
         OAYdLccjf2IrK222BSxaa5fdFqOgRH7XklMyQAXLbqQ6LLoq6/Eu+mf9hRgIT5x9vC/Q
         ir5fVmkXusb8Wv4ZtJFb8hLv2V9hD7CuW3y4ALzd0dvQb0ICwHwxxIqfQHeklaUFP7mn
         2o/wD+HvkTuFNN+vETs3+6eCl8UBRdrntmf213mkwTpQa2+nEx8KYwLYQvROnncriTgV
         jY1w==
X-Forwarded-Encrypted: i=1; AHgh+Roi5ROY5j8YOh2Y2lBnwyGrwNU54W7shrLbcYH6oadptq3wGs20stAamj7Fkl/kiTWwpB+6ZwkF5Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ5HGliQMhkDcQWrJxha/tAIjPLtDV9b0s19J0W36RknpBszpq
	cpDpcQpm327uVzUtIMOwaZJ/lU/awD77gkFU1hWH+sBhOYFxdQIfybGE
X-Gm-Gg: AfdE7cm52b2x3NWStgZLnr7K4hTEXRw6zxE7SkjaQHHHA14IbB2CpFDAtyVYBeXn+sl
	lqHn3KQo0DiyemqgUMmcRup0bBLeNvbbn2H09W8fdUlN2HTh0KZGHtjrSX7hUV59WrJcUCWJo3o
	+D/kI4y4bV5rDyl93u5yfChq05X5A432Yul2qZG23puZxIIrZo6Wmk8lGThOtmF2hRAu+ZzjfvF
	K/zyublYZLEhb8grkgB4a9MWf/lI6ArfZu2z+ap/yxbmNkiIyyMyNaE4hoCTYzyNhsTtVHqb8Uj
	V9bb50CqQ2EYgb9AuLYtMvjNGxylJfEjz75GKzAuo1j8CRZLeJWwOo/hv4OFG/zA3y4iLTQxohN
	VoUAjFgk9cDrjqp9KjuR5u4lgjfPljerjBinn8DQTvARtyKc+QmzAXjhpu6rqlEBRc95SDfKmNP
	zRTn0Pk0c6J4sqLtAOY7phJKtztFHcBl8ofO7+XIh+SdFP83aMXyzlp3SzpZ2av0Lo914gJwfIm
	1Tn1rng+AP2MGab
X-Received: by 2002:a05:6000:2407:b0:475:f0c2:75b2 with SMTP id ffacd0b85a97d-47f5a53f2afmr5353f8f.29.1784154263155;
        Wed, 15 Jul 2026 15:24:23 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:6d4f:b160:7aea:9d1b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e036sm22337783f8f.5.2026.07.15.15.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 15:24:22 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/7] memory: renesas-rpc-if: Move static bridge configurations out of dirmap hot paths
Date: Wed, 15 Jul 2026 23:24:12 +0100
Message-ID: <20260715222417.2997712-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Move the initialization of the xSPI Bridge Control Register 0
(XSPI_BMCTL0) and Bridge Configuration Register (XSPI_BMCFG) from the
dirmap read and write implementations into the hardware initialization
function.

The bridge configuration values remain unchanged across sequential dirmap
transfers. Keeping these regmap_update_bits() calls inside the hot paths
(xspi_dirmap_read_impl and xspi_dirmap_write) introduces significant
software overhead and redundant register locking cycles.

Statically setting CS0ACC to 0x3 during xspi_hw_init_impl() permanently
enables the memory area for both read and write operations.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-if.c
index 104c28532c20..50294e5d2bf5 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -312,6 +312,14 @@ static int xspi_hw_init_impl(struct rpcif_priv *xspi, bool hyperflash)
 	regmap_update_bits(xspi->regmap, XSPI_INTE, XSPI_INTE_CMDCMPE,
 			   XSPI_INTE_CMDCMPE);
 
+	regmap_update_bits(xspi->regmap, XSPI_BMCTL0,
+			   XSPI_BMCTL0_CS0ACC(0xff), XSPI_BMCTL0_CS0ACC(0x03));
+
+	regmap_update_bits(xspi->regmap, XSPI_BMCFG,
+			   XSPI_BMCFG_WRMD | XSPI_BMCFG_MWRCOMB |
+			   XSPI_BMCFG_MWRSIZE(0xff) | XSPI_BMCFG_PREEN,
+			   0 | XSPI_BMCFG_MWRCOMB | XSPI_BMCFG_MWRSIZE(0x0f) |
+			   XSPI_BMCFG_PREEN);
 	return 0;
 }
 
@@ -869,15 +877,6 @@ static size_t xspi_dirmap_read_impl(struct rpcif_priv *xspi, u64 offs,
 			   XSPI_CMCFG1_RDCMD_UPPER_BYTE(xspi->command) |
 			   XSPI_CMCFG1_RDLATE(xspi->dummy));
 
-	regmap_update_bits(xspi->regmap, XSPI_BMCTL0, XSPI_BMCTL0_CS0ACC(0xff),
-			   XSPI_BMCTL0_CS0ACC(0x01));
-
-	regmap_update_bits(xspi->regmap, XSPI_BMCFG,
-			   XSPI_BMCFG_WRMD | XSPI_BMCFG_MWRCOMB |
-			   XSPI_BMCFG_MWRSIZE(0xff) | XSPI_BMCFG_PREEN,
-			   0 | XSPI_BMCFG_MWRCOMB | XSPI_BMCFG_MWRSIZE(0x0f) |
-			   XSPI_BMCFG_PREEN);
-
 	regmap_update_bits(xspi->regmap, XSPI_LIOCFGCS0, XSPI_LIOCFG_PRTMD(0x3ff),
 			   XSPI_LIOCFG_PRTMD(xspi->proto));
 
@@ -945,15 +944,6 @@ ssize_t xspi_dirmap_write(struct device *dev, u64 offs, size_t len, const void *
 			   XSPI_CMCFG2_WRCMD_UPPER(xspi->command) |
 			   XSPI_CMCFG2_WRLATE(xspi->dummy));
 
-	regmap_update_bits(xspi->regmap, XSPI_BMCTL0,
-			   XSPI_BMCTL0_CS0ACC(0xff), XSPI_BMCTL0_CS0ACC(0x03));
-
-	regmap_update_bits(xspi->regmap, XSPI_BMCFG,
-			   XSPI_BMCFG_WRMD | XSPI_BMCFG_MWRCOMB |
-			   XSPI_BMCFG_MWRSIZE(0xff) | XSPI_BMCFG_PREEN,
-			   0 | XSPI_BMCFG_MWRCOMB | XSPI_BMCFG_MWRSIZE(0x0f) |
-			   XSPI_BMCFG_PREEN);
-
 	regmap_update_bits(xspi->regmap, XSPI_LIOCFGCS0, XSPI_LIOCFG_PRTMD(0x3ff),
 			   XSPI_LIOCFG_PRTMD(xspi->proto));
 
-- 
2.54.0


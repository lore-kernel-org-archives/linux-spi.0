Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC493A3813
	for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808336; cv=none; b=Kljw0Kohgu+zNxKCmVaPgT5/y+ETKXZWQr9GerNBiOEBy2kJFv5SgWZTA5cjkJDQWTdWnr7WR5sDiM7FBFPs4e4XuXwEz/GYRPCjadB4S8hXIlnIJ2ChGr+NerBVqGHB7h+HH/06DiToYMMOvOuPg1Wkqz/Jwm2MRBkskMgBBbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808336; c=relaxed/simple;
	bh=YiC0zOs6O90q4/FPkzw3mGwg8ejhtR+Z6tBOWwhcw+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G0UPdCY5c090TtduIXRsG0/YGDNpV5SXIQ+t6KIGX0BQF4g0UEXrx0I7kGkRBw/hIIDZU1OGxj2SV4JTJWqU9ADF/AjGCyKK6iYkKhhYfvf26ePwjkQkH8PZwq8Gi9WqFmNL0WeQq7g+xOGsHgGRrpVoM5TEd6IXiLsVJPsXf0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgdHilzX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgdHilzX"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488a041eae5so12173475e9.1
        for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 01:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775808333; x=1776413133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHpfsnzzu+UOFyztPgbXvpWNz6C6DyMlHqqcUHYsTVA=;
        b=VgdHilzX+w/falVX31tlZ7avYi9MwaTraLeJbtDTO9wGm3/HZm9E0rdnw5FYamd20S
         zz5TIQiUMyTiFjR168XWd/tmHxSo2x7/SZITfENrUd33L9/zFq2SfiONPCPbN2dkctgy
         0wLKeBiZkBI3XT43cJ3fPQZLlLWuIBZsny2zcZ9mrlxfqU5bv/qxoIKfSsZ4q3y/z9nv
         VwOaC/h8mSxbD1kSC9DACFLiEsS/6zB038WuKq8sG0cgHtTof+vukSQ8ih4H/W8j6RHJ
         AZEi5kQQrrdBcIre9xr4RVXYPyuDNTlLOtze6x6XNqg1uu43WcIY9cPEsdfbpyqhoTLH
         Ul/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775808333; x=1776413133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHpfsnzzu+UOFyztPgbXvpWNz6C6DyMlHqqcUHYsTVA=;
        b=hh3uO0vgqpEYt5KgZbjU4pE0NePwDqDj/i7wheXPkApzNRHO1Nu0PLofDr0/paBG/7
         Jdd8+n1hT7UaQ3vJU0xvSw0a6FA7ZccYdrjSE6eYT36OT78WfWe4QUsKgxi7tNfG72Sb
         SXVhN+AJ30wSAwuVLbEuBjkaOCoUO88Ih9sD0QpSqAxGfh5OrkFiP7w7XQM55DS47pkG
         u5AABJCeYBpco64exVHEvd5ITNho3yK5Wk9PV7ZuglDATg3XteiLTmjf6gi7cLYv4a/e
         DnJVM4lEipsLrdK6FFQKY7/FWDKx/FqPvzkat2ezEOuBwMBZDWXceoHlXGUYoTR3v6vE
         grzw==
X-Gm-Message-State: AOJu0Yw22BwvM0RR8Pml2ggkOO1RAhpz20hvbjyFugVdU+DFLpbk9TeH
	ZIWciyA5q3rSyixPAyCNL/3Q+HHkxQSHuCaFsRvew5ejZNe8Ybejb2aM
X-Gm-Gg: AeBDiesw6oPSF6Ue1ySaQXmVUWDRuhKi3L1T9PXYcHhGK1gmW8vBLA2TjLV9C62XWPq
	jVtmQmDPjqst5BAphR3xsy76eP1DWYC7y6mBzg0e+lPksyUIWDZ8GxdaoQM5THUq7xR8Vg00UBc
	DrMtHLM4ZJsIh02CDamfNvF5c2cS3Y2buTlbRZDoCmZ40rIBDaxoiAhgBs+lXK0kQ4OAOquS0+A
	zNDMfh1ol42CYqXI+TS1FepktLsEYyioirRYkRVkn7jA1rYqD9MvhmDtQFyu82JDHxxmpdYVREK
	05u4+IQ83IRFOdBoAlDa+JOYDshvxfHViX+vU51ZoOAsIPKZdzRwbGsfAfIt1/SSQhIi2cSgspH
	oXfadK9rUPKa/cSJl6XRoZXzlUtOH0lOb5Sc7CG+8iu2v3ocKSg6Il0IuNoyqruKxqfEkuM2chf
	8ztJpn3ySF99bSIE9X+GOzZmw9soI5xvZ3xJidzsZMbFOqpSG7kISuOrYsnGBB3XjoyLy6MujB8
	4UOH/Dq0tS3I/TuNQoO3QJ3WW2HIdFX1E9sVgwYi8dBEIDJ
X-Received: by 2002:a05:600c:3047:b0:488:d6eb:e635 with SMTP id 5b1f17b1804b1-488d6ebe7ebmr13526205e9.12.1775808332681;
        Fri, 10 Apr 2026 01:05:32 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:a73b:688a:4297:c5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67ce3e4sm29950375e9.5.2026.04.10.01.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:05:32 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Cc: linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 2/3] spi: rzv2h-rspi: Fix invalid SPR=0/BRDV=0 clock configuration
Date: Fri, 10 Apr 2026 09:05:16 +0100
Message-ID: <20260410080517.2405700-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410080517.2405700-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260410080517.2405700-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The combination of SPR=0 and BRDV=0 results in the minimum division
ratio of 2, producing the maximum possible bit rate for a given clock
source. This combination is not supported in two cases:

- On RZ/G3E, RZ/G3L, RZ/V2H(P) and RZ/V2N, RSPI_n_TCLK is fixed at
  200MHz, which would yield 100Mbps. The next hardware manual update
  will explicitly state that since the maximum frequency of the
  RSPICKn clock signal is 50MHz, settings with N=0 and n=0 resulting
  in 100Mbps are prohibited.

- On RZ/T2H and RZ/N2H, when PCLK (125MHz) is used as the clock
  source, SPR=0 and BRDV=0 is explicitly listed as unsupported in
  the hardware manual (Table 36.7).

Skip the SPR=0/BRDV=0 combination in rzv2h_rspi_find_rate_fixed() to
prevent the driver from selecting an invalid clock configuration on the
affected SoCs.

Additionally, remove the now redundant RSPI_SPBR_SPR_PCLK_MIN define
which was previously set to 1 to work around the PCLK restriction, but
was overly broad as it incorrectly blocked valid combinations such as
SPR=0/BRDV=1 (31.25Mbps on PCLK=125MHz).

Fixes: 8b61c8919dff ("spi: Add driver for the RZ/V2H(P) RSPI IP")
Fixes: 1ce3e8adc7d0 ("spi: rzv2h-rspi: add support for using PCLK for transfer clock")
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index ad59944c773e..602d4a36b44c 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -50,7 +50,6 @@
 
 /* Register SPBR */
 #define RSPI_SPBR_SPR_MIN	0
-#define RSPI_SPBR_SPR_PCLK_MIN	1
 #define RSPI_SPBR_SPR_MAX	255
 
 /* Register SPCMD */
@@ -535,6 +534,17 @@ static void rzv2h_rspi_find_rate_fixed(struct clk *clk, u32 hz,
 	for (brdv = RSPI_SPCMD_BRDV_MIN; brdv <= RSPI_SPCMD_BRDV_MAX; brdv++) {
 		spr = DIV_ROUND_UP(clk_rate, hz * (1 << (brdv + 1)));
 		spr--;
+		/*
+		 * Skip SPR=0 and BRDV=0 as it is not a valid combination:
+		 * - On RZ/G3E, RZ/G3L, RZ/V2H(P) and RZ/V2N, RSPI_n_TCLK is
+		 *   fixed at 200MHz and SPR=0 and BRDV=0 results in the maximum
+		 *   bit rate of 100Mbps which is prohibited.
+		 * - On RZ/T2H and RZ/N2H, when PCLK (125MHz) is used as
+		 *   the clock source, SPR=0 and BRDV=0 is explicitly listed
+		 *   as unsupported in the hardware manual (Table 36.7).
+		 */
+		if (!spr && !brdv)
+			continue;
 		if (spr >= spr_min && spr <= spr_max)
 			goto clock_found;
 	}
@@ -568,12 +578,8 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
 	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
 				   RSPI_SPBR_SPR_MAX, &best_clock);
 
-	/*
-	 * T2H and N2H can also use PCLK as a source, which is 125MHz, but not
-	 * when both SPR and BRDV are 0.
-	 */
 	if (best_clock.error && rspi->info->find_pclk_rate)
-		rspi->info->find_pclk_rate(rspi->pclk, hz, RSPI_SPBR_SPR_PCLK_MIN,
+		rspi->info->find_pclk_rate(rspi->pclk, hz, RSPI_SPBR_SPR_MIN,
 					   RSPI_SPBR_SPR_MAX, &best_clock);
 
 	if (!best_clock.clk_rate)
-- 
2.53.0


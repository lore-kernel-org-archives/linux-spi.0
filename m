Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363313AA1B5
	for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808338; cv=none; b=NKs3uHslpWT+qi9l2ECT6HSmQkz0tZ/C9fwjQdM3NJ6NMN3Q80BtWPM/Ez8wJ8i6lt2KWDIE2HOcMYo4CG/ii+eI7vbFARWaSc/1dk8XsBaP/oxt24HAh6vcDeIs2rDLbwKvXJvUWk2l6BWfr2Lxw4R1BmrHlNauJ5uscJQbm4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808338; c=relaxed/simple;
	bh=xorpueJxTNukt5ZFVGNxy2LzwUY45JT81ldlU6c6GAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hSqJxWGHK72niIpUX5oepGee7KfjKrJVLUy7G1yvNMwocRy0NBs5NAYJd/3mv11pJTzDLcGX0rRlx+JAIq5RALHN4e6dnrZ6AspPyAoyABGNXSsSDweU/IoUgWqFTFZIQnh1d3/8dtQkeRiy9fXnqFnHA0k4VqZqwtWER9ogABs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKI81Qvn; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKI81Qvn"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-482f454be5bso18271505e9.0
        for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 01:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775808334; x=1776413134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YrKnQwSJErgHcrBoBos/Qb5MY50qHFM3OyauosBsnB8=;
        b=DKI81QvnrTm6FfNeeo72sGgRRHkjOZy9gn5f+/0/5mbiPgN1zh4tBHQEri7TLmMw5L
         hbIrN/pgpge/AfDm5rCB/fP2NWRR7mZOUYaGlg9/eQPT0z8cg3hq10Zn83XR0Ze5P1z3
         4+is2K4w/3fT5m4vDuOoJGiAe4rarsDKZI6FEKdLg8aH+M4EonI1XWkT5d8SxLBQbxfm
         AtyUU840IcHVsByq4GSn9JXQjT9pMwzcuethwjNw0crLC+dvg7IhlxFDafSZvAakQ9dO
         54noBL6I/WkfqxoXPfiJzqhJvwIJBAhDKc7J5R9DrEogvEBR0b08/AkbKRxxCpeOkxQT
         RTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775808334; x=1776413134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YrKnQwSJErgHcrBoBos/Qb5MY50qHFM3OyauosBsnB8=;
        b=Ijb+QjRdpmU7mZxB1CqcEh9BAGATIdqBMZ2rvFLDdzEa27lmGMBTgSgiIAI7KvwF5m
         Q1VuU1pq9jpHEUTeds8kZZ3jtHchTnNpPbtK713jF8yL5a97i9XPy1cw2MgIOLqtc5Cx
         O/UaUMHP4wVChfR79PaDlnT2PjR+THGW90eIwwOANQaqInvvTfUFFjaN14AwECi3FPu+
         vjTQdOVoC5djg4fQ9TmD7hqwZm+YhDMYASwDdCAeAK9azyG6Uoq/cW7YPr0Ub4D8JuyZ
         GI1TOsb5Hx6JaVbllC5C246Jb7SvqAbdI8r/ptitnae0ZRA5+er5plt4GVPuwC41mpEj
         839g==
X-Gm-Message-State: AOJu0YwH0cmcCZctD/cZMXm6rT/WqDYdETLM7DiV6nPibC2brXDOuIfg
	RGYdt+fl5Y+O77EBJUxf1kixR0niSeD7wdYeBlzbUJGgGgTVHOtfRS2G
X-Gm-Gg: AeBDieuUenevrvlXcjcd6RKw7qw6H5TvYoJw7NfncAPuhJgULhwJTIu/zIdtn2ceBvE
	t8usZNz51JfikWYgVJaVF++CoL9Hxlza4kOzVBk/VHO1JeiCHWoABm7brNArKI/3nQ8pVkvq4U2
	b9z92tSuYhUAGzDoIGeBkIqpPngb5XONOaevPaKWyGyzWvZgJml1pVi/SOY+NkI9bLWVSjWIbHZ
	VSVjtDUZHi4pZy7xXB3GR1ibq4JPw7KJLOII+PSaDvqy+0UjXpdlaskrf7f721wh1bfibHygGRR
	Ql8g3uYyGc43PSxBMtS/ADkmq8OL6XxcgukD+MVwZvyEJ4m/nf3dVBwaLLq11xgc2VmGyD1kjy4
	B8Hr+IQ1sj5j7Chic1rlxrT1+XvSGvxQqBJY2KjjyjoPlxXnNAKLZWAxBYPIOe1VPe2dpalDZJy
	zJXSS2t+R0lT/eenDT6Hh8JBWjxTm4GV61YWMSz8IS+lb9hvSbMBi2opzk4ZmDKAFZBfcRFXob0
	yjBq+0JvxpJtFX/VpHAJNiNQmCAaaQgKyjYOA==
X-Received: by 2002:a05:600c:444b:b0:488:9c3b:ff40 with SMTP id 5b1f17b1804b1-488d6acd9fbmr20477575e9.15.1775808333390;
        Fri, 10 Apr 2026 01:05:33 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:a73b:688a:4297:c5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67ce3e4sm29950375e9.5.2026.04.10.01.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:05:33 -0700 (PDT)
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
Subject: [PATCH 3/3] spi: rzv2h-rspi: Simplify clock rate search function signatures
Date: Fri, 10 Apr 2026 09:05:17 +0100
Message-ID: <20260410080517.2405700-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

The spr_min and spr_max parameters passed to
rzv2h_rspi_find_rate_variable() and rzv2h_rspi_find_rate_fixed() were
always called with RSPI_SPBR_SPR_MIN and RSPI_SPBR_SPR_MAX respectively.
There is no need to pass these as parameters since the valid SPR range
is fixed by the hardware.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 602d4a36b44c..f45af5884638 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -88,9 +88,9 @@ struct rzv2h_rspi_best_clock {
 };
 
 struct rzv2h_rspi_info {
-	void (*find_tclk_rate)(struct clk *clk, u32 hz, u8 spr_min, u8 spr_max,
+	void (*find_tclk_rate)(struct clk *clk, u32 hz,
 			       struct rzv2h_rspi_best_clock *best_clk);
-	void (*find_pclk_rate)(struct clk *clk, u32 hz, u8 spr_low, u8 spr_high,
+	void (*find_pclk_rate)(struct clk *clk, u32 hz,
 			       struct rzv2h_rspi_best_clock *best_clk);
 	const char *tclk_name;
 	unsigned int fifo_size;
@@ -413,7 +413,6 @@ static inline u32 rzv2h_rspi_calc_bitrate(unsigned long tclk_rate, u8 spr,
 }
 
 static void rzv2h_rspi_find_rate_variable(struct clk *clk, u32 hz,
-					  u8 spr_min, u8 spr_max,
 					  struct rzv2h_rspi_best_clock *best)
 {
 	long clk_rate, clk_min_rate, clk_max_rate;
@@ -464,7 +463,7 @@ static void rzv2h_rspi_find_rate_variable(struct clk *clk, u32 hz,
 		 * minimum SPR that is in the valid range.
 		 */
 		min_rate_spr = DIV_ROUND_CLOSEST(clk_min_rate, rate_div) - 1;
-		if (min_rate_spr > spr_max)
+		if (min_rate_spr > RSPI_SPBR_SPR_MAX)
 			continue;
 
 		/*
@@ -474,14 +473,14 @@ static void rzv2h_rspi_find_rate_variable(struct clk *clk, u32 hz,
 		 * maximum SPR that is in the valid range.
 		 */
 		max_rate_spr = DIV_ROUND_CLOSEST(clk_max_rate, rate_div) - 1;
-		if (max_rate_spr < spr_min)
+		if (max_rate_spr < RSPI_SPBR_SPR_MIN)
 			break;
 
-		if (min_rate_spr < spr_min)
-			min_rate_spr = spr_min;
+		if (min_rate_spr < RSPI_SPBR_SPR_MIN)
+			min_rate_spr = RSPI_SPBR_SPR_MIN;
 
-		if (max_rate_spr > spr_max)
-			max_rate_spr = spr_max;
+		if (max_rate_spr > RSPI_SPBR_SPR_MAX)
+			max_rate_spr = RSPI_SPBR_SPR_MAX;
 
 		for (spr = min_rate_spr; spr <= max_rate_spr; spr++) {
 			clk_rate = (spr + 1) * rate_div;
@@ -512,7 +511,6 @@ static void rzv2h_rspi_find_rate_variable(struct clk *clk, u32 hz,
 }
 
 static void rzv2h_rspi_find_rate_fixed(struct clk *clk, u32 hz,
-				       u8 spr_min, u8 spr_max,
 				       struct rzv2h_rspi_best_clock *best)
 {
 	unsigned long clk_rate;
@@ -545,7 +543,7 @@ static void rzv2h_rspi_find_rate_fixed(struct clk *clk, u32 hz,
 		 */
 		if (!spr && !brdv)
 			continue;
-		if (spr >= spr_min && spr <= spr_max)
+		if (spr >= RSPI_SPBR_SPR_MIN && spr <= RSPI_SPBR_SPR_MAX)
 			goto clock_found;
 	}
 
@@ -575,12 +573,10 @@ static u32 rzv2h_rspi_setup_clock(struct rzv2h_rspi_priv *rspi, u32 hz)
 	};
 	int ret;
 
-	rspi->info->find_tclk_rate(rspi->tclk, hz, RSPI_SPBR_SPR_MIN,
-				   RSPI_SPBR_SPR_MAX, &best_clock);
+	rspi->info->find_tclk_rate(rspi->tclk, hz, &best_clock);
 
 	if (best_clock.error && rspi->info->find_pclk_rate)
-		rspi->info->find_pclk_rate(rspi->pclk, hz, RSPI_SPBR_SPR_MIN,
-					   RSPI_SPBR_SPR_MAX, &best_clock);
+		rspi->info->find_pclk_rate(rspi->pclk, hz, &best_clock);
 
 	if (!best_clock.clk_rate)
 		return -EINVAL;
-- 
2.53.0


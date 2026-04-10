Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CD1332EAC
	for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 08:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775808335; cv=none; b=IbEMdIdTa7Ew6McvaCOA3Hw6PANWN7uTaZG9o6/cBa/WSDK9CjfDe7gYTNY6M+ISW+nG7TaYTr1UalyjpCf0/4vLtr3mFZNKhHHYbB0PdFBaEpJmGFEtrBVmQJC0vvJBH/INnj7LkKjFx5GDh3EHpHotfE4XHs3yvIQh09G+hKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775808335; c=relaxed/simple;
	bh=ExdKYZiJJD+Q5GGhOzDo2C5HZMlMu6N2dRQb4ubjJEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQ/YRYz697VHLqhaAvV1Ly96wRvO13W9zUDT/YrJWtF9GV/mQg26Mwf2DHDipWgWpxjB2wytyg8HDaNXqi1sXD9dPE7PWVw2WQusZtyXUYejMfmXpkfVOOdtppSHGxvvbiq2SJnZdnDyzl+gnSuctnsnJoqucpv9Cs6HMNQEn9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XU7ARnP3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XU7ARnP3"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso18219075e9.2
        for <linux-spi@vger.kernel.org>; Fri, 10 Apr 2026 01:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775808332; x=1776413132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmDUlYaXWDCF161d1mZMXREvHYM3yqRZXtIiTZpAOb0=;
        b=XU7ARnP38OQ5uoLOrYkfCmMlFogQ4brfalCVwHZ9XBpKicIZ0WfxbCDjegNF1ppphs
         RL62SgXcrVRVlbUJWJTxdv0Bs1i1bylyEbe05oAjWELdrpv6RiLUHiWUpK53iRUKCjX1
         9/HxrHfGyvRWfXYA5FtDXaAONa3LpZVs1/ZLezJwARtg7ZTeKZS3vIqqdfE506XIRmZd
         JAU/gt8ZcRTDX6LDRilwt3SiVncOTKOpJfsyJI3bCQ/Af4jg9GvJ9KqM5bGNmE8Jk+sv
         4VGgvnpUCrxfd1zD3axYfeBkBvbUHTJjybKe+M6dkY3fZgJ8I0LfKQ89j93u0hsmWv0W
         vMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775808332; x=1776413132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZmDUlYaXWDCF161d1mZMXREvHYM3yqRZXtIiTZpAOb0=;
        b=dXSsE0AXFNnsImkQZAfMDraVPcjrIC24fGDd080GejHFyngjBCon/Gj0CZqKpS7Dg2
         AGAeXr66Njuvsj1JZn7xzM587nHe+ebJubJEzooQzL8W8afh2OITsVgX34TuPB3sebc6
         yubi5hYC86Azk1UDm+vToAzARAdHRKtac+aGxOd1HqHuK4wmDjPgSjtKjhiGpKLLpauW
         dzECNhCnHEtmC9CwbpP6rv1aO1MKGlJ9eVKUZn+x+tY0YvOB/qipOlQsoZpxqYpK44bi
         oe/3U8+oaqOUmli61bn/3zSmv2uvpidV5rgpj1nu7g7gsyNKjVbSRcLIm75cV8E6iWg8
         z2dg==
X-Gm-Message-State: AOJu0YwwzWV2aOytors3V9FsZ3M4az5/sabvP2DvBkBe4EK7XkaOCn6a
	uEH3aFyKsO1JYX6TIgQwnonAUEN96UPLB+oANKkCiSDPkDb6FtovVGGu
X-Gm-Gg: AeBDietYSKPss/cO5jkt/ivEURIP26cWez+gd0SsSyzRNF6hNGozoZmLhgruUxw1jKj
	yK8PKgjGgM0n3aGWfU+2SL5xtI74yxzetpE1RRV/Ah5CmrUlQg2JUk455v+EFjlQin3igyiziU8
	lr6i7sQm6Uz6UYkfZQe1jWtbsOWt2byZs1NP/34VxGQnU7RGwq1+P8VGTUtqIbuMIFLdFIghhHU
	uREpjHRqp3DmXnc5sz8C2xNM6OtJHUydhEb+CW2VlbhfJyzMg51rg+2FYibCOHrlnyvjPEKT4En
	r4267ClS0C5c4cXof6y1Nho3lcovI9RfFRNzYqlQ0mDm84BhpS4/0iBELmoaqn5ase0UQ3u2djT
	t2GLFKbtZxs5tWlHr2e0+VJabS4IlyRs+degQNoJPzeEr3wFWhNgPq4MEwO89vuoxmSd6+vlhT3
	tI7+jqgsmSPHho12Y9suGaVJ58jHeEaYLxwmQBGvGrAE3vcs1TCFTjt7V676yrU5Ht78evy7LIH
	K7rmOUit2ZRhG0Z8PDBxO0kGccYNzNACZP5lw==
X-Received: by 2002:a05:600c:4451:b0:487:1fbf:e0a1 with SMTP id 5b1f17b1804b1-488d68057e8mr25070635e9.4.1775808332036;
        Fri, 10 Apr 2026 01:05:32 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:a73b:688a:4297:c5fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d67ce3e4sm29950375e9.5.2026.04.10.01.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 01:05:31 -0700 (PDT)
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
Subject: [PATCH 1/3] spi: rzv2h-rspi: Fix max_speed_hz advertising prohibited bit rate
Date: Fri, 10 Apr 2026 09:05:15 +0100
Message-ID: <20260410080517.2405700-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

On RZ/V2H(P), RZ/G3E and RZ/G3L, RSPI_n_TCLK is fixed at 200MHz.
The max_speed_hz was computed using clk_round_rate(tclk, ULONG_MAX)
with SPR=0 and BRDV=0, resulting in 100Mbps - the exact combination
prohibited on these SoCs. This could cause the SPI framework to request
a speed that rzv2h_rspi_find_rate_fixed() would skip, potentially
leading to a clock selection failure.

On RZ/T2H and RZ/N2H the max_speed_hz was correctly calculated as
50Mbps for both the variable PCLKSPIn and fixed PCLK clock sources.

Since the maximum supported bit rate is 50Mbps across all supported SoC
variants, replace the clk_round_rate() based calculation with a define
RSPI_MAX_SPEED_HZ set to 50MHz and use it directly for max_speed_hz.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/spi/spi-rzv2h-rspi.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 38ee09e389c9..ad59944c773e 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -77,6 +77,8 @@
 
 #define RSPI_RESET_NUM		2
 
+#define RSPI_MAX_SPEED_HZ	50000000
+
 struct rzv2h_rspi_best_clock {
 	struct clk *clk;
 	unsigned long clk_rate;
@@ -771,13 +773,7 @@ static int rzv2h_rspi_probe(struct platform_device *pdev)
 							   RSPI_SPBR_SPR_MAX,
 							   RSPI_SPCMD_BRDV_MAX);
 
-	tclk_rate = clk_round_rate(rspi->tclk, ULONG_MAX);
-	if (tclk_rate < 0)
-		return tclk_rate;
-
-	controller->max_speed_hz = rzv2h_rspi_calc_bitrate(tclk_rate,
-							   RSPI_SPBR_SPR_MIN,
-							   RSPI_SPCMD_BRDV_MIN);
+	controller->max_speed_hz = RSPI_MAX_SPEED_HZ;
 
 	controller->dma_tx = devm_dma_request_chan(dev, "tx");
 	if (IS_ERR(controller->dma_tx)) {
-- 
2.53.0


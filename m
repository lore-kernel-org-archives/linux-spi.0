Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CC63AA509
	for <linux-spi@vger.kernel.org>; Wed,  8 Apr 2026 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638470; cv=none; b=Rmc4FHzuc9xsXUlNOuyQFQ2uTTKVQXNMkHfUQvsFjdg3WylnSGtunt+XN5S0/11MrVQMlAlHxJFpAIhiQWLTwsMv/+z0ATQEA2Z5uHgsTzqrwQugVxwN9bNad2+kzPzCrfdAcbSd7JugVEXRSatw6W1jFX2dCNR3vNTjebwV+Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638470; c=relaxed/simple;
	bh=ItXq+HAy83MrT9YuVxBtXwsKZX0gmYnvMfWPNgwL+54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRYARAeKSkrTC4OJtBzKKvXY4KK2wM55h/EgFFHDE2cN/M4l349pt3ZHuidpQa4yvd5jMyeSQa21ceE3iiAW66Y6fA85k/IR76WX8hl+Tnh3+B8Yd53gM/Tof30lxWB9xx6hoS7jlKfBG+wXWb+fHegb99xh3Vt9S3tIbtknhhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eHkZq67Q; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHkZq67Q"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d04fc3bf2so3406345f8f.3
        for <linux-spi@vger.kernel.org>; Wed, 08 Apr 2026 01:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775638465; x=1776243265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bdtaovd8xWj3rm7rGudho5NKYAJRSZ9GWAIfd8UFaAU=;
        b=eHkZq67QU3eWh1vV3hRqUE6mWy5uR9rRq/Z9WJBLL/wJnNmh2ojJQA20XDou4O85W3
         B+SGpkEYtTati+4MbjYWGd4wWy/Ccy72CXaV6PZN+WJTAoC/wOgzW6asCNMaAN+iNChY
         pCGa3nJZdGzC4Qi1oHtbigoM3cLT0ufTdqKoeh8JHVrEdErQwX9K5n5glwR1Caf/XGRh
         442GHYBuY4b69Vo+QvjJFH9Cj2pmnuD5TRMDDTidqBtY0FLHB9oSjBBrbk51MBmncB+G
         EhkMet4PhbzjDcYGCx5jAPg2DUGtWHNY///VeHEerV4Jl8T2smKQoUjsdSDYWSqxo/Q0
         J/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775638465; x=1776243265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bdtaovd8xWj3rm7rGudho5NKYAJRSZ9GWAIfd8UFaAU=;
        b=YDkTZVqaLgc1Pa9OWRv8De1PImwlQqBC0uWBY5SxK1AS3rhpDJaFaLnwSEqfXLpAwD
         B7QIHThgTwOz/Qz/0HTA/suto2bt8t7yR+HCylPZoRYpEPh9qvn/nT31GxtG605q9e+1
         T7H6RK3pmt/U0QGhK1Yw/2QiQxDW0/hFPvHYEkZpgp3JCAD1h8/0lwHsERB3Q66dmfh3
         qr+ypPD+mjwMg5+2qcANtrVVn/2VWLvGm9pVrGRG4kNAZfBRpfeqcCeJmq3qxOr83FNi
         Y+RIabb2yGxQn/r3G+GJfvB03pNTpsh2Mg9T4z4nD5FYetasdngvgVGe2J4asaKwzPRD
         fvRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaeOMFD0zJ2xAPxr+eF6/LAcf0m3x0uOJJXuSAWjuK2VSJUgY8OiZ80455ROtLetOksl/u+5U6EAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRI6aVwA9+OR6sxsOm+ZpXR0Nn2gQe068E9dYsxCXkMmSfYcvM
	HgsfQBTrOSgLmLUpFLaoIwgtX5HgQg2F5WoQzmokCdF1BIl2d3kw79g9
X-Gm-Gg: AeBDietiCfdBXWlnuTMhznK2VVH22Q2ozS2Tn3LtpL6EJLv05+ggU2loAOvO1Xl0j3X
	FaO521j2gOK2zA5w2rudafysbUvqaALkZ773AIY0KhRSv4hyaGJRp2vTTC/5wjrZRb0jqOkmvDt
	4ML8/EyJlCi+UA+olxl1uwgNkd78W4Kxj+6yDqHmUXMUc/cv0e7JCCNTMDdYoUqfmrBsgC+MF1A
	5DBYs0I4RUlLJy/4g0VO7EklEbN1b1RJ+Ld3OE3rfieo3ZqcERgK2HSSRlf/lBCskq5gd1T2txa
	BRTSHt1XB3qgoXq29R5WAb4BA8VYJh8zMLs+ALKBgMLk5vOw2JC6KhnsPL4P0A5VME6vgu+Uf2a
	zhCc8Ma0VxqNA1Zg9iLPosGRtsA/CZ3lP5/W0ycxs1sEn8yN8/m38mpXqrbg+xjXq3wqeTeMUng
	X4CBDishc3+WXvv6EuZ2Az8sovZ095odqCmmtsX4LSbavymWM=
X-Received: by 2002:a5d:5847:0:b0:43c:f8b4:e58 with SMTP id ffacd0b85a97d-43d292e2a9emr30949101f8f.41.1775638464585;
        Wed, 08 Apr 2026 01:54:24 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:f65c:8080:131a:202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c50a7sm56437678f8f.15.2026.04.08.01.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 01:54:23 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v4 2/2] spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)
Date: Wed,  8 Apr 2026 09:54:15 +0100
Message-ID: <20260408085418.18770-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408085418.18770-1-biju.das.jz@bp.renesas.com>
References: <20260408085418.18770-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for RZ/G3L RSPI. The RZ/G3L variant requires only
2 clocks (pclk + tclk), unlike the RZ/V2H which needs 3.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * No change.
v2->v3:
 * No change.
v1->v2:
 * Collected tag.
---
 drivers/spi/spi-rzv2h-rspi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-rzv2h-rspi.c b/drivers/spi/spi-rzv2h-rspi.c
index 23f0e92ae208..38ee09e389c9 100644
--- a/drivers/spi/spi-rzv2h-rspi.c
+++ b/drivers/spi/spi-rzv2h-rspi.c
@@ -811,6 +811,13 @@ static const struct rzv2h_rspi_info rzv2h_info = {
 	.num_clks = 3,
 };
 
+static const struct rzv2h_rspi_info rzg3l_info = {
+	.find_tclk_rate = rzv2h_rspi_find_rate_fixed,
+	.tclk_name = "tclk",
+	.fifo_size = 16,
+	.num_clks = 2,
+};
+
 static const struct rzv2h_rspi_info rzt2h_info = {
 	.find_tclk_rate = rzv2h_rspi_find_rate_variable,
 	.find_pclk_rate = rzv2h_rspi_find_rate_fixed,
@@ -820,6 +827,7 @@ static const struct rzv2h_rspi_info rzt2h_info = {
 };
 
 static const struct of_device_id rzv2h_rspi_match[] = {
+	{ .compatible = "renesas,r9a08g046-rspi", &rzg3l_info },
 	{ .compatible = "renesas,r9a09g057-rspi", &rzv2h_info },
 	{ .compatible = "renesas,r9a09g077-rspi", &rzt2h_info },
 	{ /* sentinel */ }
-- 
2.43.0


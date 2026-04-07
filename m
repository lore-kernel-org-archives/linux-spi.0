Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E3733D6EF
	for <linux-spi@vger.kernel.org>; Tue,  7 Apr 2026 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573883; cv=none; b=u/dEPhRQvLiXpF0BOnPHZjESlN+ucEpm9MR/B/jg+D7U5k9Bm8XCX8INdHvzowW855TYrpeGUu2eYHgR71hRzu0yKNDCLCxjgNwROYKLNEolD1KAa7GM/Y0OXQEFJlkvvGsiXDGNHQxRSSVUdCEVt4Y+Bhxd0FTYvFujEsOaJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573883; c=relaxed/simple;
	bh=gGJAVkaqbnWBs6ogKwMwK95d8Tb45CCZHT9puzQJJag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QAU1m/4eklE3uzIE+WgO+GJKsLtBrXS7xMLWohB2m1D0f3WIBXO3HciNs6qXn6YJBCtmZE7PGbtg0PAR5Cfycp6Yl0i5HfXB14Z/RzVEX9qr+kjhZvvLRzOZnohcPhAEV8yEjp8eMsfoYhVE74ltgcNmIkVnDpv90DC4oMr4Ru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qm062XEX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qm062XEX"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso38057725e9.2
        for <linux-spi@vger.kernel.org>; Tue, 07 Apr 2026 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775573879; x=1776178679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uu0Lw+oxbfd6mTQ3wULf7ZlkS7pX6qzycy8VlVzsz/A=;
        b=qm062XEXTTaRcwcyOgdGR41KSqsvB2hZktt8PhfO1+wAwsHYzUY0rGMS5qh8jAMRyT
         ENDeKA3dRTCsJ7bgAV1VVFrrIeBoTEfU/9AYKrh5m7bTUqRd9nqswf/r0eEUk2hPvuVj
         p+23HkiDB2j3EyKMXNQ9rkLW4w8QZW9+fokoaxyeng0TTLl9i2zG+OTJq38KH+hfSAzA
         LxLtv6cNWlpkQLgcba3vffAJrhQOxRMKljY6KAXkVlwJTNpkp9DkNbry3YokFaLpULUD
         LFjxu7ULj1KlbeIWcKh2rV8zebWIkW76nbiIgP6pLJhkk5+scbUTo7qycFsAR7NcaTkS
         gugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775573879; x=1776178679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uu0Lw+oxbfd6mTQ3wULf7ZlkS7pX6qzycy8VlVzsz/A=;
        b=acxK2RKwWqbhclZhBG+bSfoIR53C8MMouVTJz7bKfqdEnL4wRqpWhDlr/dOCt2e3yx
         h00UW3r3n300I0QZCFUHWbroNLVS/0r4k9h1Y6yM5Jnh9FSMIy1vLcay5ozS7S2p2eXH
         IKe4z74NYxR3+6078nP6rhb6GRoJoNa8YjhKjGmcO68knfWfV5mwQeukay2/WPXbU+PK
         tURGImUbwEj8f0WvRVYEmXdEMX4IRol9WkznXakdyOqKmpwRk+vodZpVNVLL1jksRPMo
         7/0bngCpgkaI3RH4ebauUiXVQMKgpDH66F6+9z91u7YYCFM9c0IB9nkg9aowt3tl0fJ4
         3/RA==
X-Forwarded-Encrypted: i=1; AJvYcCX1KD8g9V4MDhbduK9Zcv4RKBCPgNsAh48JbxdGt4q5J3+mYHrioepT8iWeEFnaN8yTUneSaVN1B+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy50ar8q+v3trqU7dX5OfnmueetkvqiKKh9yvTJGGITC4mvTg72
	jRSJadsX8afOhTIntTuckoBsfwed89tDkLqSpjExm3VsESlS/bm/3S83
X-Gm-Gg: AeBDievdxuK1OKXbrze3K804fevfPP7pVRVlWIhPyEyuV8Zo2uXxfOk/G/O3TZwfuzW
	g+OXkDHNTOGCLhomt5bgEBc/0z1uCzsDkHQhqqc0pZHgrXvvvKF37Grvytk2PeujY3up8pErEiU
	Ihg1BmusgT8/XiHQy7w762OI19Oxd0SGTw6jwF6QW+9AIVBjklcDgsakCkoRqrhkNgLsj814YD7
	gTCHAVpFFRsYnmG5si3kM0d63XKSEdHn2XGqGVb5n9GlxAntrWRJZRGqceb9FF7tqS6E8xgwBHn
	Xpce9ZpHRaYrCjiFB6lCRrvVlJ3IkOxeYhui4OujxsRtGp0r8gt6rQnI7ef+ifyPx2ahUASQF7t
	2xXiURJxIgdHBiv2kjP3maen3gmwQLreXlvW4pkHHzEp9ClghpdtHWgJYJspgTdpNCG4HnwHtFL
	hyIVlJXCaqW1GYILIPLvVlxR6QNQtJ4R2K5HFXOR1vuGoJoWSmYBpgQxdyTLk=
X-Received: by 2002:a05:600c:8b2b:b0:485:3a86:6392 with SMTP id 5b1f17b1804b1-4889979a89amr232373375e9.20.1775573879297;
        Tue, 07 Apr 2026 07:57:59 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:3f9a:11a8:20c3:fe58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5253sm45207018f8f.9.2026.04.07.07.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:57:58 -0700 (PDT)
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
Subject: [PATCH v3 2/2] spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)
Date: Tue,  7 Apr 2026 15:57:51 +0100
Message-ID: <20260407145753.101840-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407145753.101840-1-biju.das.jz@bp.renesas.com>
References: <20260407145753.101840-1-biju.das.jz@bp.renesas.com>
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


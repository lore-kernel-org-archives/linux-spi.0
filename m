Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795875352;
	b=DKkKIoo4SgLKgsbHTjbzKbDg/z8jqsS3hu8UTjedDaJzZm3zpWYNuVEe7xjPSPu3q4mn
	 y6BhDjjcPijkmr0upOxsKB9f/vb0mf1F3DZFe1bBvgdeiPIoGsEBuBBjdEwP6MTZ8ElRH
	 Jcmn8eqAe6s2RLdxAjy+QftHJrlOcvFQCADwSq+QptgBntgLsWT8T1ufJoJxSD3bT1C2p
	 vFSDXVHleoIyO8ztFnQEG3vk0lLlbMfsz4rahfwaeeoslb477G501DCNg6TOajXB9pzfh
	 if4uCuSB38L5VuxAnGP/C4mh/zzT8Q5oEe/vO+eV3h+Y/L2Afj9vSuCggOJ5tIPboyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875352;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ev8d3+xo3xhDELRSOvURnSYyDkv05Teh5t0TRLg5EnA=;
	b=axJYjrfor2kGkVKipCe+szdTzQRmmWdjnnzDnvIy9KgZE7lZN11cc7eMwa3fy1S5+eYx
	 8fuWqyZONf2koYw+8Nu4nkgp/rOaK5+TPw/IDoYeOvUcRKdC731e8Pd1oqXiCeuti3Slu
	 UUTL1iAA2zWHQcSANd7/38BxLvovoqNd7rOQPjk7VYxQmGUz2X+2KNlmnTqRyx6YcDElO
	 YY0YE5XX00I8i7rm9vLFov2oOiUQL7c9TWZ5V6+xLYCadvLfNPvt++qhzRSSyyO6YT2KW
	 i5JxJ21CiIv/cy2r6uXxS/hYhERA6S5Cael50lQaAwBMKnWbPCkez+fMu4kx8AySRyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0elJMzCE;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2333606A324
	for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 14:15:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2333606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0elJMzCE
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-385c497bf94so10143306eec.1
        for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 06:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795875351; x=1796480151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ev8d3+xo3xhDELRSOvURnSYyDkv05Teh5t0TRLg5EnA=;
        b=0elJMzCE2RC6o9t4VBSoRh9LGquJ22F3QTJQ9xjVjm1b7xJb8qy3q9ltf8H2VMvGYk
         vr3Q/Q58cc0kowVw4x01eKDjL07G40Cdqsu2rWV1vvvdUNHPWslJR6Zz2dov7E2RsiKH
         LbKwpVJm2d6IVOsgjXI4Fc9Nx+C5NFVvPmeOTojUBAUqeHk164Z78JiNCpuRmWISvjO3
         o2TqFW0Fepj+uZjgEoBM0hGuYArIeSCWlu4K5eSAWQ2erR+0pv2Yxp6OvsIh0dF3YvM4
         fy+mL4ZYKUySs9RJSVrQm6wFXiHSjJ30EKBuijwlN6ZBy974pnp+mjHxO3ZiOHK8bV/y
         NFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795875351; x=1796480151;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ev8d3+xo3xhDELRSOvURnSYyDkv05Teh5t0TRLg5EnA=;
        b=dhqigIdvODOA/0agjTDJHieFq/DSjKsdya99EmTIIQyt3KUdTOEyOlkwFgehkI7ASC
         BBVgI9YNCuREs4galH3cNm6muntvDI6WXhQt9uqYLRTPtmjUnfgTnB0WyXZfNCFwDVG4
         vzZKoDt7dF8cinD9h2HkGDsI5nuNygf/hYATCodR3/wMjjDAC+Q2QdasoxZVJePvYZT1
         QbcEL8iVPUEdhAOtBsqdmRpq9WebAoJmUDolBIAiDfF/M3Z39cKIzZQqR5kf3g0HgUwf
         /xWOGfUgwV9JJGLjgwKW9LY8rGee0SxiAbbCb+fcJKyoAAkKsrlSbIRMA5QL2IoC5Hl3
         6Oiw==
X-Forwarded-Encrypted: i=1; AL+hErG+vVAtrgTc6sb/x/Ary3zNIj/u4NYCgkCIz8Py+prCTAFrfrLCIjwwe1Z69Ntu7C4hyqeZGNwcPV8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9BXvuqqKjgWhMCcAa1qhdGHxeYlsFG66u1lsy/BRMobpPbxljk
	3svvUS+6bPV+/pGC5UlX7WmMe33wwVAeKaLCCS7L+SBLPVa7nugO0oYD
X-Gm-Gg: AZFdTZdhVte8Jgu2k+KiZtCSxThQrlHq8yGchRghxn1woZhFDCpsDe68XG0ewZoiNlg
	oEWPeGRZD2UkWk5FVx9vJ0yg6R6vmBwA6L3lb6qc8a6LQPOJkNFOWxH1wbOjjYJ+V2Wr5nyAuJG
	Vc26RvgIP3yHMZJhAJD4tCmapap2RzHbNAd1jYqvnbp/7ty0KQe/gvy312mS4upWxyUbfxjVnni
	/IVwtY1xl4AZNVpydhypUlzkX9+rz5uWFIpGFjD0WLhJ1rRVAVFIZfCTyhIgcArwgoM9SLwiIRq
	Fu0tWejPJUR4+8lUTngCYfwuq3iY2y6cUoAUdXCasecnio0b7OdTU9X97V1/DhZ/R8pCbBKs5LW
	lIi5T57X5qAfL29g0RsOsRdFi5HCF0pcFQT7FfBzDQpFU5D3Il4gjsJho4JcBKFIfHm0UD1w7sK
	cWZIZ29evvwdKzYZD4w0uXWYkP7js2C4JSNLgpnWU7ChDRvr06hMj6ZKhjkbb7Q04X9gU9kBb2V
	9sj0wm7fdL0i/cwRr6EiqQe2IXF7n7lnWpm8bzw6usmQw2V9fuIMhRN6ji8U57uf3s6FuHGCfYX
	CnavFeQ7T72nCfVj6Z1Oyu1qHOEPdriC1C2JGOPGMitdczgw6avSaxtbNmaFkh6YbdA3OLLBx9F
	rDvPvlXJ2cG4buf6g0SAA96ZAHbjZ/ZOBQu2tBmz45ZT6JNTarQ==
X-Received: by 2002:a05:7301:3a82:b0:374:ea35:9069 with SMTP id 5a478bee46e88-3856fb67380mr24839784eec.39.1795875350839;
        Sat, 28 Nov 2026 06:15:50 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:241f:982d:147f:bf76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm87185893eec.6.2026.11.28.06.15.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Nov 2026 06:15:50 -0800 (PST)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>
Cc: Leilk Liu <leilk.liu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH 6/6] platform/chrome: of_hw_prober: Support trackpad probing on Tarkin
Date: Sat, 28 Nov 2026 19:44:30 +0530
Message-ID: <20261128141443.13065-7-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261128141443.13065-1-sinha.aryan03@gmail.com>
References: <20261128141443.13065-1-sinha.aryan03@gmail.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tarkin ships with either a Pixart or an Elan trackpad on the same bus.
Both are always powered and expose no reset or enable line, so the dumb
prober can pick whichever one answers, as it does on the Corsola boards.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 drivers/platform/chrome/chromeos_of_hw_prober.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/chrome/chromeos_of_hw_prober.c b/drivers/platform/chrome/chromeos_of_hw_prober.c
index 54d894161..215fa9adc 100644
--- a/drivers/platform/chrome/chromeos_of_hw_prober.c
+++ b/drivers/platform/chrome/chromeos_of_hw_prober.c
@@ -111,6 +111,10 @@ static const struct hw_prober_entry hw_prober_platforms[] = {
 		.compatible = "google,steelix",
 		.prober = chromeos_i2c_component_prober,
 		.data = &chromeos_i2c_probe_dumb_trackpad,
+	}, {
+		.compatible = "google,tarkin",
+		.prober = chromeos_i2c_component_prober,
+		.data = &chromeos_i2c_probe_dumb_trackpad,
 	}, {
 		.compatible = "google,voltorb",
 		.prober = chromeos_i2c_component_prober,
-- 
2.46.0


Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE0B34B194
	for <linux-spi@vger.kernel.org>; Thu,  2 Apr 2026 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775135428; cv=none; b=KlPMvUzdxDrxPhF6OKgjber17J/xqxRcvyRPmfjoYgSopiJzw6Tbp/6FoZD0lu+XngxMctfjNAtD923NwvWQc8y6pe+7M6rtoDjy86O56RjcRBXyTF3hDGPlSHg8SYpEBEHzb9bTjbFlT/ycsRNmNttAEAV8kVt8oJGjVgXAr7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775135428; c=relaxed/simple;
	bh=1vEf0BRhl/MMI0N0/twBdeKMK2gmS8AmhOfkU9TNxzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJlaC6ExBLi6l9nUNG2NZBkknlLaWzeZyiOwWxmediLyIKlJZKrCEzU+UMZVh3/bayg9UHQ8Q1c9bq33OOvk9rdrN++9+Q+/K92xl5qadTCgwEY9n9c85Svg2DGYTj1TRTPuv73lwOgbqJKoWMYzmKPfzrpJcAkTd0LvrBSZg0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8DoEkLO; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8DoEkLO"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so8074125e9.1
        for <linux-spi@vger.kernel.org>; Thu, 02 Apr 2026 06:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775135424; x=1775740224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPbDVvADwWlesPGPPMz9fai2gIb9UfzDS6sF/3W+70k=;
        b=d8DoEkLO8QymT0reYKVmFr0OFWeb2fOlcz7YSZldzi8D5mv7sRZXZGvFqhRJgpGMc8
         VQDkdULkT4/sx4VxAN2YNBMJ/MFvIGbjRS3o0R4YwpJstOHI+TAYuskf+x+o7BFdOCFi
         79Xm7DlqO4GBGA5begA5aQEXJuYpxzqiCUJ6lCCTIpWtjYOIpekDQWGvAuAC9uXlN/90
         gZ5ehopOgEhsVlX2ZoKtjQOugcH4pDhqIqc6sozujllgnplJGpmebIcyJwEjJRxKuy0R
         Te0BfcnZXuK9PhuM9XZyx1mbabVqVRVRL3A/LrIhwk56RNxiXJLXj2cgaprjIUuseP/g
         yz3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775135424; x=1775740224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gPbDVvADwWlesPGPPMz9fai2gIb9UfzDS6sF/3W+70k=;
        b=M0Ry93RpFuZj2FURPo7/0mGTeQt8ulGR93ITof1sIPZk6R3prhbB7i5t8MJI8ICF7C
         Lix7lK3GKXZhSyYqhFewhwULH416zSWdj2mtjeCItQ97TqquIa1B9fpSfsW6njy69kor
         o9NRvbGYS9qZNzuzTvIQcr2L0v68w+PW2I9buvofld+WTTfxwl/qF6CpiKrHF8uad8Bj
         3XAxyHewmwA2Kpe5RgfyLlDiK/Jkz43mhAinIipc1jW0jgJaRnG56yzoE17WIJyq9Mvv
         bnMtvjo88bV5wR5lPJt+G6gdHRh811HCUh99se7DldM1scr0L7ri1JXWFtImMVIAN86y
         oUMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7rvNd1sZ3EQ/YW7lkXUhPJwdv+eoY6w07ZH5/Z5+JiZV96JfV9C69l4x/7QM1MY46T93ZF3RnUkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwXrcOyKk/GMXIVE7VZKpYFCe5crYAWjLbPL7rBMLSbA1Cszw3
	AHt+It5JRP/wu5uIzMz9H4m0WFthsLVgWDl65Qiw617znPI1mDuX5eR/
X-Gm-Gg: ATEYQzylEEaZrpWzIEmoHL//ncGPECErKv9vgrzC40Jq0WlSR4rZszW/dq7zQ2/olgA
	ECmB2dQ8c5Oot1649nybnkkAP+snznDn+6d+/zGF9M7NjcT28xjHTNJdoK5Yttpd/NqyRIif/wt
	KDKmonEFoHAEbprGWHqpdiB1KxOEaOBs3AnhFZFrjMHYYDB5Knzj3I2j1HGEk5X/pbijh1UeJi5
	LLfns5rxSrAQJjJoof6nLiJl/wvdW6HHlERYDjrXYpHKzv3/E+1tSiSy4KRvcRcuROlFght32N1
	xDJ+xwa9YaLRDXAjStdj5yfywnFFmmOa+UCZ1EvAG1GhfG5Xik0hJ7oGfX4QdttdsAnOGHSZn5z
	44DWflMWN56O0kdqyl4XxJnufb1VPN8WDl+9bMSG5cr0fa2WieSJcnUu8wCYUjvGKetCq/X4wFc
	0EQmYpp54jeB0ocSOswVkcl1J71xD+iYca6uSlQiXWx6ksEqzn
X-Received: by 2002:a05:600c:890c:b0:488:7a24:9ddf with SMTP id 5b1f17b1804b1-488835b792amr98024345e9.28.1775135423525;
        Thu, 02 Apr 2026 06:10:23 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:1526:47aa:5ab6:5a85])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a720dsm8040753f8f.4.2026.04.02.06.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 06:10:23 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-spi@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 0/2] Add Renesas RZ/G3L RSPI support
Date: Thu,  2 Apr 2026 14:10:15 +0100
Message-ID: <20260402131020.143123-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

This patch series adds binding and driver support for RSPI IP found on the
RZ/G3L SoC. The RSPI is compatible with RZ/V2H RSPI, but has 2 clocks
compared to 3 on RZ/V2H.

v1->v2:
 * Rebased to next
 * Collected tags

Biju Das (2):
  dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/G3L SoC
  spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)

 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 26 +++++++++++++++++++
 drivers/spi/spi-rzv2h-rspi.c                  |  8 ++++++
 2 files changed, 34 insertions(+)

-- 
2.43.0


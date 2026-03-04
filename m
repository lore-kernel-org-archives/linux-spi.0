Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1F138756E
	for <linux-spi@vger.kernel.org>; Wed,  4 Mar 2026 07:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610553; cv=none; b=bxdrFMybSuGufx6O/tplHW07FMM8zq/UOOIVOF/2pIaiMKC8USTPj8O36pUXPYMEPCcMXU6TpW4OkdXIMFCpWQkIRvHrCgXrx0cKMjzq6lv16Pl631nA7cCx2oTD23TLKqbC1b6WgWh6dp3uFoFbrsTBshN/hvxrP/O3ll79XtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610553; c=relaxed/simple;
	bh=e7lPtmTMcvTguLmDjO9LEHGP6/1tdEJTOrt+13Anzmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JmcP6YNVXyA2choxcWuksEWgfneChYIGI9wpTbPpFHW/iQUvrnol8y3OpKReaBQ1aXIK4AD9PR3RY/IsMJ0hJrURRctoULkhBSo+7sHiWCNwZEDbSIp+pnL1tsfzf2rCnbhlDbyHUbxZ81Doofd427J51OxstwRQsttC44l9LFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acbyI5vR; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acbyI5vR"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-483703e4b08so61442005e9.1
        for <linux-spi@vger.kernel.org>; Tue, 03 Mar 2026 23:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772610549; x=1773215349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zvknzicABFsHxu76HaZco8fpkXU2BWcqQfyY9njxdw8=;
        b=acbyI5vRnrWPprPO5VvNxDLXFOz61E/hjQM2oPSmDX2uq1syV6+UIqoaH23xMHc/ix
         ldW6Sdkd3F5w8bIf3OBroj7NioNFOIU7O/HYatnOTrBqGZ50dI2YyL9M672wppP7GcBj
         urCBB+X+MmyvqbrUi/T78Nl9Ul0beW98Ncpe8nUUSXTA8o97aT4q63Z30sNJiVyitBt5
         r+cL8942RsjS4Xt0pV2Ms5IdLtzRqjuhoW8i3ru+jkq3JKtJdPzp5isRkXKmz4921mjP
         va/OY5yW8vT89PBalLYaZlw5+bhglnHct1QANe+RMwH8p8aRy7e3Te+JkML7g6+rMW/j
         yhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772610549; x=1773215349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvknzicABFsHxu76HaZco8fpkXU2BWcqQfyY9njxdw8=;
        b=bzQZAG0aC0JpuNTNvnU+WxjnlKhW02QAtHNE77JjeXuNeP4celnfgh8U4X7ne02Bs3
         ciVovBQGPeCEGwe73CpUYrkFnkhM2QY1R8cqs6rC/xzfImbp3F+PXt1GjfAUMisYkYJ0
         dhHRf8cmtKeLGz45biywiQ2JjKCs3jazeSVkcCw+gFCNqQIvCNsLjzI8pmiO5NBNbPYD
         XtJoZrGL5sf5ezUX26zO/3ifTu8xrgmRdL4RK5zJZvLArhcJ0yP57sYoi+eoVGRB5AXe
         x0LYLdCjvyh1mNRzZJ55SYrYCxF9PSWEL3UjwJIC2qZvhyZbfhYdh1tcx9m7hApMZFb4
         +IMA==
X-Forwarded-Encrypted: i=1; AJvYcCXEhMWtHX/6rWsRVVhnwvEe6Rm1cqyd3OkQfw7AW/KwWQIPjPwXSHIFyDlYTvzYDEdz/jXkX67h90Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGUZi3h2Uat0KSB4hPvPgdPJ53dxsS/6WaWmgOEyaMfHFkHyRq
	Mia6GWkYR2paVojgdM4NT4dGwAzsk+3BhHrQC6yLGc2Kb6B7MwA95cWC
X-Gm-Gg: ATEYQzzXHa4WVueZ0vljO3e5F8VzNB1Gev/o5a72CsigvAuGklohW7R+xaWYb4w01oy
	IGIFDTWIKZ8NtdYIryHq5d/mwHfluS9SmTN+N8z9GRjWxT2gzLnzFapv7nqaIaPLErAJNOBmmyo
	cCM4eFIpFZhwlB/uwSlv6L7DrNksbarwLorkk2T5rhfn3vvUNjV/llDPr9oYt0zx63ru78JE8jp
	/o/8OimfpZhFUZgFrQNpQW2ASfXBwIocMAEkSB5ujOD26f2+xqKVaiz/+kSKyYwmQUkiyUU3PwF
	oZc3LUoI3HoDn16tCj/dEUMwyVVnwcTXO959wf5x6v3lfacgw4AS2Vx+u0dO7RHyay8l4Vc6YOz
	VHdNKePVZewuBv/PX2bsvHsrT2iTmVM1jXa7fO9CUvufSz9cn66dHVKkEHFHkgN4wa2o87RiWB8
	3ZjOTqx6ktZBjPJjw+mfwnIa+CiXPa1mw=
X-Received: by 2002:a05:600c:648a:b0:483:6fe3:bb49 with SMTP id 5b1f17b1804b1-4851370354dmr94872985e9.0.1772610548917;
        Tue, 03 Mar 2026 23:49:08 -0800 (PST)
Received: from biju.lan ([2a00:23c4:a758:8a01:de3f:f927:40ff:12a6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c75a25dsm39957572f8f.21.2026.03.03.23.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:49:08 -0800 (PST)
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
Subject: [PATCH 0/2] Add Renesas RZ/G3L RSPI support
Date: Wed,  4 Mar 2026 07:49:00 +0000
Message-ID: <20260304074907.9697-1-biju.das.jz@bp.renesas.com>
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

Biju Das (2):
  dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/G3L SoC
  spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)

 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 26 +++++++++++++++++++
 drivers/spi/spi-rzv2h-rspi.c                  |  8 ++++++
 2 files changed, 34 insertions(+)

-- 
2.43.0


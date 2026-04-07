Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DB133D4F8
	for <linux-spi@vger.kernel.org>; Tue,  7 Apr 2026 14:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775573880; cv=none; b=Zcqy19alYGAnEBjEQ/Rn2dmSonNS945dR48kBVbTPItBMxa5iV2PgO3zxLaw8btJ8HR37cN9xEHtrnEL97/bKF8vxT5Uy/OAwmie2YuPSanwsvCPLGy0r+MhO8HkD0r9fYEoOE9VWva+Qf+nhKx3A9imKRg4kO/kTXubo4mGtxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775573880; c=relaxed/simple;
	bh=cyqmsmFaUhWO0usCsRhXLb1p8EfZ2EfkZtfAQtdHSG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMcV8hEyoCxsE/4lqNvK5+BtHVma7jw35vbCQMchUnRTsP6oaGZxF8MK96ocWS20ciicerpMAO/f8Yxwr24bunPJzZXt+sEm2CcmbsvBFYO0sGLUbluZs/syo8kqJZHRZDGKfmp+YLnqXl33vBew8iN1ARhMDhdIp0S6tGNq4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcGu+MWK; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcGu+MWK"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43ba1f3fa7eso5419751f8f.2
        for <linux-spi@vger.kernel.org>; Tue, 07 Apr 2026 07:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775573877; x=1776178677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2khtJu6y4LBtKzkynEVHeXEXsp2G3dQZozt2yDEDQ5I=;
        b=AcGu+MWKaxBlR9OCuaRg/7FY7dedBby8JeBdw3lXPsl+7J9IQeRFcI96xzHyd3rbOX
         Sp+Pp7Evcke/1ZnhMNLq1M8hAe6jD9GZb0N7uqHadPus/OspDp4N/Vj3Lsl7famsIb8q
         tln/3snA0MZJVlTfzmYD33emyfNcZayHPSVrLHhywnNGFOgkB0pZOSoUHzNtdWiau+iX
         s6KIapwhGmoJ387YqVtSmoY9PuhBp49gmdTBZQ60PWS/zN09gXYLySbmHmqLmxJLQ8E3
         ZOX/38psK82LqIUX+JPUDocBMNY5ESGhIbjmkEbL6AUA0qaneI70yFhjUJI6zmD8O6mp
         89vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775573877; x=1776178677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2khtJu6y4LBtKzkynEVHeXEXsp2G3dQZozt2yDEDQ5I=;
        b=Ou7KrXp7w4NatG0S3ieQE2iFDnw4ICNg9fG4hoi+SjkaPLqXlNCcO+vSe35JjLRIW8
         ECA4qW692/4n4+u+fB3cx4m8b69W5hTtqo8I2YII4Bm8uvjrTkmQgB1CiE/9wl+vCR6e
         33JhERKamwApxtBDV494BaTfiZNL49Xt9uWSPojUOt+cSbr4Sx6yPiX6xQklVSRjFxZt
         h/7v9Jtygdd7X0/uSwlwqGQthMs6IymtFImib/MdEAD+3cq27jkfTn6pG/QlQ3PBswOU
         0opl7UMHSsXjWzOwqWjjO1z22fp3EWWzS0yeTDEiYg6rXQo14DmTUHrvTb9Kq3uJK6dG
         ZZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCWRmGOXAS8PXPba2svjCrwNvM8HCpqkSuI2OFB9rCtMgpxL8ZnOLWHnB3lgRddNkSpgAQjR30QRgTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzM6CYeVixviEf1YwDlar4tQsbCW86P7Kuqc9XTbkxRtdh6o+k
	KqT6gR4FbOup8xBhdhd99hH8moj7AK/Bd8GZqp7S/TePok5qKbD7QFvq
X-Gm-Gg: AeBDietY8tV5zyG7rIuityecYzYatOVlV8HL7j903a4jFBPVWqRGR+TNOD97tw90KwH
	HLKqpx/3DdfdIWbxxWJM+iAwbDh/xf5PgKfh1eC5wfgAKMmRxvSB9aodrMkdHQ2KRJomMSxQRrI
	4GS7Fpk9hlGYvl2ARFnzKypaLTyOgloSVPZLTwdAL785uf7fuRGv7MeegqD0Jz7v6jsvCyTL6al
	ggF6fePYk85zeAQPTlGwR1ZluDO1zEDIY0Oy/6J5FOt64PIvVPrymt8f+vvdSugDOgS2nRTlMld
	WrhSQU2zyUooVlwDcPi1f9USy7NaS+nexuuGjP2R2aYPp95XSIfWPvQ34L2YV+xj3fWmPvcUbnZ
	/WmuJZawFwcPOveTxK5MXAvuh5gvErGHvrQVXznJtKkT4YRnh5DTDP3AtdAV6fl/XHDfzNoKXBi
	7+FK7q3yuLR+QT8oEgDzxwLnjYtylvPrJZq0duVl/2mF5Pu4XJ
X-Received: by 2002:a05:6000:401f:b0:43d:2be:e4e with SMTP id ffacd0b85a97d-43d292ff520mr25307993f8f.46.1775573876941;
        Tue, 07 Apr 2026 07:57:56 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a758:8a01:3f9a:11a8:20c3:fe58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2c5253sm45207018f8f.9.2026.04.07.07.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 07:57:56 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Add Renesas RZ/G3L RSPI support
Date: Tue,  7 Apr 2026 15:57:49 +0100
Message-ID: <20260407145753.101840-1-biju.das.jz@bp.renesas.com>
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

v2->v3:
 * Added ordered DMA names for the dma-names property.
 * Dropped the tag from bindings as there is a change related to dma-names
   property.
v1->v2:
 * Rebased to next
 * Collected tags

Biju Das (2):
  dt-bindings: spi: renesas,rzv2h-rspi: Document RZ/G3L SoC
  spi: rzv2h-rspi: Add support for RZ/G3L (R9A08G046)

 .../bindings/spi/renesas,rzv2h-rspi.yaml      | 28 +++++++++++++++++++
 drivers/spi/spi-rzv2h-rspi.c                  |  8 ++++++
 2 files changed, 36 insertions(+)

-- 
2.43.0


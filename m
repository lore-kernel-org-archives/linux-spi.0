Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886423B7B71
	for <linux-spi@vger.kernel.org>; Mon, 31 Aug 2026 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788219154; cv=none; b=MEdrDFNPRDsBmUzqum/UvkpU2tUkWzxnXb7hVX/JY1vkpmfNl+5KSIVX3t8UMRr79ZIUeYs2UAybEVVQmMCzeyVxf3kLSznIi/FU5SD1yNB5sy49LbUVxEGYK3dHy0z4rGIbv6LXP+1gqZKGR478mBLcjoDmTgS/luejVMz3Rdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788219154; c=relaxed/simple;
	bh=Z5Phb0NYnzJ9UJstyCcMsnXLSLAEeBoTZwfa5AdVlKI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=V9mRIsiquQsB5o3M721GX87Oe0LtenUoBslNPk2xbvhAukioJmHfCUZ75+P5bKjZ1///mXfbqORMJSSe6nAY/sxYwHp6aHGSdawazJ1DwDRTliNGSFOfz0rck3WNlaiGh6EQV+s8iFvzap+D8B2s9c8WxKQJJJ6TanOZFVDF6DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYOHPmkE; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYOHPmkE"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc1cb48db3eso417971a12.3
        for <linux-spi@vger.kernel.org>; Mon, 31 Aug 2026 16:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788219152; x=1788823952; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=djOgvsv3VuaYv8IJ6t6EG50/ulOg85QJhyL5jpcElpQ=;
        b=aYOHPmkElOnmK+KSwbGx5Occ86UKXSB0Nt+Za6xlAvgg5IqkeAN8AELMPU8tsvPXb6
         B6adSFeiKyY0u1HIFX9TV8HC/VoSnVqJNd7cQl4biKaEuIsGziDunzongBfZkIaHphUP
         cG8C7ujZQ2B9thIYtbPWpCz9pULv7LnimVOBJb8V/MD1E/Ci8tZF1s4Kue14Mrg52Igu
         0AaBSHvGSNE6pR8NyEyrsvczv84vRIDcsjHbpobADRKwf5JsNGRA3M/YZMRg9ZNyl95q
         O8vmoQYRQv944ttmE7uhlhOX/8K7Myl2ETVqxoEhFFTZtSQH1ODMaGyjLCXQGLJ9LCN/
         37fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788219152; x=1788823952;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=djOgvsv3VuaYv8IJ6t6EG50/ulOg85QJhyL5jpcElpQ=;
        b=VkuKccCsBnSVP7zteRSHilXyKVPaBT2csRVjwGu2Uip8pfY0WDpOCPq+srvCNQSX4k
         76ys5g4u0+qw4oXz5DjuvJvq8pi+03DpOtQCOhniaiFHEa12covnPPeYkFd7w3gZv7eL
         xC9vImSk1g5C2aHKfVBf7gbJv8BK97zV398yHofc7P4gchkmLLWzPaDVolmldEAFWfrR
         o6yBohEEJZDnmM8Wb8r+rYNEdtnRAWBhrwjs3JcDt4ol9Q8jhuZnyTGlk+OQsxc6Afkw
         MSHwQKahFOXPDXgnUKQ9rfndPodiU46UOvJe+c9M4lQZpFy6ehhcO2rHZjJyM1CY0fF1
         IHvg==
X-Gm-Message-State: AFuF++nzfoyLRyAJCGJFhP/7IWzOwWziLD6h87vP27qYcC0llgs5xs2C
	TncVZV8nkI4PrPxxhWh8ginEJwcLKQo+zy0lAmbs2q6/Cf6u1OKJXgA5
X-Gm-Gg: AR+sD132Sldto14FzQGaGh4UC7Qtr6uJike12aBSm2kAjSEmywcVqd91Aem3s64dO6B
	NDMjQYu/tvQnhVf2VMJVhBweQdKz9bkuoITz1IGQR3KIWcx9loEB1gnt49vvujlxrxs8p7qey8q
	7PEAWDO9xw2SogldzohSjsS0pRtmhHl12cw79zaTIOcbC0pb86RhqrextaT4brKydHP5fX+UZwR
	e4jG25nShMGWlw+O7k3LYaao059bSCoGVPxqykRZJNakv17euzVmYDDVc0mWSh4jqD8+Q4lTERP
	lKLogbRXJwbtQw7Fjn5SXGW2CnHXThHilKC6VajOK63agi3nnCOe48LOSQIWGKKowBKI7Km9MGz
	9XUh3+i5QDOhxGRvs5dx7uyVwYSTbjeTmNuYcudCqRqwbqbyPdDDecjR4UyGzz8PpMthXn8ZNOl
	TbiiUcTgRnltN43JafKx7K4ggE65CarbjJg5EOa1EgHxVJk9XrHL4unAjN2yiSgm1EiwHRRMo=
X-Received: by 2002:a05:6a00:13a8:b0:857:e68a:85b0 with SMTP id d2e1a72fcca58-857e68a9896mr15906207b3a.0.1788219151691;
        Mon, 31 Aug 2026 16:32:31 -0700 (PDT)
Received: from [10.60.78.252] ([2409:40c2:5002:4362:354a:8f21:7ceb:c8a6])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85be5ca747csm154393b3a.5.2026.08.31.16.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 16:32:31 -0700 (PDT)
From: Bhargav Joshi <j.bhargav.u@gmail.com>
Subject: [PATCH v4 0/2] spi: davinci: Convert bindings to DT schema and
 clean up DTS
Date: Tue, 01 Sep 2026 05:02:09 +0530
Message-Id: <20260901-ti-davinci-spi-v4-0-92e9c0b2e1d4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33MTQqDMBCG4atI1k0xYzKRrnqP0kWMiQ7UH4yEF
 vHuja6kpWVW38DzLiy4iVxgl2xhk4sUaOjTkKeM2db0jeNUp80gB8xLgXwmXptIvSUeRuIOpUt
 XVlghS2icnKfnHrzd024pzMP02vtRbN+fqSh4zo32Ste+VoBwbTpDj7MdOralIvznkDha9EpoI
 QGqT14cuf7iReJQlFJaXymH5sjXdX0Dwx49aCoBAAA=
X-Change-ID: 20260816-ti-davinci-spi-e64e4e48b6b6
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 goledhruva@gmail.com, m-chawdhry@ti.com, daniel.baluta@gmail.com, 
 simona.toaca@nxp.com, j.bhargav.u@gmail.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788219139; l=2055;
 i=j.bhargav.u@gmail.com; h=from:subject:message-id;
 bh=Z5Phb0NYnzJ9UJstyCcMsnXLSLAEeBoTZwfa5AdVlKI=;
 b=u4rRQ5rJsS4NBxCoSKV+pujQp/KNxj4jWfDkbV0TPh/Pu9fmvcCSKTBA+2Hgb9ZgqxG/Tn6ax
 1IY74iK2niqAVUCsDqPOgdZg8kIWvTgAgkXcezC+I++Eh61n020pXKg
X-Developer-Key: i=j.bhargav.u@gmail.com; a=ed25519;
 pk=IqNDwUZKECEA+n8wXctFLBbYL9NhFstZNbOznm/nX1k=

This series converts the TI DaVinci/Keystone SPI controller device tree
bindings from the legacy text format to DT schema. 

- Patch 1 renames property ti,davinci-spi-num-cs from keystone-k2l.dtsi,
  as the driver uses the standard num-cs property.
- Patch 2 Converts ti,davinci-spi from text to DT schema.

Signed-off-by: Bhargav Joshi <j.bhargav.u@gmail.com>
---
Changes in v4:
- Fixed spacing in example.
- Fixed commit title.
- Rebasesd to latest mainline rc.
- Link to v3: https://lore.kernel.org/r/20260817-ti-davinci-spi-v3-0-23844cfb5e6a@gmail.com

Changes in v3:
- patch 2: since old text binding required num-cs, #address-cells, and
  #size-cells mark them as required
- patch 2: davinci-spi don't work as spi-slave i.e address-cells 0 is
  not applicable and spi-controller permits both 0 and 1 so explicitely
  define #address-cells as 1
- Link to v2: https://lore.kernel.org/r/20260816-ti-davinci-spi-v2-0-6c6f5171422b@gmail.com

Changes in v2:

- patch 1: Instead of deleting ti,davinci-spi-num-cs, renamed it to
  num-cs to properly preserve the hardware's intended chip select
  limits 
- patch 2: Removed  maximum: 6 constraint from num-cs.
- patch 2: Add standalone support for ti,dm6441-spi in compatibles.
- Link to v1: https://lore.kernel.org/r/20260816-ti-davinci-spi-v1-0-a7f57dfd5262@gmail.com

---
Bhargav Joshi (2):
      ARM: dts: ti: keystone-k2l: Rename ti,davinci-spi-num-cs to num-cs
      spi: dt-bindings: ti,davinci-spi: Convert to DT schema

 .../devicetree/bindings/spi/spi-davinci.txt        | 100 -----------------
 .../bindings/spi/spi-peripheral-props.yaml         |   1 +
 .../spi/ti,davinci-spi-peripheral-props.yaml       |  25 +++++
 .../devicetree/bindings/spi/ti,davinci-spi.yaml    | 124 +++++++++++++++++++++
 arch/arm/boot/dts/ti/keystone/keystone-k2l.dtsi    |   6 +-
 5 files changed, 153 insertions(+), 103 deletions(-)
---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260816-ti-davinci-spi-e64e4e48b6b6

Best regards,
-- 
Bhargav


Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1D43F23CC;
	Wed, 30 Sep 2026 07:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751619; cv=none; b=A2TCvEIRXt2dYeGQZTDZyP0FY/KGuwqaq8qhb1gVaEGXIE7pDoOSy5lg+Df/MuL8bD8WxKGoXRQgV8pIoNDS3x8a9z3MbmIoU3ooz8n7KJU30+QGG2kdRyRIEIHoUNx/nUFo9sMQmRjaxMaDKRI2zHb3IbuvbgXVSAvNzjjXfBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751619; c=relaxed/simple;
	bh=FLvs1pKcp2zSWS34lK4v8ScH3W2KBQlLbK3v28aljrw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jH34UH4ChH25Jpr1qHyUZ+6fuIezv+JSoBXiXGm5Al1E7ROGegGFfk5JTC98dJUXKqzG6+ctERTRaeW3R12KTCTl+arMvdnFnMctf287GZXG35zIMsmuAcFX28g7FoAH7OUIfu29ZxSHh3LhW0pSymWI/jKbnMR1DSB2/SIpFtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bVJlflzc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bVJlflzc"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 68U6xjt571887164, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790751585; bh=YfCQbHCG7qtZNb7dCGrPKGu3YgtYViDe4GqfkSQkqk0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=bVJlflzcxtA36yL4D8iR5PgBXkK0gfom+O5dVr9PPq2N+dEqW/zSz/NJCQI43O3KH
	 10lVEOVdXp9HQYrWLdiOxs4GqysuCp/WsOaYp35g0FewGuJ0T7JnyyC/H0M8SXc5RX
	 D+zMwRHIfwLc+GNX/6jXBqrK9O+UBrO31bJEtytbBxmQwcjwfvsopd2oC1oII8AJOr
	 LNWDUn9TYxMr5C3VZ6aOZTXFruS+krv7OQRj5E2f0KK0H9JApQloVFOXwEI38PacfY
	 yt50TPgQ0aufzYz6yEiAAm44L8TrxtDHp9++yl0jHA6xfSjec1VX8GC6K494tqjGKr
	 BnYKRqMaq3CeQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 68U6xjt571887164
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 30 Sep 2026 14:59:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 14:59:46 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 30 Sep 2026 14:59:45 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <p.zabel@pengutronix.de>, <james.tai@realtek.com>, <cy.huang@realtek.com>,
	<stanley_chang@realtek.com>, <eleanor.lin@realtek.com>,
	<jyanchou@realtek.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 0/2] spi: realtek: Add support for RTD1625 SPI NOR Flash Controller
Date: Wed, 30 Sep 2026 14:59:43 +0800
Message-ID: <20260930065945.88008-1-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Hi all,

This patch series introduces support for the Realtek RTD1625 SPI NOR Flash
controller.

Thansk,
Yu-Chun
---
Changes in v5:

Patch 2:
- Fix the initialization and teardown sequences based on Philipp's
suggestions.
- Add the check for unsupported multi-byte stateless commands in
rtk_spi_supports_op().
- Move the hardware workaround for 4-byte mode switching to rtk_spi_exec_op().

v4: https://lore.kernel.org/lkml/20260909125701.273314-1-eleanor.lin@realtek.com/
v3: https://lore.kernel.org/lkml/20260908111640.2032749-1-eleanor.lin@realtek.com/
v2: https://lore.kernel.org/lkml/20260906145755.1230079-1-eleanor.lin@realtek.com/
v1: https://lore.kernel.org/lkml/20260904031252.244280-1-eleanor.lin@realtek.com/

Jyan Chou (2):
  dt-bindings: spi: Add Realtek RTD1625 SPI NOR support
  spi: spi-mem: Add Realtek SPI NOR flash controller driver

 .../bindings/spi/realtek,rtd1625-nor.yaml     |  65 ++
 MAINTAINERS                                   |   6 +
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-rtk-nor.c                     | 624 ++++++++++++++++++
 5 files changed, 706 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml
 create mode 100644 drivers/spi/spi-rtk-nor.c

-- 
2.43.0


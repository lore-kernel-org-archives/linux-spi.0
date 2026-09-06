Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EFF221F39;
	Sun,  6 Sep 2026 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788706694; cv=none; b=dhu57jKHTB5ap8ftdAeii87cEsaMycJ9wlbZlwk57uY4q8/Q+iuSoBrJXfqQXecu8UMlWv1bBpUKFEKC/sTtOlexJWTh/SpY+qmipwsn2GyIMdsPioV3STGh6wSyxoBa3cgSECXtxA+DLmPZJx3aRYJhSn3AhhmyEweu5l7ML30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788706694; c=relaxed/simple;
	bh=MVcLgggaWyruXfyN1BNweCSyr3THPYrIxjee14sZrlc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KHKWl8sAiZOMtnyJCSkjqkfiY3MPk6cdZDNlVH9GWDa3x+9WjNoA8gIlApvVH/8XBwXTweKa43AAPUz70trqjT76TKP6L2Nf6euLzpC6QoTBTDs9bIHh3Cd3ojmGd/9wJgeeL0QN515r4N9fVKcOe2+mshB+NAaIdPFaDrpjgGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wZU0gUJE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wZU0gUJE"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 686EvuRS32020808, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788706676; bh=8HcEcqHp68g4Vh+ciwgOGWeQeGwe9lWxEKHt5DqfTKc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=wZU0gUJETB3FZbG4eZ0HJ5w+FCkRCJuOx7NASuc3DX/390vL0J2Yh/S2e4/52EyRV
	 izd8SVOVr66TEaWFTrWgo+wRzlh2JJhf6piT2Y3us7cW/e5lYueKnwYW98O6LxpOq1
	 kbfoXxlozAofUChGZbWjjWhxUlPNQ8zL2g3/z4x4Dj2t4igEmJA8hi3A/Ldau5JnKn
	 ElZ6TS4uiUlnXbANr2GO9IQkR8P3tM5pF/4YWrCZeW9ZSlTnObGg7pXCkaYRArpzEf
	 VMyRHMKGibBbickNQ4HZIQZKlI6XEdHwNSID+ATp/NcvTgjpwSWdrbq9h7wg1Z4Hab
	 DbJ8erfIp1cwA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 686EvuRS32020808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 6 Sep 2026 22:57:56 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 6 Sep 2026 22:57:56 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 6 Sep 2026 22:57:56 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Sun, 6 Sep 2026 22:57:56 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <jyanchou@realtek.com>, <p.zabel@pengutronix.de>
CC: <afaerber@suse.com>, <devicetree@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<james.tai@realtek.com>, <cy.huang@realtek.com>, <stanley_chang@realtek.com>,
	<eleanor.lin@realtek.com>
Subject: [PATCH v2 0/2] spi: realtek: Add support for RTD1625 SPI Flash Controller
Date: Sun, 6 Sep 2026 22:57:53 +0800
Message-ID: <20260906145755.1230079-1-eleanor.lin@realtek.com>
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

This patch series introduces support for the Realtek RTD1625 SPI Flash
controller.

Thansk,
Yu-Chun

---
Changes in v2:
- Dropped the DTS patch to avoid apply conflicts.
- Removed clock and reset header inclusions, and replaced macros with raw
numbers in the dt-binding example to resolve dependencies.

v1: https://lore.kernel.org/lkml/20260904031252.244280-1-eleanor.lin@realtek.com/
---
Jyan Chou (2):
  dt-bindings: spi: Add Realtek RTD1625 SPI support
  spi: spi-mem: Add Realtek SPI flash controller driver

 .../bindings/spi/realtek,rtd1625-nor.yaml     |  65 ++
 MAINTAINERS                                   |   6 +
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-rtk-nor.c                     | 637 ++++++++++++++++++
 5 files changed, 719 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml
 create mode 100644 drivers/spi/spi-rtk-nor.c

-- 
2.43.0


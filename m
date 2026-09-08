Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758F4FDE78;
	Tue,  8 Sep 2026 11:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866225; cv=none; b=VrVJSuX8OExBbcKwYVT8XxCu5MOq6tR9ALig8DP5e3xhrTPwOANZTzMx3GnVEk4ww8dYE0NwhHJjk8dPDhQMCpF4vDO5xAETWtP3R9E4RzJBP8qVhFX3zKuFcTWvN2einwohnZB57/pfh7hTvmaFYFPiHEQEA1Il1D7Do9oqtuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866225; c=relaxed/simple;
	bh=tMvI0hLZTaC0e9X21b0/9HxOrIOwMf/d57+XNT7Yidw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iieYV+i/JeM7z8KpwEpo+4f1hMHAzWPpmizvADTLmfgMSKsHOZIPI7stgQ5bjqpt24Fynf3GK8k3DNPfFCdQ+hkIZcM501oVA4GiEffyMp1leTeQtb20NGlYp/dgv17hZKuOEWphdyJLkhjXIYof9E23wu0T1VNY/YDKKTIS8ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=isrb1ZHE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="isrb1ZHE"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 688BGeejE3868315, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788866200; bh=xJPz6x4UeTrmhs5HtckqmYCQLpO6tU6cQhKJ5b0QYl8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=isrb1ZHEWQcSaGD5txuGJsGo7MhCzFCd8/V1G++jUx0OIorMOYz4weXDSrtQ6drf8
	 8yV+Ly+OhyNaTNoUNeHO1x1GZdFp4T1SxG4kuVxy9Ajnnrhf6qefjW/D0bClOR2OR1
	 4aJY/5/eFImt0iiYfHc7QshrdoLK3RCZ/1X54an3E7a9NjMIS5hZPgQOvD0/jfCBlo
	 XwyT5b9lGGS4olD3fAVr6dAg09E4EJQ1ZObLEji9EKU7kp+JtUKUQsk+fodUUsEKws
	 WA/q8ShCRzzjSDzCzsX+1DaLGgo3bk66yCo8VhZ2+hYm79EVoeFdVGP88U+9YBqa+J
	 FAEAmb03bumdQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 688BGeejE3868315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 8 Sep 2026 19:16:40 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 8 Sep 2026 19:16:40 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.43 via Frontend
 Transport; Tue, 8 Sep 2026 19:16:40 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <p.zabel@pengutronix.de>, <james.tai@realtek.com>, <cy.huang@realtek.com>,
	<stanley_chang@realtek.com>, <eleanor.lin@realtek.com>,
	<jyanchou@realtek.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 0/2] spi: realtek: Add support for RTD1625 SPI NOR Flash Controller
Date: Tue, 8 Sep 2026 19:16:38 +0800
Message-ID: <20260908111640.2032749-1-eleanor.lin@realtek.com>
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
Changes in v3:
General:
- Specify "NOR" in the commit message and descriptions to avoid future
conflicts with SPI NAND or GSPI.

Patch 1:
- Add Conor's acked-by tag.

Patch 2:
- Add Yu-Chun's last name.
- Make SPDX license and copyright notice headers in C++ style.
- Drop driver-internal polling (rtk_spi_read_status()), leaving the status
polling and timeout handling to framework.
- Track the 4-byte addressing state and properly restore it in rtk_spi_init()
to prevent state loss during runtime PM suspend/resume.
- Add hardware cleanup in rtk_spi_dma_transfer() to explicitly trigger a
graceful stop of the DMA engine if a timeout occurs.
- Replace RUNTIME_PM_OPS() + SYSTEM_SLEEP_PM_OPS() with
DEFINE_RUNTIME_DEV_PM_OPS().

v2: https://lore.kernel.org/lkml/20260906145755.1230079-1-eleanor.lin@realtek.com/
v1: https://lore.kernel.org/lkml/20260904031252.244280-1-eleanor.lin@realtek.com/
---
Jyan Chou (2):
  dt-bindings: spi: Add Realtek RTD1625 SPI support
  spi: spi-mem: Add Realtek SPI NOR flash controller driver

 .../bindings/spi/realtek,rtd1625-nor.yaml     |  65 ++
 MAINTAINERS                                   |   6 +
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-rtk-nor.c                     | 620 ++++++++++++++++++
 5 files changed, 702 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml
 create mode 100644 drivers/spi/spi-rtk-nor.c

-- 
2.43.0


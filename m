Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491D54B1CB;
	Wed,  9 Sep 2026 12:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958638; cv=none; b=Q83sFp9GxjRQpuv5jS6AfTss4aGjZaNHGdwl7nMIByOPltD4y3faKf9iXkExvf9e1zgVB1BxNeOUCcxgvqVAJwVys+etZBJrxPX3KQ1J4S9vICfP3KLiYowrnHdCi8VthKf4WhS7y5RpnWfRhBxDavs61yE4ajrn0NLzQoCdKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958638; c=relaxed/simple;
	bh=tdreiLwIS05AdMPP74uZG2hXsYGJW4b8eSocskwbFKw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qrQ7YGJdH0UPj7gOt1fXU3K9SQzfWPYFGqPqkso/DhQs1PyhRrh7svKTk8j9fUvw+xOJv1c5gLzf9i/sMxh0x9pQk8Sd/RJggtrSCF0SR0iL6VxE7IRnPU+gN4jVmaDLOsv511xqXlhBsMWWX8CVhvY3dd2jSLt/tdV7A8yvox0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=A3hpnu41; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="A3hpnu41"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 689Cv1lE5624288, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1788958622; bh=t4CbWs9yYsovLZ4KQtJHg+cOy5SOzfflAszrgWwrXVg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=A3hpnu417eyXY2z5d7lcQj4A3JfyLtnj8qko7Ar5RSnG6coMpnMu4chrjLyXdso+Q
	 lAutHmPXsHhAwaej+KytGWLtbTatlwyMWbCkijnybqAYs+oh/mTe8zCLOB+2kyFAUm
	 EV5qKh5J1NCTI1U+p7hMw7MKhje/ZTBDdCiLqL8+DvRzSVZE+RKs1s0LCyLdTJTM9y
	 pdgUm2O7J2N9fVbsNvj+vhsE3IUNKeM1dS67PRJtwbdzYVZhaXqVn+teG1y5H9ret5
	 FEyhtY1znnh04cwBWJbwvlfjOSH/31z5l2fo3f+CdlU5Dj4sZLrWOvehlN9t/+BNyZ
	 VeSkYE62v7/Rg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 689Cv1lE5624288
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 9 Sep 2026 20:57:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 9 Sep 2026 20:57:02 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 9 Sep 2026 20:57:02 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 9 Sep 2026 20:57:02 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <broonie@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <p.zabel@pengutronix.de>, <james.tai@realtek.com>, <cy.huang@realtek.com>,
	<stanley_chang@realtek.com>, <eleanor.lin@realtek.com>,
	<jyanchou@realtek.com>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] spi: realtek: Add support for RTD1625 SPI NOR Flash Controller
Date: Wed, 9 Sep 2026 20:56:59 +0800
Message-ID: <20260909125701.273314-1-eleanor.lin@realtek.com>
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
Changes since v2:
General:
- Specify "NOR" in the commit message and descriptions to avoid future
conflicts with SPI NAND or GSPI.

Patch 1:
- Add Conor's acked-by tag.

Patch 2:
- Add Yu-Chun's last name.
- Make SPDX license and copyright notice headers in C++-style.
- Drop driver-internal polling (rtk_spi_read_status()), leaving the status
polling and timeout handling to framework.
- Track the 4-byte addressing state and properly restore it in rtk_spi_init()
to prevent state loss during runtime PM suspend/resume.
- Add hardware cleanup in rtk_spi_dma_transfer() to explicitly trigger a
graceful stop of the DMA engine if a timeout occurs.
- Check bounds against the direct mapping window (dirmap_size) in both PIO and
DMA transfer paths.
- Add reset_control_assert() in the probe error path and .remove().
- Replace RUNTIME_PM_OPS() + SYSTEM_SLEEP_PM_OPS() with
DEFINE_RUNTIME_DEV_PM_OPS().

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
 drivers/spi/spi-rtk-nor.c                     | 623 ++++++++++++++++++
 5 files changed, 705 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/realtek,rtd1625-nor.yaml
 create mode 100644 drivers/spi/spi-rtk-nor.c

-- 
2.43.0


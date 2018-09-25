From: Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH v4 0/3] Add Mediatek SPI slave driver
Date: Tue, 25 Sep 2018 10:20:40 +0800
Message-ID: <1537842043-15255-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <yt.shen@mediatek.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

>From 7f2423debd91771a1d3a5ca02cd3990f1417bcb8 Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Tue, 25 Sep 2018 10:11:44 +0800
Subject: Subject: [PATCH v4 0/3] Add Mediatek SPI slave driver

v4:
1. Fix Mark Brown review comment about kconfig & driver.

v3:
1. Fix Rob Herring review comment about bindings.
2. remove unused variables in driver.

v2:
1. Fix Sean Wang review comment.
2. remove unused register and offset define.
3. update bindings file with assigned-clocks and assigned-clocks-parents.

v1:
This series are based on 4.19-rc1 and provide three patches to add mediatek spi slave driver.


Leilk Liu (3):
  spi: mediatek: add bindings for Mediatek MT2712 soc platform
  spi: mediatek: add spi slave for Mediatek MT2712
  arm64: dts: Add spi slave dts

 .../devicetree/bindings/spi/spi-slave-mt27xx.txt   |  32 ++
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi          |  11 +
 drivers/spi/Kconfig                                |  10 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-slave-mt27xx.c                     | 554 +++++++++++++++++++++
 5 files changed, 608 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
 create mode 100644 drivers/spi/spi-slave-mt27xx.c

-- 
1.9.1

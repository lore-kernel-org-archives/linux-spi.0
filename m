From: Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 0/2] add SPI driver support for mt7629
Date: Tue, 20 Nov 2018 16:41:06 +0800
Message-ID: <1542703268-17285-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <ryder.lee@mediatek.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

>From 51ab18abe1ad0f8ef0bc88696d956431f3e01f3f Mon Sep 17 00:00:00 2001
From: Leilk Liu <leilk.liu@mediatek.com>
Date: Tue, 20 Nov 2018 16:34:22 +0800
Subject: [PATCH 0/2] add SPI driver support for mt7629

This series are based on 4.20-rc1 and provide two patches to support mt7629 IC.

Leilk Liu (2):
  spi: mediatek: Add bindings for mediatek MT7629 soc platform
  spi: mediatek: add spi support for mt7629 IC

 Documentation/devicetree/bindings/spi/spi-mt65xx.txt | 1 +
 drivers/spi/spi-mt65xx.c                             | 3 +++
 2 files changed, 4 insertions(+)

-- 
1.9.1

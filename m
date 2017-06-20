From: Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 0/2] add mt2712 spi support
Date: Tue, 20 Jun 2017 16:21:05 +0800
Message-ID: <1497946867-25708-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This series are based on 4.12-rc1 and provide 2 patches to support mt2712 IC.

Change in this series:
1. update document to add mt2712;
2. add mt7622_compat.

Leilk Liu (2):
  spi: mediatek: Add bindings for mediatek MT2712 soc platform
  spi: mediatek: add spi support for mt2712 IC

 .../devicetree/bindings/spi/spi-mt65xx.txt         |    1 +
 drivers/spi/spi-mt65xx.c                           |    7 +++++++
 2 files changed, 8 insertions(+)

--
1.7.9.5

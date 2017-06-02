From: Leilk Liu <leilk.liu@mediatek.com>
Subject: [PATCH 0/3] add mt7622 spi support
Date: Fri, 2 Jun 2017 15:18:40 +0800
Message-ID: <1496387923-31674-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <sean.wang@mediatek.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This series are based on 4.12-rc1 and provide 4 patches to support mt7622 IC.

Change in this series:
1. update document to add mt7622;
2. add adjust register define support;
3. add mt7622_compat.

Leilk Liu (3):
  dt-bindings: spi: mediatek: Add bindings for mediatek MT7622 soc
    platform
  spi: mediatek: support adjust register define
  spi: mediatek: add spi support for mt7622 IC

 .../devicetree/bindings/spi/spi-mt65xx.txt         |    1 +
 drivers/spi/spi-mt65xx.c                           |   54 ++++++++++++++++++--
 include/linux/platform_data/spi-mt65xx.h           |    2 +
 3 files changed, 52 insertions(+), 5 deletions(-)

--
1.7.9.5

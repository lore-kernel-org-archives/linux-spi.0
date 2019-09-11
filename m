From: Luhua Xu <luhua.xu@mediatek.com>
Subject: [PATCH 0/3] MT6765 spi support
Date: Wed, 11 Sep 2019 05:55:28 -0400
Message-ID: <1568195731-3239-1-git-send-email-luhua.xu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

These patch series add Mediatek mt6765 spi support, and add spi DMA
large PA support on some platforms. 


luhua.xu (3):
  dt-bindings: spi: update bindings for MT6765 SoC
  spi: mediatek: add spi support for mt6765 IC
  spi: mediatek: support large PA

 .../devicetree/bindings/spi/spi-mt65xx.txt    |  1 +
 drivers/spi/spi-mt65xx.c                      | 53 +++++++++++++++++--
 2 files changed, 49 insertions(+), 5 deletions(-)

--
2.18.0

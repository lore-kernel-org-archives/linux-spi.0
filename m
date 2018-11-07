From: Vignesh R <vigneshr@ti.com>
Subject: [PATCH 0/2] McSPI: Enable mcspi driver for AM654 SoCs
Date: Wed, 7 Nov 2018 16:09:24 +0530
Message-ID: <20181107103926.32550-1-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Cc: Mark Rutland <mark.rutland@arm.com>, <linux-spi@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh R <vigneshr@ti.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Couple of patches to enable mcspi driver to be used with TI's new
AM654 SoCs.

Vignesh R (2):
  dt-bindings: spi: omap-spi: Add compatible for AM654 SoC
  spi: Kconfig: Enable McSPI driver for K3 platforms

 Documentation/devicetree/bindings/spi/omap-spi.txt | 1 +
 drivers/spi/Kconfig                                | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.19.1

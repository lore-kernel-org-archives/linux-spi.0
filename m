From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH 0/2] spi: dw: Add support for an optional interface clock
Date: Thu, 28 Feb 2019 13:25:40 +0000
Message-ID: <1551360342-23981-1-git-send-email-gareth.williams.jx@renesas.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The Synopsys SSI Controller has an interface clock that must be 
explicitly enabled in order to access the registers. This patch series
adds support for the interface clock and adds the associated bindings
documentation.

Phil Edworthy (2):
  dt: snps,dw-apb-ssi: Add clock bindings documentation
  spi: dw: Add support for an optional interface clock

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 10 +++++++++-
 drivers/spi/spi-dw-mmio.c                                 | 12 ++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.7.4

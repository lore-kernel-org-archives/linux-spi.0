From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: [PATCH v2 0/3] spi: dw: Add support for an optional interface clock
Date: Tue, 19 Mar 2019 15:52:04 +0000
Message-ID: <1553010727-23157-1-git-send-email-gareth.williams.jx@renesas.com>
Cc: Gareth Williams <gareth.williams.jx@renesas.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

v2:
 - Separated mandatory clock documentation and spelling correction from 
   optional clock property documentation.
 - Subject line for dt-bindings patches changed to match subsystem 
   convention.
 - Dependancy information added to driver patch notes.
 - Optional clock comment in code expanded for clarity.

Gareth Williams (1):
  dt-bindings: snps,dw-apb-ssi: Add optional clock bindings
    documentation

Phil Edworthy (2):
  dt-bindings: snps,dw-apb-ssi: Add mandatory clock bindings
    documentation
  spi: dw: Add support for an optional interface clock

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 10 +++++++++-
 drivers/spi/spi-dw-mmio.c                                 | 12 ++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

-- 
2.7.4

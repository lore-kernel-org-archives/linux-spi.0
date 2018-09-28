From: masonccyang@mxic.com.tw
Subject: [PATCH v3 0/2] spi: Add Macronix controller driver
Date: Fri, 28 Sep 2018 15:35:10 +0800
Message-ID: <1538120112-15530-1-git-send-email-masonccyang@mxic.com.tw>
Cc: boris.brezillon@bootlin.com, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw, masonccyang@mxic.com.tw
To: broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Mason Yang <masonccyang@mxic.com.tw>


Hi Mark, Trent and Boris,

I patched spi-mxic.c for clk_ctrl and run time PM.

please help to review.

thanks & best regards,
Mason


Mason Yang (2):
  spi: Add MXIC controller driver
  dt-bindings: spi: Document Macronix controller bindings

 Documentation/devicetree/bindings/spi/spi-mxic.txt |  34 ++
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-mxic.c                             | 599 +++++++++++++++++++++
 4 files changed, 640 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt
 create mode 100644 drivers/spi/spi-mxic.c

-- 
1.9.1

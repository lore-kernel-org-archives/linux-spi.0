From: masonccyang@mxic.com.tw
Subject: [PATCH v4 0/2] spi: Add Macronix controller driver
Date: Mon,  8 Oct 2018 10:25:30 +0800
Message-ID: <1538965532-8908-1-git-send-email-masonccyang@mxic.com.tw>
Cc: boris.brezillon@bootlin.com, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw, masonccyang@mxic.com.tw
To: broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Mason Yang <masonccyang@mxic.com.tw>

Hi Mark,

I patched v4 spi-mxic.c for clk_ctrl() and spi_setup() according to
your comments on v3.

Hi Boris,
I also patched clk frequency changed when the driver detects it needs
to be changed.

please help to review.

thanks & best regards,
Mason


Mason Yang (2):
  spi: Add MXIC controller driver
  dt-bindings: spi: Document Macronix controller bindings

 Documentation/devicetree/bindings/spi/spi-mxic.txt |  34 ++
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-mxic.c                             | 639 +++++++++++++++++++++
 4 files changed, 680 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt
 create mode 100644 drivers/spi/spi-mxic.c

-- 
1.9.1

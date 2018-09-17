From: masonccyang@mxic.com.tw
Subject: [PATCH 0/2] spi: Add Macronix controller driver
Date: Mon, 17 Sep 2018 15:16:17 +0800
Message-ID: <1537168579-31593-1-git-send-email-masonccyang@mxic.com.tw>
Cc: boris.brezillon@bootlin.com, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw, masonccyang@mxic.com.tw
To: broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Mason Yang <masonccyang@mxic.com.tw>

Hi Mark and Trent,

I patched spi-mxic.c and add the run time PM function.

thanks & best regards,
Mason

Mason Yang (2):
  spi: Add MXIC controller driver
  dt-binding: spi: Document Macronix controller bindings

 Documentation/devicetree/bindings/spi/spi-mxic.txt |  34 ++
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-mxic.c                             | 674 +++++++++++++++++++++
 4 files changed, 715 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt
 create mode 100644 drivers/spi/spi-mxic.c

-- 
1.9.1

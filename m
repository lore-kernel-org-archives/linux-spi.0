From: masonccyang@mxic.com.tw
Subject: [PATCH v6 0/2] spi: Add Macronix controller driver
Date: Wed, 17 Oct 2018 10:08:10 +0800
Message-ID: <1539742092-7049-1-git-send-email-masonccyang@mxic.com.tw>
Cc: boris.brezillon@bootlin.com, juliensu@mxic.com.tw,
        zhengxunli@mxic.com.tw, masonccyang@mxic.com.tw
To: broonie@kernel.org, tpiepho@impinj.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Mason Yang <masonccyang@mxic.com.tw>

Hi Mark & Boris,

I patched v6 spi-mxic.c based on Boris's comments of v5.

Thanks for your review.

best regards,
Mason

Mason Yang (2):
  spi: Add MXIC controller driver
  dt-binding: spi: Document Macronix controller bindings

 Documentation/devicetree/bindings/spi/spi-mxic.txt |  34 ++
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-mxic.c                             | 619 +++++++++++++++++++++
 4 files changed, 660 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mxic.txt
 create mode 100644 drivers/spi/spi-mxic.c

-- 
1.9.1

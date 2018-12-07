From: Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v3 0/2] spi: Add Renesas R-Car Gen3 RPC SPI driver
Date: Fri,  7 Dec 2018 19:13:17 +0800
Message-ID: <1544181199-3373-1-git-send-email-masonccyang@mxic.com.tw>
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw, Mason Yang <masonccyang@mxic.com.tw>
To: broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

This Renesas R-Car Gen3 RPC SPI driver is based on Boris's new
spi-mem direct mapping read/write mode [1][2].

v3 patch is according to Marek and Geert's comments including:
1) soc_device_mach() to set up RPC_PHYCNT_STRTIM.
2) get_unaligned()
3) rpc-mode for rpi-spi-flash or rpc-hyperflash.
4) coding style and so on.


v2 patch including:
1) remove RPC clock enable/dis-able control,
2) patch run time PM, 
3) add RPC module software reset, 
4) add regmap,
5) other coding style and so on.

thanks for your review.

best regards,
Mason

[1] https://patchwork.kernel.org/patch/10670753
[2] https://patchwork.kernel.org/patch/10670747


Mason Yang (2):
  spi: Add Renesas R-Car Gen3 RPC SPI controller driver
  dt-binding: spi: Document Renesas R-Car Gen3 RPC controller bindings

 .../devicetree/bindings/spi/spi-renesas-rpc.txt    |  38 +
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-renesas-rpc.c                      | 776 +++++++++++++++++++++
 4 files changed, 821 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
 create mode 100644 drivers/spi/spi-renesas-rpc.c

-- 
1.9.1

From: Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v9 0/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD driver
Date: Fri, 29 Mar 2019 16:20:03 +0800
Message-ID: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw, Mason Yang <masonccyang@mxic.com.tw>
To: broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com, devicetree@vger.kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

v9 patch is for RPC MFD driver and RPC SPI driver.

v8 patch including:
1) Supported SoC-specific values in DTS.
2) Rename device node name as flash.

v7 patch is according to Geert and Sergei's comments:
1) Add all R-Car Gen3 model in dts.
2) patch rpc-if child node search.
3) minror coding style.

v6 patch is accroding to Geert, Marek and Sergei's comments:
1) spi_controller for new code.
2) "renesas,rcar-gen3-rpc" instead of "renesas,r8a77995-rpc."
3) patch external address read mode w/o u64 readq().
4) patch dts for write buffer & drop "renesas,rpc-mode".
5) coding style and so on.

v5 patch is accroding to Sergei's comments:
1) Read 6 bytes ID from Sergei's patch.
2) regmap_update_bits().
3) C++ style comment.

v4 patch is according to Sergei's comments including:
1) Drop soc_device_match().
2) Drop unused RPC registers.
3) Use ilog2() instead of fls().
4) Patch read 6 bytes ID w/ one command.
5) Coding style and so on.

v3 patch is according to Marek and Geert's comments including:
1) soc_device_mach() to set up RPC_PHYCNT_STRTIM.
2) get_unaligned().
3) rpc-mode for rpi-spi-flash or rpc-hyperflash.
4) coding style and so on.

v2 patch including:
1) remove RPC clock enable/dis-able control,
2) patch run time PM.
3) add RPC module software reset,
4) add regmap.
5) other coding style and so on.

thanks for your review.

best regards,
Mason

Mason Yang (3):
  mfd: Add Renesas R-Car Gen3 RPC-IF MFD controller driver
  spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
  dt-bindings: mfd: Document Renesas R-Car Gen3 RPC-IF controller
    bindings

 .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    |  57 ++
 drivers/mfd/Kconfig                                |   9 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/renesas-rpc.c                          | 140 +++++
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-renesas-rpc.c                      | 640 +++++++++++++++++++++
 include/linux/mfd/renesas-rpc.h                    | 154 +++++
 8 files changed, 1008 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
 create mode 100644 drivers/mfd/renesas-rpc.c
 create mode 100644 drivers/spi/spi-renesas-rpc.c
 create mode 100644 include/linux/mfd/renesas-rpc.h

-- 
1.9.1

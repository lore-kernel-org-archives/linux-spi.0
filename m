From: Mason Yang <masonccyang@mxic.com.tw>
Subject: [PATCH v8 0/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI driver
Date: Mon, 28 Jan 2019 14:49:16 +0800
Message-ID: <1548658158-5460-1-git-send-email-masonccyang@mxic.com.tw>
Cc: juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw, Mason Yang <masonccyang@mxic.com.tw>
To: broonie@kernel.org, marek.vasut@gmail.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        bbrezillon@kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        sergei.shtylyov@cogentembedded.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

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

Mason Yang (2):
  spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
  dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF controller
    bindings

 .../devicetree/bindings/spi/spi-renesas-rpc.txt    |  40 +
 drivers/spi/Kconfig                                |   6 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-renesas-rpc.c                      | 804 +++++++++++++++++++++
 4 files changed, 851 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
 create mode 100644 drivers/spi/spi-renesas-rpc.c

-- 
1.9.1

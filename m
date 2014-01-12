From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH V2 0/3] SoC and board integration for QSPI on r8a7791/koelsch
Date: Sun, 12 Jan 2014 12:00:29 +0100
Message-ID: <1389524433-2823-1-git-send-email-geert@linux-m68k.org>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
To: Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This series adds support for the Spansion s25fl512s SPI FLASH on the
r8a7791-based Koelsch board. It is based on
renesas-devel-v3.13-rc7-20140109v2, with Valentine's i2c pinctrl and
Laurent's SCIF DT work applied on top.
[Simon: I don't know in which order you will merge these. If you want me
 to rebase my patches, just ask! Thanks!]

This applies to non-multiplatform Koelsch only.  Multi-platform Koelsch
support will be added in a separate series.

    [1/4] pinctrl: sh-pfc: r8a7791: Add QSPI pin groups
    [2/4] ARM: shmobile: r8a7791: add QSPI clocks
    [3/4] ARM: shmobile: koelsch: Add QSPI support
    [4/4] ARM: shmobile: koelsch: Enable RSPI and MTD_M25P80 in

Changes in V2:
  - Split QSPI pins in 2 sets of 3 pin groups
  - Add "[PATCH V2 4/4] ARM: shmobile: koelsch: Enable RSPI and MTD_M25P80
    in defconfig"

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

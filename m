From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/9] Renesas RSPI/QSPI DT support
Date: Sun, 12 Jan 2014 12:13:33 +0100
Message-ID: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patches series adds DT support to the Renesas RSPI/QSPI driver, and
to the r7s72100/genmai and r8a7791/koelsch development boards:

    [1/9] spi: rspi: Add missing clk_disable() calls in error and cleanup paths
    [2/9] spi: rspi: Convert to clk_prepare_enable/disable_unprepare
    [3/9] spi: rspi: Use NULL as the clock ID
    [4/9][V3] spi: rspi: Add DT support
    [5/9] ARM: shmobile: r7s72100: Add RSPI clocks for DT
    [6/9][V3] ARM: shmobile: r7s72100 dtsi: Add RSPI nodes
    [7/9][V3] ARM: shmobile: genmai reference: Add RSPI nodes
    [8/9] ARM: shmobile: r8a7791 dtsi: Add QSPI node
    [9/9] ARM: shmobile: koelsch: Add QSPI nodes

[4/9], [6/9], and [7/9] have been sent before in the series "[PATCH v2 0/8]
SoC and board integration for RSPI on RZ/A1H".
[4/9] received some updates, cfr. its changelog.

Thanks!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

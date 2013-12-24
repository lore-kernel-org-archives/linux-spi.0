From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Subject: [PATCH 0/8] spi: rspi: Add prelimary support for RZ/A1H
Date: Tue, 24 Dec 2013 12:40:40 +0100
Message-ID: <1387885248-28425-1-git-send-email-geert+renesas@linux-m68k.org>
Cc: linux-sh@vger.kernel.org
To: linux-spi@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch series adds preliminary support for RSPI in the RZ/A1H aka
R7S72100 SoC, which is found on the Genmai development board.

It hasn't received much testing, so please don't apply yet.

    [1/8] spi: rspi: Add more RSPI register documentation
    [2/8] spi: rspi: Add more QSPI register documentation
    [3/8] spi: rspi: Add support for more than one interrupt
    [4/8] spi: rspi: Add support for 8-bit Data Register access
    [5/8] spi: rspi: Add support for no TX only mode
    [6/8] spi: rspi: Add support for missing SPCR2 register
    [7/8] spi: rspi: Add support for specifying CPHA/CPOL
    [8/8] spi: rspi: Add support for loopback mode

Thanks for your comments, and Merry Christmas!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


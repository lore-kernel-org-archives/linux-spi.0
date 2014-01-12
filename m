From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCH V2 0/8] spi: rspi: Add support for RZ/A1H
Date: Sun, 12 Jan 2014 11:27:36 +0100
Message-ID: <1389522464-1569-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

	Hi Mark,

This patch series adds support for RSPI in the RZ/A1H aka R7S72100 SoC,
which is found on the Genmai development board.

This was tested on the Genmai development board, using loopback mode, with
the same outcome as the SDK reference code.

    [1/8] spi: rspi: Add more RSPI register documentation
    [2/8] spi: rspi: Add more QSPI register documentation
    [3/8] spi: rspi: Add support for more than one interrupt
    [4/8] spi: rspi: Add support for 8-bit Data Register access
    [5/8] spi: rspi: Add support for no TX only mode
    [6/8] spi: rspi: Add support for missing SPCR2 register
    [7/8] spi: rspi: Add support for specifying CPHA/CPOL
    [8/8] spi: rspi: Add support for loopback mode

Changes in V2:
  - Implement review comments
  - Add Acked-bys
  - Add more register documentation

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

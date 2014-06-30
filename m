From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend 0/2] spi: sh-msiof: Add DMA support
Date: Mon, 30 Jun 2014 12:10:22 +0200
Message-ID: <1404123024-12004-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

	Hi Mark,

This patch series adds DMA support to the MSIOF SPI driver:
  - [1/2] spi: sh-msiof: Add DMA support
  - [2/2] spi: sh-msiof: Add DMA support

Both patches provide identical functionality, but one is against the
spi/for-next branch (identical to the previous submission), while the other
one is against the spi/topic/sh-msiof branch (rebased).

Thanks for applying!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/2] spi: rspi: Misc Cleanups
Date: Fri,  6 Jun 2014 13:38:41 +0200
Message-ID: <1402054723-30682-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

	Hi Mark,

Here are two small cleanups for the Renesas SPI driver.

I've been hiding in a brown paper bag, as the first one fixes an unused
variable warning introduced by me in last patch of the previous series.

  [1/2] spi: rspi: Remove unused variable in rspi_rz_transfer_one()
  [2/2] spi: rspi: Pass spi_master pointer to rspi_release_dma()

 drivers/spi/spi-rspi.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

Thanks for applying!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

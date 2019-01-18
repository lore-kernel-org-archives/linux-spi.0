From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/2] eeprom: at25: SPI transfer improvements
Date: Fri, 18 Jan 2019 15:05:23 +0100
Message-ID: <20190118140525.29189-1-geert+renesas@glider.be>
Cc: Nguyen An Hoan <na-hoan@jinso.co.jp>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

	Hi all,

This patch series contains two improvements for the AT25 SPI EEPROM
driver, related to SPI transfers.

Changes compared to v1:
  - Merge "off" and "offset" into a single variable instead of just
    killing the cast, as suggested by Arnd,
  - Add Acked-by,
  - Dropped "[PATCH 3/3] eeprom: at25: Split writes in two SPI transfers
    to optimize DMA", as this is better implemented in the SPI
    controller driver (cfr. e.g. "[v2 PATCH 2/2] spi: sh-msiof: Use DMA
    if possible",
    https://lore.kernel.org/linux-renesas-soc/1547803771-9564-2-git-send-email-na-hoan@jinso.co.jp/)

Tested on a Renesas Ebisu development board with R-Car E3 using MSIOF
and a 25LC040 EEPROM.

Thanks!

Geert Uytterhoeven (2):
  eeprom: at25: Merge "off" and "offset" in at25_ee_write()
  eeprom: at25: Use spi_message_init_with_transfers() instead of open
    coding

 drivers/misc/eeprom/at25.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

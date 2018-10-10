From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] eeprom: at25: SPI transfer improvements
Date: Wed, 10 Oct 2018 15:40:33 +0200
Message-ID: <20181010134036.8296-1-geert+renesas@glider.be>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

	Hi all,

This patch series contains various improvements for the AT25 SPI EEPROM
driver, related to SPI transfers.

Tested on a Renesas Ebisu development board with R-Car E3 using MSIOF
and a 25LC040 EEPROM.  The MSIOF SPI Controller can only do DMA for
transfers with a length that is a multiple of 4 bytes.

Thanks!

Geert Uytterhoeven (3):
  eeprom: at25: Drop obsolete cast in at25_ee_write()
  eeprom: at25: Use spi_message_init_with_transfers() instead of open
    coding
  eeprom: at25: Split writes in two SPI transfers to optimize DMA

 drivers/misc/eeprom/at25.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

From: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
Subject: [PATCH 0/2] Fix displays requiring 9 bit transfers on RPi
Date: Tue, 11 Aug 2015 09:27:49 +0200
Message-ID: <cb8f9494-20af-4a98-b8fb-a7c8a4c9b722@HUB2.rwth-ad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Stefan=20Br=C3=BCns?= <stefan.bruens-vA1bhqPz9FBZXbeN9DUtxg@public.gmane.org>
To: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Some displays need 9 bit long SPI transfers (Command/Data flag plus
8 bit data). FBTFT has emulation code in case the controller only
supports 8 bit transfers, but this is only used if the controller
setup function report an error if bits_per_word is set to 9.

Report unsupported bits_per_word settings in spi_setup Currently the
SPI core only checks bits_per_word on transfer, but not on setup.

Replace invocations of master->setup(...) with spi_setup(...).

Tested on RPi B with an Ilitek9341 based TFT display in 9 bit mode.

Stefan Br=C3=BCns (2):
  spi: check bits_per_word in spi_setup
  staging/fbtft: use spi_setup instead of direct call to master->setup

 drivers/spi/spi.c                    | 27 +++++++++++++++++++--------
 drivers/staging/fbtft/fb_watterott.c |  4 ++--
 drivers/staging/fbtft/fbtft-core.c   |  4 ++--
 drivers/staging/fbtft/flexfb.c       |  4 ++--
 4 files changed, 25 insertions(+), 14 deletions(-)

--=20
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

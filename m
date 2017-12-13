From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 0/4] spi: sh-msiof: Multi-slave enhancements
Date: Wed, 13 Dec 2017 20:05:09 +0100
Message-ID: <1513191913-10612-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

	Hi Mark², Rob,

This patch series enhances the Renesas MSIOF SPI controller driver for
multiple SPI slave devices.

The first patch fixes the classical pitfall of writing to configuration
registers from the spi_master.setup() callback, where possible.
The second patch extends support from 1 to 3 native chip selects,
The third patch fixes the use of GPIOs as chip selects on modern
platform using DT instead of board code.
The last patch documents hardware limitations related to chip selects,
to guide board designers and DTS writers.

This has been tested with:
  - Three 25LC040 SPI EEPROMs, using GPIO chip selects due to MSIOF
    hardware limitations (verified with a logic analyzer),
  - Multiple 74HC595 shift registers feeding lots of blinkenlights,
    using only native chipselects, only GPIO chip selects, and a healthy
    mix of both.

Thanks for your comments!

Geert Uytterhoeven (4):
  spi: sh-msiof: Avoid writing to registers from spi_master.setup()
  spi: sh-msiof: Extend support to 3 native chip selects
  spi: sh-msiof: Implement cs-gpios configuration
  spi: sh-msiof: Document hardware limitations related to chip selects

 Documentation/devicetree/bindings/spi/sh-msiof.txt |  16 ++-
 drivers/spi/spi-sh-msiof.c                         | 111 +++++++++++++++++----
 2 files changed, 107 insertions(+), 20 deletions(-)

-- 
2.7.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

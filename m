From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 0/2] spi: dt-bindings: spi-controller: Slave mode fixes
Date: Fri,  6 Mar 2020 09:50:36 +0100
Message-ID: <20200306085038.8111-1-geert+renesas@glider.be>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Maxime Ripard <mripard-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

	Hi Mark, Rob, Maxime,

This patch series contains two fixes for the SPI controller DT bindings
regarding SPI controllers configured for slave mode.

Changes compared to v2[1]:
  - Make #address-cells mutually-exclusive with spi-slave,

Changes compared to v1[2]:
  - Use "enum: [0, 1]" instead of min/max limit,
  - use "- spi-slave" instead of "[ spi-slave ]".
  - New fix for spi-[rt]x-bus-width.

Thanks!

[1] https://lore.kernel.org/linux-devicetree/20200303094522.23180-1-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org/
[2] https://lore.kernel.org/linux-devicetree/20200227130323.15327-1-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org/

Geert Uytterhoeven (2):
  spi: dt-bindings: spi-controller: Fix #address-cells for slave mode
  spi: dt-bindings: spi-controller: Fix spi-[rt]x-bus-width for slave
    mode

 .../devicetree/bindings/spi/spi-controller.yaml        | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

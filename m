From: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Subject: [PATCH 0/2] spi: sh-msiof: Add r8a774[35] bindings
Date: Mon, 25 Sep 2017 09:54:18 +0100
Message-ID: <1506329660-4064-1-git-send-email-fabrizio.castro@bp.renesas.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Chris Paterson <Chris.Paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>,
        Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This series adds compatible strings and device tree bindings in order to enable
msiof support for r8a7743 and r8a7745.

Fabrizio Castro (2):
  spi: sh-msiof: Add compatible strings for r8a774[35]
  dt-bindings: spi: sh-msiof: Add r8a774[35] to the compatible list

 Documentation/devicetree/bindings/spi/sh-msiof.txt | 6 ++++--
 drivers/spi/spi-sh-msiof.c                         | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

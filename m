From: Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v3 0/3] spi: fsl-dspi (vf610) clock fixes
Date: Fri,  3 Apr 2015 13:39:28 -0700
Message-ID: <1428093571-20407-1-git-send-email-aaron.brice@datasoft.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	stefan-XLVq0VzYD2Y@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We were having intermittent problems writing to SRAM chip on SPI bus on vf610
SoM.  Added support for CS setup and hold times to meet the SRAM spec.  In the
process noticed that the baud rate was a little high.

Changes since v2:
 * Incorporate fixes per Stefen Agner review, namely moved hard-coded 50ns
   delays to device tree properties
 * Fix for baud rate scale value remainders, reported by Andy Shevchenko

Changes since v1:
 * More detail in commit message for clock rate fix

Aaron Brice (3):
  spi: fsl-dspi: Fix clock rate scale values
  devicetree: spi: fsl-dspi: Add cs-sck delays
  spi: fsl-dspi: Add ~50ns delay between cs and sck

 .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  8 ++
 drivers/spi/spi-fsl-dspi.c                         | 97 ++++++++++++++++++----
 2 files changed, 89 insertions(+), 16 deletions(-)

-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

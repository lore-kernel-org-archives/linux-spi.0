From: Michael van der Westhuizen <michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>
Subject: [PATCH v2 0/2] spi: dw: Reintroduce optional 16 bit data register I/O
Date: Wed, 24 Jun 2015 18:34:54 +0200
Message-ID: <1435163696-14767-1-git-send-email-michael@smart-africa.com>
References: <1434703435-25198-1-git-send-email-michael@smart-africa.com>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Michael van der Westhuizen <michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434703435-25198-1-git-send-email-michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The commit dd11444327ce ("spi: dw-spi: Convert 16bit accesses to 32bit
accesses") globally changed all register access in the dw_apb_ssi driver
to 32 bit access, which breaks data register (FIFO) access on picoXcell
platforms.

This series introduces a boolean to the core spi-dw driver to indicate
to the core that 16 bit data register access is appropriate, implements
the code that respects that flag and updates the dw-spi-mmio driver to
allow setting this boolean from the device tree.

A binding documentation fix is included in this series.

Prior to applying this change the following error presents on
a picoCell pc3x3 platform:
  spi_master spi32766: interrupt_transfer: fifo overrun/underrun
  m25p80 spi32766.0: error -5 reading 9f
  m25p80: probe of spi32766.0 failed with error -5

With this series applied:
  m25p80 spi32766.0: m25p40 (512 Kbytes)

Changes in v2:
  - Incorporate review feedback from Andy Shevchenko, reworking the
    bindings to reflect common practice and adjusting the driver
    to suit.
  - Add a wrapper inline function for accessing the data register
    using the configured with.

Michael van der Westhuizen (2):
  dt: snps,dw-apb-ssi: Document new I/O data register width property
  spi: dw: Allow interface drivers to limit data I/O to word sizes

 drivers/spi/spi-dw-mmio.c |  4 ++++
 drivers/spi/spi-dw.c      |  4 ++--
 drivers/spi/spi-dw.h      | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

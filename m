From: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: [PATCHv3 0/2] spi: imx: native chip selects and devicetree
Date: Tue, 11 Jul 2017 14:22:10 +1000
Message-ID: <1499746932-14850-1-git-send-email-gerg@linux-m68k.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Selecting native chip selects for iMX SPI devices in a devicetree
configuration does not work. That is the case for imx25 based SoC
parts, and I think for imx31 SoC as well. There is no problem with
configuring SPI ports to use a GPIO as chip select.

Selecting native chip selects via the old platform setup code will
work, it is only devicetree configurations that are broken.

With platform configuration you specify a native chip select by
setting the cs_gpio for the SPI device to be "32 - chipselect",
This will be a negative number - and thus not a valid GPIO number.
And that "chipselect" is the actual hardware native chip select
number.

You cannot specify the cs_gpio in dvicetree as a negative number,
so this whole scheme does not work. The common method in devicetree
is to set the cs_gpio entry for your device to be "<0>". If you do
this to configure your SPI device to use a native chip select it is
valid, but the SPI device cannot be accessed (no valid read data
returned from it).

The problem lies in the way the spi-imx.c driver sets up the
controlling registers of the iMX SPI block. It doesn't have the
correct logic for using native chip selects in the devicetree case.

v1 of this patch set contained the fixes for some platform setups to
make sure that the correct "chip_select" is used that is associated with
the required native chip select. This was dropped in v2, since Shawn 
picked that change up for arch/arm/imx and that is now in mainline.

This v3 series is just an up to date rebase of the v2 patches.

The following patches fix use of native chip selects in the spi-imx
driver for the devicetree case, and also document the use of the "<0>"
notation in devicetree.

Signed-off-by: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt |    4 +++-
 drivers/spi/spi-imx.c                                  |    8 ++++----
 2 files changed, 7 insertions(+), 5 deletions(-)

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

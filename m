From: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 0/2] spi: imx: native chip selects and devicetree
Date: Mon, 20 Mar 2017 15:35:40 +0800
Message-ID: <20170320073538.GC3443@dragon>
References: <1489726983-17706-1-git-send-email-gerg@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        fabio.estevam-3arQi8VN3Tc@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1489726983-17706-1-git-send-email-gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Mar 17, 2017 at 03:03:01PM +1000, Greg Ungerer wrote:
> 
> Selecting native chip selects for iMX SPI devices in a devicetree
> configuration does not work. That is the case for imx25 based SoC
> parts, and I think for imx31 SoC as well. There is no problem with
> configuring SPI ports to use a GPIO as chip select.
> 
> Selecting native chip selects via the old platform setup code will
> work, it is only devicetree configurations that are broken.
> 
> With platform configuration you specify a native chip select by
> setting the cs_gpio for the SPI device to be "32 - chipselect",
> This will be a negative number - and thus not a valid GPIO number.
> And that "chipselect" is the actual hardware native chip select
> number.
> 
> You cannot specify the cs_gpio in dvicetree as a negative number,
> so this whole scheme does not work. The common method in devicetree
> is to set the cs_gpio entry for your device to be "<0>". If you do
> this to configure your SPI device to use a native chip select it is
> valid, but the SPI device cannot be accessed (no valid read data
> returned from it).
> 
> The problem lies in the way the spi-imx.c driver sets up the
> controlling registers of the iMX SPI block. It doesn't have the
> correct logic for using nativce chip selects in the devicetree case.
> 
> The best fix is to use the "chip_select" associated with the SPI
> device as passed in from the devicetree (as the "reg" tag) or directly
> in the platform data structure. The hitch with that is that field is
> not set correctly by some platform device code.
> 
> The following patches fix the platform setup code to correctly set
> the "chip_select" for the SPI device and to set the SPI registers
> correctly based on that.
> 
> These changes affect the iMX machine code and drivers/spi subsystem so
> I have sent this to both lists for feedback.
> 
> Signed-off-by: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

The device tree support was added for imx spi driver with only the case
of GPIO being chip select in consideration, as that's the case for all
recent i.MX SoCs.  So, yes, native chip select never worked for device
tree case before.  Thanks for getting it work.

Shawn
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

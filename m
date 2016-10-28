From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 01/09] spi: fsl-espi: improve check for SPI_QE_CPU_MODE
Date: Fri, 28 Oct 2016 19:34:50 +0100
Message-ID: <20161028183450.sv3rxa6s76lr2j2c@sirena.org.uk>
References: <5b98be38-17a2-79a2-14da-fb2bb6f8820f@gmail.com>
 <0b5e7849-88d6-2af5-a428-eeb0de0f2af2@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0b5e7849-88d6-2af5-a428-eeb0de0f2af2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Oct 27, 2016 at 09:24:01PM +0200, Heiner Kallweit wrote:
> SPI_QE_CPU_MODE doesn't exist for ESPI and is set by of_mpc8xxx_spi_probe
> based on DT property "mode". This property is not defined for ESPI,
> see Documentation/devicetree/bindings/spi/fsl-spi.txt.
> So print an error message and bail out if SPI_QE_CPU_MODE is set.

Please don't send new patches in reply to old ones, it makes it harder
to follow what's going on.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

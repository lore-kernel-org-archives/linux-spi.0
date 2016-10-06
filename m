From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/11] spi: fsl-espi: remove unneeded check for
 SPI_QE_CPU_MODE
Date: Thu, 6 Oct 2016 20:36:29 +0200
Message-ID: <bbe77580-1ac2-4071-5d7d-f786c54ad177@gmail.com>
References: <5b98be38-17a2-79a2-14da-fb2bb6f8820f@gmail.com>
 <20608368-44e6-21f8-d970-5ade9990ce59@gmail.com>
 <20161006154543.rxlrc3sumejozpcg@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161006154543.rxlrc3sumejozpcg-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 06.10.2016 um 17:45 schrieb Mark Brown:
> On Sun, Oct 02, 2016 at 02:22:48PM +0200, Heiner Kallweit wrote:
>> SPI_QE_CPU_MODE doesn't exist for ESPI and is set by of_mpc8xxx_spi_probe
>> based on DT property "mode". This property is not defined for ESPI,
>> see Documentation/devicetree/bindings/spi/fsl-spi.txt
>> Therefore remove the check.
> 
> Shouldn't we be warning if we encounter a DT that has this set since it
> probably indicates that something went wrong?
> 
The values of mpc8xxx_spi->rx_shift and mpc8xxx_spi->tx_shift were
overwritten in fsl_espi_setup_transfer anyway. Therefore the removed
code effectively was dead code.
As we just remove dead code and don't change the behavior of the driver
I see no need to introduce an additional check / warning.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

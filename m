From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: fsl-(e)spi: migrate to using devm_ functions
 to simplify cleanup
Date: Tue, 25 Aug 2015 22:14:46 +0200
Message-ID: <55DCCCB6.2060805@gmail.com>
References: <55D9BAAA.7060401@gmail.com> <20150825174349.GE12878@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150825174349.GE12878-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 25.08.2015 um 19:43 schrieb Mark Brown:
> On Sun, Aug 23, 2015 at 02:20:58PM +0200, Heiner Kallweit wrote:
> 
>>  	/* Register for SPI Interrupt */
>> -	ret = request_irq(mpc8xxx_spi->irq, fsl_espi_irq,
>> +	ret = devm_request_irq(dev, mpc8xxx_spi->irq, fsl_espi_irq,
>>  			  0, "fsl_espi", mpc8xxx_spi);
> 
> Also, are you *sure* this conversion is safe?  One trick with interrupts
> is that the interrupt could still fire after the device removal function
> runs since devm_ dealloacation runs after that.
After each transfer interrupts are disabled (at end of fsl_espi_bufs).
Therefore I *think* it's safe.
And as resources are freed in reverse order (irq first), shouldn't this be enough
to be on the safe side?

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

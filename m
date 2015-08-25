From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: fsl-(e)spi: migrate to using devm_ functions
 to simplify cleanup
Date: Tue, 25 Aug 2015 21:54:23 +0200
Message-ID: <55DCC7EF.80306@gmail.com>
References: <55D9BAAA.7060401@gmail.com> <20150825172644.GD12878@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150825172644.GD12878-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 25.08.2015 um 19:26 schrieb Mark Brown:
> On Sun, Aug 23, 2015 at 02:20:58PM +0200, Heiner Kallweit wrote:
> 
>> -	mpc8xxx_spi->reg_base = ioremap(mem->start, resource_size(mem));
>> +	mpc8xxx_spi->reg_base = devm_ioremap(dev, mem->start,
>> +					     resource_size(mem));
> 
> What would be even nicer here would be to convert to devm_ioremap_resource()
Thanks for the hint, I'll check.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

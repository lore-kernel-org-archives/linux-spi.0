From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: fsl-(e)spi: simplify cleanup code
Date: Wed, 26 Aug 2015 20:54:10 +0200
Message-ID: <55DE0B52.1040508@gmail.com>
References: <55D9BAE1.1030306@gmail.com> <20150825174508.GF12878@sirena.org.uk> <55DE01FF.3000607@gmail.com> <20150826184506.GF28760@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150826184506.GF28760-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 26.08.2015 um 20:45 schrieb Mark Brown:
> On Wed, Aug 26, 2015 at 08:14:23PM +0200, Heiner Kallweit wrote:
>> Am 25.08.2015 um 19:45 schrieb Mark Brown:
>>> On Sun, Aug 23, 2015 at 02:21:53PM +0200, Heiner Kallweit wrote:
> 
>>>>  static int of_fsl_espi_remove(struct platform_device *dev)
>>>>  {
>>>> -	return mpc8xxx_spi_remove(&dev->dev);
>>>> +	return 0;
>>>>  }
> 
>>> You should be able to remove empty functions like this one.
> 
>> When checking I just recognized that this (now temporarily empty)
>> function is the remove callback of the platform driver.
>> AFAIK providing a remove callback is mandatory.
>> Is it therefore ok to have a temporarily empty function here?
> 
> No, remove callbacks are completely optional.
> 
I see, thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

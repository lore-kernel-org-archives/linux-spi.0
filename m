From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] spi: core: Validate lenght of the transfers in
 message
Date: Mon, 17 Feb 2014 09:41:38 +0200
Message-ID: <1392622898.17130.8.camel@iivanov-dev>
References: <1392444566-23605-1-git-send-email-iivanov@mm-sol.com>
	 <20140216142512.GR4524@book.gsilab.sittig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140216142512.GR4524-kDjWylLy9wD0K7fsECOQyeGNnDKD8DIp@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Hi, 

On Sun, 2014-02-16 at 15:25 +0100, Gerhard Sittig wrote: 
> On Sat, Feb 15, 2014 at 08:09 +0200, Ivan T. Ivanov wrote:
> > 
> > From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
> > 
> > SPI transfer lenght should be a power-of-two multiple
> > of eight bits.
> 
> Please re-check for "lenght" typos in subjects and commit logs
> (code comments appear to be correct already).

Thanks, will correct them.

> 
> 
> The commit message still confuses me.  You don't check that the
> length of an SPI transfer has a power-of-two length in bytes.
> 
> Instead what the check implements is IIUC
> - pad "odd" bits-per-word settings before the check to full 1/2/4
>   byte length specs (this is the power-of-two thing)
> - the total length of the SPI transfer cannot be empty (which I'd
>   consider an optimization, not a violation, and may need a
>   separate discussion)

I am not sure that I understand this one. I will say "the total
length of the SPI transfer _should not_ be empty". There is no
check for this currently.

> - the total length of the SPI transfer must be such that each
>   "word" must be provided within a full 1/2/4 byte entity, with
>   padding bits if the bits-per-word is "odd"
> 
> Is this a misunderstanding on my side?  A terminology thing?  To
> me, the "SPI transfer" is the total payload and may have any
> arbitrary length.  What you check for is a constraint on the
> transfer's length derived from or based on the "word length"
> ('word' in SPI context).
> 
> So the code may be appropriate, yet the description may need an
> update, to not have the next person ask the same questions again.
> 

I just forgot to update commit message. Will try to be more
careful next time.

Regards,
Ivan

> 
> virtually yours
> Gerhard Sittig


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

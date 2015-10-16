From: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi: Setup the master controller driver before setting
 the chipselect
Date: Fri, 16 Oct 2015 09:27:50 -0500
Message-ID: <56210966.3040501@ti.com>
References: <1444942305-24038-1-git-send-email-fcooper@ti.com>
 <20151016102846.GJ14956@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<nsekhar-l0cyMroinI0@public.gmane.org>, <ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>,
	<m-karicheri2-l0cyMroinI0@public.gmane.org>, <iivanov.xz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	<hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151016102846.GJ14956-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 10/16/2015 05:28 AM, Mark Brown wrote:
> On Thu, Oct 15, 2015 at 03:51:45PM -0500, Franklin S Cooper Jr wrote:
>> Some devices depend on the master controller driver setup function being
>> called before calling any chipselect functions.
>>
>> Insure that this is done otherwise uninitialized structures may be
>> accessed causing a kernel panic.
> I think this is a sensible change but can we please have a better
> changelog - why is this the best thing to do rather than fixing the
> driver to not crash?  There are a bunch of good reasons to do the master
> setup before asserting chip select but a driver crashing isn't one of
> them, it's not clear that this isn't a bug in the driver.
Mark,
Makes sense. How about something like this?

SPI controllers may need to be properly setup before chip selects
can be used. Therefore, wait until the spi controller has a chance
to perform their setup procedure before trying to use the chip
select.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

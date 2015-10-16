From: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi: Setup the master controller driver before setting
 the chipselect
Date: Fri, 16 Oct 2015 09:45:48 -0500
Message-ID: <56210D9C.6090800@ti.com>
References: <1444942305-24038-1-git-send-email-fcooper@ti.com>
 <20151016102846.GJ14956@sirena.org.uk> <56210966.3040501@ti.com>
 <20151016144305.GO14956@sirena.org.uk>
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
In-Reply-To: <20151016144305.GO14956-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 10/16/2015 09:43 AM, Mark Brown wrote:
> On Fri, Oct 16, 2015 at 09:27:50AM -0500, Franklin S Cooper Jr. wrote:
>
>> Makes sense. How about something like this?
>> SPI controllers may need to be properly setup before chip selects
>> can be used. Therefore, wait until the spi controller has a chance
>> to perform their setup procedure before trying to use the chip
>> select.
> Yes, that's a lot better - there's also the fact that if we assert chip
> select before we've got the pins in a good state we may cause the device
> to see signals that confuse it as we change.
Ok. I'll submit a rev2 with my updated commit message and incorporate
your suggestion also.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

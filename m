From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2, resend for stable 1/1] spi: dw-mid: clear BUSY flag
 fist and test other one
Date: Sat, 7 Mar 2015 21:14:53 +0200
Message-ID: <CAHp75VcGyq57Fg3BMqS1Z67be3DkYQ3pdgvpL5zdicfDZp+Txg@mail.gmail.com>
References: <1425645721-18142-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<20150307112238.GK28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150307112238.GK28806-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, Mar 7, 2015 at 1:22 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Mar 06, 2015 at 02:42:01PM +0200, Andy Shevchenko wrote:
>> The logic of DMA completion is broken now since test_and_clear_bit() never
>> returns the other bit is set. It means condition are always false and we have
>> spi_finalize_current_transfer() called per each DMA completion which is wrong.
>
> Applied, thanks.  I assume you're also going to resend the other bits if
> they're still valid?

Yes, they are.
I will do next working day (On Monday I think ).

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

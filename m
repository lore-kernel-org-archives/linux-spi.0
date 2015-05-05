From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH resend 1/5] spi: bcm2835: Add GPIOLIB dependency
Date: Mon, 04 May 2015 17:02:28 -0700
Message-ID: <55480894.3080200@roeck-us.net>
References: <1430778649-28126-1-git-send-email-linux@roeck-us.net> <1430778649-28126-2-git-send-email-linux@roeck-us.net> <20150504233421.GW22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150504233421.GW22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 05/04/2015 04:34 PM, Mark Brown wrote:
> On Mon, May 04, 2015 at 03:30:45PM -0700, Guenter Roeck wrote:
>> Fix:
>>
>> drivers/spi/spi-bcm2835.c: In function 'chip_match_name':
>> drivers/spi/spi-bcm2835.c:356:21: error:
>
> This duplicates a patch someone else sent.
>

Hi Mark,

not that it matters, but this is the patch in linux-next.

I am aware that several other patches have been submitted to fix the
problem (I think I have seen at least two); after all, I submitted the
patch some three weeks ago, and many others are affected by it. I don't
really care which one of the submitted patches is applied to mainline,
as long as the problem is getting fixed.

Repeating my comment from the patch,

"Yes, I know, this patch is in -next. Please see this e-mail as gentle reminder
to consider pushing it (or one of the other patches fixing the same problem)
into mainline."

Thanks,
Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Alexey Klimov <klimov.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RESEND 0/1] Revert "spi/doc: spi_master_put must be
 followed up by kfree"
Date: Sun, 6 Sep 2015 03:22:43 +0300
Message-ID: <CALW4P+KEsLAhQDHrMt-4Nw5Tb57cLp99T_uAdTpcQBX8_i1uSA@mail.gmail.com>
References: <CAP_9M6973VAtM6WkP7gkzDMnJbRxmmmiCCuSxMU-_aQm4YQZbg@mail.gmail.com>
	<20150906000640.GR5313@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexey Klimov <alexey.klimov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Uwe Kleine-Koenig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150906000640.GR5313-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Sep 6, 2015 at 3:06 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Sun, Sep 06, 2015 at 01:47:21AM +0300, Alexey Klimov wrote:
>
>> During review of new SPI drivers I tried to understand connection
>> between comment "calling spi_master_put() and kfree() to prevent a
>> memory leak" for spi_alloc_master() in spi.c and why no driver calls
>> kfree() on error path. Looks like Uwe added this comment and later I
>> found patch from Guenter that reverted this comment but spi-imx.c was
>> not fixed for that time. Later in 2013 spi-imx was fixed. Is it
>> correct time right now to fix comment?
>
> I'm sorry but I'm not clear what you're talking about here as there's
> missing context...  where is this comment you're talking about?
>
> In general please don't send cover letters for single patches, either
> add the content to the commit message or put it after the --- if it's
> administrative stuff (like SubmittingPatches says).

Okay, understand (about formatting of subject, RESEND noise and no
cover letter for single patches). Just never send reverts before
(especially when it's re-send from 2012 year).
It's easy to see comment in patch with subject: [PATCH RESEND 1/1]
Revert "spi/doc: spi_master_put must be followed up by kfree"
It's in drivers/spi/spi.c, line 1440 in tag v4.2 released ~ 5 days
ago. Comment for function spi_alloc_master().

Sorry. Right now I see how I screwed up. Should I re-send it as single
patch with all info included (marking as RESEND)?

-- 
Best regards,
Klimov Alexey
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

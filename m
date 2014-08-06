From: Ilia Mirkin <imirkin-FrUbXkNCsVf2fBVCVOL8/A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: Remove unused definitions
Date: Wed, 6 Aug 2014 14:35:19 -0400
Message-ID: <CAKb7Uvj7CRE3O8N8+_1pk_aHVWWWBWUit2N+2=yy5NTG0Gaidw@mail.gmail.com>
References: <1407347597-2168-1-git-send-email-xerofoiffy@gmail.com>
	<17153.1407349640@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nick Krause <xerofoiffy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Richard Weinberger <richard.weinberger-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Valdis.Kletnieks-PjAqaU27lzQ@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <17153.1407349640-+bZmOdGhbsPr6rcHtW+onFJE71vCis6O@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Aug 6, 2014 at 2:27 PM,  <Valdis.Kletnieks-PjAqaU27lzQ@public.gmane.org> wrote:
> On Wed, 06 Aug 2014 13:53:17 -0400, Nick Krause said:
>> Remove unused definition which cause the following warnings
>>
>> drivers/spi/spi-omap-100k.c:73:0: warning: "WRITE" redefined [enabled by default]
>> include/linux/fs.h:193:0: note: this is the location of the previous definition
>> drivers/spi/spi-omap-100k.c:74:0: warning: "READ" redefined [enabled by default]
>> include/linux/fs.h:192:0: note: this is the location of the previous definition
>
>> -#define WRITE 0
>> -#define READ  1
>
> NAK.  Full stop.  These are potentially used in an inner macro someplace, and by
> removing these, the conflicting values from fs.h will be used instead.
>
> #define READ                    0
> #define WRITE                   RW_MASK
>
> So if there *is* a use in an inner macro, you just screwed the pooch
> and introduced a bug in this "clean up" - somebody will be expecting to see
> a 0 for a READ, and will receive a 1 instead.  This can't end well.

I was actually about to send a similar response, but then I noticed I
couldn't actually find any uses of READ/WRITE in the file... But I
could easily have missed them.

>
> Nick - how *exactly* did you identify that these are in fact not used?
> Given your history of submitting poorly researched patches, you're going to
> have to justify the "unused" better than the handwaving you've done here.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

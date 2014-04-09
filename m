From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/9] Documentation: spi-nor: rewrite some portions
Date: Wed, 9 Apr 2014 11:14:18 -0700
Message-ID: <20140409181418.GG32070@ld-irv-0074>
References: <1397064774-31784-1-git-send-email-computersforpeace@gmail.com>
 <1397064774-31784-4-git-send-email-computersforpeace@gmail.com>
 <201404091944.15631.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201404091944.15631.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Apr 09, 2014 at 07:44:15PM +0200, Marek Vasut wrote:
> On Wednesday, April 09, 2014 at 07:32:49 PM, Brian Norris wrote:
> > Signed-off-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> > WIP. This could be improved more (e.g., don't spend too much time
> > documenting history; just document the current framework)
> > 
> >  Documentation/mtd/spi-nor.txt | 27 +++++++++++++++------------
> >  1 file changed, 15 insertions(+), 12 deletions(-)
> > 
> > diff --git a/Documentation/mtd/spi-nor.txt b/Documentation/mtd/spi-nor.txt
> > index 294d5b06f892..bfcdeb94e053 100644
> > --- a/Documentation/mtd/spi-nor.txt
> > +++ b/Documentation/mtd/spi-nor.txt
> > @@ -1,16 +1,20 @@
> >                            SPI NOR framework
> >                 ============================================
> > 
> > -Part I - why we need this framework?
> > +Part I - Why do we need this framework?
> >  -------------------------------------
> 
> The underline is not matching the length of the text now ;-)

It wasn't exactly matching in the first place. But I'll adjust all the
headings so the line is exactly as long as the text.

> > 
> > -The SPI bus controller only deals with the byte stream.
> > -Some controller does not works like a SPI bus controller, it works
> > -like a SPI NOR controller instead, such as the Freescale's QuadSPI
> > controller. +SPI bus controllers (drivers/spi/) only deal with streams of
> > bytes; the bus +controller operates agnostic of the specific device
> > attached. However, some +controllers (such as Freescale's QuadSPI
> > controller) cannot easily handle +arbitrary streams of bytes, but rather
> > are designed specifically for SPI NOR.
> 
> You use the word 'specifically' here and below quick after one another, that 
> doesn't sound nice when you read the text.

Sure, thanks for pointing it out.

> > -The Freescale's QuadSPI controller should know the NOR commands to
> > -find the right LUT sequence. Unfortunately, the old code can not meet
> > -this requirement.
> > +Specifically, Freescale's QuadSPI controller must know the NOR commands to

My changes are pushed here temporarily, and I'll send v2 in the next day or so:

  http://git.infradead.org/users/norris/linux-mtd.git/shortlog/refs/heads/spinor

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

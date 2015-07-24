From: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>
Subject: Re: [PATCH] Revert "spi: bitbang: only toggle bitchanges"
Date: Fri, 24 Jul 2015 13:48:00 +0200
Message-ID: <1437738480.31818.5.camel@axis.com>
References: <1437716236-12715-1-git-send-email-larper@axis.com>
	 <20150724104419.GH11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150724104419.GH11162-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, 2015-07-24 at 12:44 +0200, Mark Brown wrote:
> On Fri, Jul 24, 2015 at 07:37:16AM +0200, Lars Persson wrote:
> > This reverts commit 232a5adc5199 ("spi: bitbang: only toggle
> > bitchanges") because it breaks bitbanged SPI on our MIPS system. I
> > found two problems with the patch:
> > - oldbit must initially be computed from bit position 7, 15 or 31 of
> >   word depending on the value of bits.
> 
> This might be a real issue but fixing it does not require a revert.
> 
> > - The optimization also does not eliminate consecutive ones because
> >   the compare of 1<<31 and 1 will be false (a bool only takes values 0
> >   or 1).
> 
> No, any non-zero value is true in C.  I assume you're talking about
> this section of the diff:
> 
> > -		if ((flags & SPI_MASTER_NO_TX) == 0) {
> > -			if ((word & (1 << 31)) != oldbit) {
> > -				setmosi(spi, word & (1 << 31));
> > -				oldbit = word & (1 << 31);
> 
> which looks fine - we see if the top bit is the same as the last top bit
> we wrote, if it isn't we update the value output and record what we just
> wrote.

No this is a misunderstanding about the semantics of the bool type.
When assigning to the bool any non-zero value becomes 1.
When comparing an integer against the bool, the bool is promoted to an
integer.

If we previously transmitted a one, oldbit equals 1.
If current bit is a one, then (word & (1 << 31)) equals 1<<31.

((1<<31) != 1) is TRUE so we call setmosi again, hence no optimization
for consecutive ones.

Please do not mix bool and bitwise operations.

- Lars

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

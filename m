From: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: rspi: Fix typo when clearing SPSR_OVRF
Date: Fri, 10 Jan 2014 09:49:09 +0900
Message-ID: <20140110004909.GB22965@verge.net.au>
References: <1387823664-32318-1-git-send-email-geert+renesas@linux-m68k.org>
 <1387823664-32318-2-git-send-email-geert+renesas@linux-m68k.org>
 <20131224025936.GF22401@verge.net.au>
 <CAMuHMdWiJPF2NU+ME=CLMygvABZ_fcTyr7ggdQtFKbOGhCA0+w@mail.gmail.com>
 <20131227021639.GD9184@verge.net.au>
 <CAMuHMdU+4qCc64CkJeLAhh4SHqbB0E8Cu=8dKpmaYbphTBJV6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdU+4qCc64CkJeLAhh4SHqbB0E8Cu=8dKpmaYbphTBJV6g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Jan 09, 2014 at 10:41:55AM +0100, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Fri, Dec 27, 2013 at 3:16 AM, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org> wrote:
> > On Tue, Dec 24, 2013 at 10:26:17AM +0100, Geert Uytterhoeven wrote:
> >> On Tue, Dec 24, 2013 at 3:59 AM, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org> wrote:
> >> > On Mon, Dec 23, 2013 at 07:34:24PM +0100, Geert Uytterhoeven wrote:
> >> >> The overrun flag should be cleared in the SPI Status Register, not in the
> >> >> SPI Control Register, based on the SDK sample code.
> >> >>
> >> >> Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> >>
> >> The issue is quite obvious: after clearing the bit, the new value should
> >> be written back to the same register.
> >>
> >> However, the fix is not in a v3.10-rc6 version I saw, so this may matter
> >> for LTSI.
> >
> > I believe that the LTSI-3.10 work from Renesas (so far mainly me) is
> > independent of the sample code at the link above. So unless this fix ends
> > up in v3.10 -stable, which should feed into LTSI-3.10, then it will need to
> > be submitted to LTSI (probably be me or you) if we want it to be in LTSI.
> 
> According to the documentation, this bit is valid only in SPI slave mode.
> As Linux supports SPI master mode only, this looks like a purely cosmetical
> issue to me, so it doesn't warrant applying to -stable or LTSI-3.10.

Thanks for the clarification.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

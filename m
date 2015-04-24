From: Jonatas Rech <jonatas.rech-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-espi: fix behaviour for full-duplex xfers
Date: Fri, 24 Apr 2015 17:03:26 -0300
Message-ID: <20150424200326.GA14443@datacom.ind.br>
References: <1429111398-21444-1-git-send-email-jonatas.rech@datacom.ind.br>
 <20150418125556.GR26185@sirena.org.uk>
 <363371145.339730.1429715343024.JavaMail.zimbra@datacom.ind.br>
 <20150422195746.GM22845@sirena.org.uk>
 <20150423180622.GC12637@datacom.ind.br>
 <20150424181745.GG22845@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150424181745.GG22845-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Apr 24, 2015 at 07:17:45PM +0100, Mark Brown wrote:
> On Thu, Apr 23, 2015 at 03:06:22PM -0300, Jonatas Rech wrote:
> 
> > I agree, but please note that this came up while I was trying to fix the
> > full-duplex functionality, and it's a different problem. Fixing this would
> > impact protocol drivers, as stated earlier. It would take some time for me to
> > study other drivers and come up with the best solution for this driver plus
> > (at least) the m25p80, which supports the hardware I currently have access to.
> 
> > I know this must be fixed, but wouldn't it be subject to a different patch?
> > Thanks in advance for the advice.
> 
> The commit message says "this correction has exposed an inconsistency"
> which suggests that the problem was masked before this fix.  Did you
> mean to say that while fixing this you noticed a separate bug that's
> present anyway?

Exactly. Besides fixing the full-duplex capability I reorganized things
inside the main loop so that anybody can spot where the extra bytes are
being sent, but the code works just the same as before in that respect.

My guess is that, appart from memory chips, most SPI devices are
accessed with short transfers, and since this only arises when one wants
to read/write more than 64KiB at once, it has remained unnoticed. So, as
long as flash memories work with this driver (and they do, because of
the bug), there won't be the need for it to be fixed. Apparently it was
implemented this way on purpose by the original author.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

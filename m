From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH] atmel_spi: support zero length	
 transfer
Date: Fri, 22 Feb 2008 11:02:28 -0800
Message-ID: <20080222190228.2B0CB28E363@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <20080221.005432.07645461.anemo@mba.ocn.ne.jp>
 <200802201855.02605.marc.pignat@hevs.ch>
 <20080221.105233.41199605.nemoto@toshiba-tops.co.jp>
 <200802211026.17816.marc.pignat@hevs.ch>
 <20080221192334.EE97A230A58@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
 <47BED734.5030002@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net, marc.pignat@hevs.ch,
	linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp
To: nforrester@whoi.edu
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764113AbYBVTCp@vger.kernel.org>
In-Reply-To: <47BED734.5030002@whoi.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> >> David, do you think writing 0 bytes is a valid use of this API?
> >
> > Just a zero byte transfer ... no, though it depends what you mean
> > by "valid".  (I'm not sure I'd expect all controller drivers to
> > reject such requests.)  That has no effect on bits-on-the-wire,
> > and would make trouble for various DMA engines.
>
> FWIW, the pxa2xx_spi driver does not, near as I can tell, reject zero
> length transfers, it will go through the motions, the same as for any
> other transfer.

Makes sense to me ... although:

> However, if the transfer is by DMA, note that the PXA255 and PXA270
> Developer's Manuals have the following language regarding DMA lengths:
>
> 	LEN = 0 means zero bytes for descriptor-fetch transactions.
> 	LEN = 0 is an invalid setting for no-descriptor-fetch
> 	transactions. ...
>
> Because the pxa2xx_spi driver does not currently use DMA descriptors,
> zero length DMAs are invalid.

In that case the pxa2xx_spi driver should add a special case to
avoid starting such transfers in DMA mode.


> > Passing zero bytes to get an inline delay at an exact spot in the
> > overall protocol message ... I don't see why not.  Better than
> > adding delay fields for every spot it might be needed by various
> > oddball devices, for sure!!
>
> I agree with Marc: any such delay will be undefined, in the general
> case.  It might work for a specific driver implementation.

Is that what Marc said?  I couldn't tell.  In any case, I disagree;
the semantics of that delay are clearly defined.

- Dave

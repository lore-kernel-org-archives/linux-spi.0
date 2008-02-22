From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH] atmel_spi: support zero length	
 transfer
Date: Fri, 22 Feb 2008 11:06:13 -0800
Message-ID: <20080222190613.0043B229B4D@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <200802211026.17816.marc.pignat@hevs.ch>
 <20080221192334.EE97A230A58@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
 <200802221030.32263.marc.pignat@hevs.ch>
 <20080222.231510.56565462.anemo@mba.ocn.ne.jp>
 <47BEDBFB.5040305@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net, marc.pignat@hevs.ch,
	linux-kernel@vger.kernel.org
To: nforrester@whoi.edu, anemo@mba.ocn.ne.jp
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764952AbYBVTGb@vger.kernel.org>
In-Reply-To: <47BEDBFB.5040305@whoi.edu>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> > If the driver could not handle zero length transfer, then the driver
> > should reject it (just like unsupported transfer mode).  Then the
> > behavior will be 'assert chip select and wait some time' or 'rejected
> > by the driver'.
>
> This would be OK.  It would not be hard to fix pxa2xx_spi, for example,
> to reject zero-length transfers in DMA mode, as long as it is acceptable
> to reject the message in mid-message.

Such "illegal message" rejection is best done early; "fail-fast".
Mid-message rejection isn't wrong, but it's a rude policy.

It'd be best to fix pxa2xx_spi to not start zero-length DMAs.


>	If it were necessary to scan a
> whole message for zero-length transfers and refuse to queue an offending
> message, then that adds burden to all messages.

Sanity checking messages as they're submitted is easy; and it's
also the natural point for setting up DMA mappings (and making
those cachelines available for better use).

- Dave

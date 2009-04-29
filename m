From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [spi-devel-general] [PATCH v2] spi: Add support for the
	OpenCores SPI controller.
Date: Wed, 29 Apr 2009 08:31:04 +0200
Message-ID: <20090429063104.GB7784@avionic-design.de>
References: <200904041227.54687.david-b@pacbell.net> <20090428122011.GB6325@avionic-design.de> <200904281541.21238.florian@openwrt.org> <200904281354.12192.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Fainelli <florian@openwrt.org>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754013AbZD2GbZ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200904281354.12192.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

* David Brownell wrote:
> On Tuesday 28 April 2009, Florian Fainelli wrote:
> > > > Is this the http://www.opencores.org/?do=project&who=spi core?
> > >
> > > Yes, it is.
> > >
> > > > Its summary says "Variable length of transfer word up to 32 bits";
> > > > does that mean "configurable when core is synthesized" instead of
> > > > truly "variable"?
> > 
> > This is indeed configured at synthesis time.
> 
> Now I'm confused again.  Thierry says (below) that the number of bits
> can be set per-"transfer".
> 
> Now, I can easily understand that a *maximum* would be configured
> at synthesis time ... if there's a 32-bit CPU or DMA engine, it'd
> make very limited sense to interact using 128-bit I/O words.

I can't really comment on the synthesis because I'm not involved with that
part. What I was saying that the core provides a field in the control
register which defines the number of bits to transfer from/to the
transmit/receive registers. The maximum number of bits that can be specified
in this way is 128.

> Is there both a configurable maximum, *and* a word-size setting that
> can be changed on the fly?  That's what I would expect; it's what
> most other designs do.  The only time I've seen fixed "you must use
> N-bit words" designs is on cost-eradicated 8-bit microcontrollers.

Perhaps that maximum number of bits that can be set through the control
register is what can be configured at synthesis time.

> - Dave

Thierry

From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [PATCH v2] spi: Add support for the OpenCores SPI controller.
Date: Tue, 28 Apr 2009 13:54:11 -0700
Message-ID: <200904281354.12192.david-b@pacbell.net>
References: <200904041227.54687.david-b@pacbell.net> <20090428122011.GB6325@avionic-design.de> <200904281541.21238.florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Thierry Reding <thierry.reding@avionic-design.de>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Florian Fainelli <florian@openwrt.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757046AbZD1Uyb@vger.kernel.org>
In-Reply-To: <200904281541.21238.florian@openwrt.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 28 April 2009, Florian Fainelli wrote:
> > > Is this the http://www.opencores.org/?do=project&who=spi core?
> >
> > Yes, it is.
> >
> > > Its summary says "Variable length of transfer word up to 32 bits";
> > > does that mean "configurable when core is synthesized" instead of
> > > truly "variable"?
> 
> This is indeed configured at synthesis time.

Now I'm confused again.  Thierry says (below) that the number of bits
can be set per-"transfer".

Now, I can easily understand that a *maximum* would be configured
at synthesis time ... if there's a 32-bit CPU or DMA engine, it'd
make very limited sense to interact using 128-bit I/O words.

Is there both a configurable maximum, *and* a word-size setting that
can be changed on the fly?  That's what I would expect; it's what
most other designs do.  The only time I've seen fixed "you must use
N-bit words" designs is on cost-eradicated 8-bit microcontrollers.

- Dave


> > That summary seems out-dated. The variable length of transfer word is
> > actually the maximum length of a single transfer and is 128 bits in the
> > latest version. So you get 4 registers, each 32 bits wide into which you
> > program the data you want to transfer. Then you set the number of bits of
> > that transfer so the core knows which registers and what bits of those
> > registers to shift out serially.

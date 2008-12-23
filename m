From: Ingo Oeser <ioe-lkml@rameria.de>
Subject: Re: [patch 2.6.28-rc9] spi: spi_write_then_read() regression fix
Date: Tue, 23 Dec 2008 02:53:59 +0100
Message-ID: <200812230254.00249.ioe-lkml@rameria.de>
References: <200812202332.36281.david-b@pacbell.net> <alpine.LFD.2.00.0812211545520.24883@localhost.localdomain> <200812211648.26699.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	spi-devel-general@lists.sourceforge.net,
	lkml <linux-kernel@vger.kernel.org>,
	Vernon Sauder <vernoninhand@gmail.com>
To: David Brownell <david-b@pacbell.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755916AbYLWByR@vger.kernel.org>
In-Reply-To: <200812211648.26699.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi David,

On Monday 22 December 2008, you wrote:
> On Sunday 21 December 2008, Linus Torvalds wrote:
> > 
> > On Sat, 20 Dec 2008, David Brownell wrote:
> > > 
> > > All SPI transfers are full duplex, and are packaged as half duplex
> > > by either discarding the data that's read ("write only"), or else
> > > by writing zeroes ("read only").  That patch wasn't ensuring that
> > > zeroes were getting written out during the "half duplex read" part
> > > of the transaction; instead, old RX bits were getting sent.
> > 
> > Hmm. In addition, isn't this broken (in that same function):
> 
> No -- this is full duplex.  The write_then_read() helper is
> simplifying a common half-duplex idiom for short operations,
> but the harware still does full duplex.  Buffer layout is:
> 
>   Before:	WWWWW0000000
>   After:	xxxxxRRRRRRR
> 
> That is, for every bit shifted out (W, 0) another one gets
> shifted in (x, R).  The I/O primitive essentially swaps
> contents of a one-word shift register between master and
> slave; or, sequences of such words.  Words don't need to
> be byte-size, though that's a common option.

> See above.  We only want the "R" bits which were shifted in
> right *after* the n_tx "W" bits.  If we offset rx_buf before
> the I/O, we'd start with the "x" don't-care bits and need to
> do something else to discard them.  (Plus, allocate more
> space at the end of the buffer.)

Wow, what interesting hardware logic and a nice explanation.

Could you put that into a comment somewhere close to those helpers?

You can safely assume, that any code which Linus doesn't understand
is non-trivial and needs a comment :-)


Best Regards

Ingo Oeser

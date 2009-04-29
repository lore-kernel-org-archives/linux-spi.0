From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [spi-devel-general] [PATCH v2] spi: Add support for the
	OpenCores SPI controller.
Date: Wed, 29 Apr 2009 08:22:08 +0200
Message-ID: <20090429062208.GA7784@avionic-design.de>
References: <200904041227.54687.david-b@pacbell.net> <200904280458.23018.david-b@pacbell.net> <20090428122011.GB6325@avionic-design.de> <200904281403.40757.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754328AbZD2GW0@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200904281403.40757.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

* David Brownell wrote:
> On Tuesday 28 April 2009, Thierry Reding wrote:
> > > > I couldn't really find a way to implement per-transfer overrides for the
> > > > word size because the controller simply has no concept of word sizes. Is it
> > > > in such cases still necessary to hardwire the word size to 8 bits?
> > > 
> > > Is this the http://www.opencores.org/?do=project&who=spi core?
> > 
> > Yes, it is.
> > 
> > > Its summary says "Variable length of transfer word up to 32 bits";
> > > does that mean "configurable when core is synthesized" instead of
> > > truly "variable"?
> > 
> > That summary seems out-dated. The variable length of transfer word is
> > actually the maximum length of a single transfer and is 128 bits in the
> > latest version.
> 
> So long as they don't couple "transfer" with chipselect activation
> and then de-activation, that's normal.
> 
> 128 bits is pretty big, but it should make no difference to the slave
> whether the host thinks of its data as one 128-bit word, sixteen 8-bit
> words, one 9-bit word followed by a 119-bit one, or whatever.
> 
> Unless the design is broken, so that you can't send words without
> flapping the chipselect.  That would surprise me.

So far, what I've been doing is just copy the transmission buffer in blocks
of 16 bytes byte-by-byte to the transmission registers (concatenating groups
of four bytes), then start the transfer. After the transfer I copy the bytes
back in the same manner to the receive buffer. I was assuming that the
buffers would be in the correct byte order at that point anyway.

This core actually allows manually setting the chipselect. It also has a mode
that automatically sets or clears the chipselect for each single "transfer"
(meaning up to those 128 bits). But as you say, that wouldn't be normal
behavior and breaks things.

> > I'm not sure whether this is supposed to be the same as the word size. If it
> > is it would mean that a single transfer can always only transfer one word.
> > Which is kind of inefficient, I would think.
> 
> A "struct spi_transfer" should include a arbitrary number of
> such words.  If the word size is over 8 bits, all the usual
> byte ordering concerns come into play.  You may optimize the
> register I/O however you like, so long as the bits on the
> wire come out in the right sequence.

What byte ordering are the transmit and receive buffers supposed to be in,
then? Native? Always big endian?

> Ignoring clock options, the canonical SPI transfer starts by
> activating a chip select, then clocking out an arbitrary number
> of bits (clocking *in* one bit for each one clocked out), and
> then de-activating chipselect.  Those bits are usually viewed
> as a sequence of various-size words ... not necesarily all
> the same size.  Example, some LCD controllers use 9-bit command
> words followed by pixel data encoded in bytes.
> 
> Now, how the bits get to/from the controller is an area where
> silicon can optimize.  For example, it's common to offload
> that work to a DMA controller that can do burst operations
> to keep the data bus efficiency high ... and to have a FIFO
> in there, so those bursts can be bigger than the word size.

I haven't experimented with using DMA transfers to this particular core
because there's currently no support for the generic DMA API on the CPU
we use.

> - Dave

Thierry

From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2] spi: Add support for the
	OpenCores SPI controller.
Date: Tue, 28 Apr 2009 14:03:40 -0700
Message-ID: <200904281403.40757.david-b__23104.9170870849$1240960578$gmane$org@pacbell.net>
References: <200904041227.54687.david-b@pacbell.net>
	<200904280458.23018.david-b@pacbell.net>
	<20090428122011.GB6325@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090428122011.GB6325-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 28 April 2009, Thierry Reding wrote:
> > > I couldn't really find a way to implement per-transfer overrides for the
> > > word size because the controller simply has no concept of word sizes. Is it
> > > in such cases still necessary to hardwire the word size to 8 bits?
> > 
> > Is this the http://www.opencores.org/?do=project&who=spi core?
> 
> Yes, it is.
> 
> > Its summary says "Variable length of transfer word up to 32 bits";
> > does that mean "configurable when core is synthesized" instead of
> > truly "variable"?
> 
> That summary seems out-dated. The variable length of transfer word is
> actually the maximum length of a single transfer and is 128 bits in the
> latest version.

So long as they don't couple "transfer" with chipselect activation
and then de-activation, that's normal.

128 bits is pretty big, but it should make no difference to the slave
whether the host thinks of its data as one 128-bit word, sixteen 8-bit
words, one 9-bit word followed by a 119-bit one, or whatever.

Unless the design is broken, so that you can't send words without
flapping the chipselect.  That would surprise me.


> I'm not sure whether this is supposed to be the same as the word size. If it
> is it would mean that a single transfer can always only transfer one word.
> Which is kind of inefficient, I would think.

A "struct spi_transfer" should include a arbitrary number of
such words.  If the word size is over 8 bits, all the usual
byte ordering concerns come into play.  You may optimize the
register I/O however you like, so long as the bits on the
wire come out in the right sequence.

Ignoring clock options, the canonical SPI transfer starts by
activating a chip select, then clocking out an arbitrary number
of bits (clocking *in* one bit for each one clocked out), and
then de-activating chipselect.  Those bits are usually viewed
as a sequence of various-size words ... not necesarily all
the same size.  Example, some LCD controllers use 9-bit command
words followed by pixel data encoded in bytes.

Now, how the bits get to/from the controller is an area where
silicon can optimize.  For example, it's common to offload
that work to a DMA controller that can do burst operations
to keep the data bus efficiency high ... and to have a FIFO
in there, so those bursts can be bigger than the word size.

- Dave

------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf

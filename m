From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Accelerometer,
	Gyros and ADC's etc within the kernel.
Date: Tue, 27 May 2008 16:42:42 -0700
Message-ID: <200805271642.42291.david-b@pacbell.net>
References: <4832A211.4040206@gmail.com>
	<200805211753.39133.david-b@pacbell.net>
	<20080527155641.GB29868@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Jonathan Cameron <Jonathan.Cameron-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LM Sensors <lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org>
To: mgross-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080527155641.GB29868-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 27 May 2008, mark gross wrote:
> =

> > > Another problem area is around SPI itself. =A0There are variations of
> > > device implementations around chip select polarity, clock biasing
> > > (rising,falling, or midpoint) sampling from one SPI part to the next.
> > =

> > Midpoint? =A0That's not one I've come across before. =A0All four
> > standard SPI clock/sample/shift modes are already supported
> > in the SPI framework though. =A0Ditto active-high chipselects
> > (vs normal active-low) etc.
> =

> Yeah, its one of the sampling modes for the PIC18F4455 its one of the
> master mode sampling options =A0(see page 194 of
> http://ww1.microchip.com/downloads/en/DeviceDoc/39632D.pdf )

Actually figure 19-3 (p. 198) may be a bit more clear.

Curious.  That PIC18F controller has *three* bits ... equivalents
of CPOL and CPHA, plus a bit saying whether to wait a whole or
half clock after the leading clock edge before sampling it.

A quick survey of some other SPI chips suggests that the most
conventional interpretation is to sample on the trailing edge
of the clock, and not presume long hold times.

I would surely hope the SPI interface spec doesn't have to get
into the mess of timing variations which typify anyone trying to
make memory controllers do the Right thing ... *shudder* ...

- Dave



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

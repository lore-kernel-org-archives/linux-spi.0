From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for
	SPI busses
Date: Thu, 22 May 2008 19:26:23 -0700
Message-ID: <200805221926.24112.david-b@pacbell.net>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<716a0f1b6c9a544b480c06a329072483@kernel.crashing.org>
	<fa686aa40805211233h72a258bpf8c945b9f662d6ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	Segher Boessenkool <segher-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fa686aa40805211233h72a258bpf8c945b9f662d6ee-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Wednesday 21 May 2008, Grant Likely wrote:
> > spi-controller {
> > =A0 =A0 =A0 =A0#address-cells =3D 2;
> > =A0 =A0 =A0 =A0#size-cells =3D 0;
> > =A0 =A0 =A0 =A0some-device@0,f000 { reg =3D < 0 f000 >; } // CS 0, SPI =
address f000
> > =A0 =A0 =A0 =A0some-device@1,f000 { reg =3D < 1 f000 >; } // CS 1, SPI =
address f000
> > =A0 =A0 =A0 =A0some-device@1,ff00 { reg =3D < 1 ff00 >; } // CS 1, SPI =
address ff00
> > }
> =

> For SPI the CS # *is* the address. =A0:-)
> =

> Unlike I2C, SPI doesn't impose any protocol on the data. =A0It is all
> anonymous data out, anonymous data in, a clock and a chip select.

Very true ... but then there are SPI chips which embed addressing.

I have in mind the mcp23s08 (and mcp23s17) GPIO expanders, which
support up to four chips wired in parallel on a given chipselect.
The devices are distinguished by how two address pins are wired;
and two bits in the command byte must match them.  (I think they
just recycled an I2C design into the SPI world.)

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

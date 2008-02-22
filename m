From: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [patch 2.6.25-rc2] SPI -- Freescale iMX SPI
	controller driver (resend)
Date: Fri, 22 Feb 2008 10:15:50 +0100
Message-ID: <200802221015.51624.jbe@pengutronix.de>
References: <FLEPLOLKEPNLMHOILNHPOEKHECAA.a.paterniani@swapp-eng.it>
	<20080220202752.GC25138@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org,
	SPI Devel General <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080220202752.GC25138-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

On Wednesday 20 February 2008 21:27, Robert Schwebel wrote:
> On Tue, Feb 19, 2008 at 10:49:42AM +0100, Andrea Paterniani wrote:
> > Subject: [patch-2.6.25-rc2-spi_imx] arm: SPI controller driver for
> > Freescale iMX From: Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
> >
> > Kernel version: linux-2.6.25-rc2.
> > Patch description:
> > 1) Some comments changed and/or added.
> > 2) End of transfers is now managed on TXFIFO empty interrupt after the
> > last write to TXFIFO. This management shorten interrupt execution time
> > removing the waiting for TXFIFO emptying.
> >    On TXFIFO empty interrupt the handler needs only to wait for the end
> > of ongoing transaction (polling SPI_CONTROL_XCH) to close transfer. 2.1)
> > Write only transfers are closed flushing RXFIFO.
> >    2.2) Read transfers are closed reading trailing bytes from RXFIFO.
> >    2.3) Read transfers where RXFIFO overrun occurred are closed flushing
> >         RXFIFO and aborting message.
> > 3) Fifos are now flushed via SPI disable after the end of ongoing
> > transaction.
>
> How different is the i.MX1 SPI driver from our combined i.MX27/i.MX21
> driver?

Both SPI implementations differ in hardware.

Register	i.MX1		i.MX2
RxData:		16 bit		32 bit
TxData:		16 bit		32 bit
ControlReg:	16 bit		32 Bit plus additional control bits
IntReg		16 bit		32 Bit plus additional status/control bits,
				   some are shifted to other bit positions
				   than i.MX1
TestReg		16 bit		16 bit, but additional control bits
PeriodReg		same
DMAreg		   seems the same
ResetReg		same

It would be nice of we could handle both hardware implementations with one =

driver.

Juergen
-- =

Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

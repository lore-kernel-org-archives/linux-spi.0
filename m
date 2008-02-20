From: Robert Schwebel <r.schwebel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [patch 2.6.25-rc2] SPI -- Freescale iMX SPI
	controller driver	(resend)
Date: Wed, 20 Feb 2008 21:27:52 +0100
Message-ID: <20080220202752.GC25138@pengutronix.de>
References: <FLEPLOLKEPNLMHOILNHPOEKHECAA.a.paterniani@swapp-eng.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org,
	Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>,
	Linux ARM Kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>,
	SPI Devel General <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Juergen Beisert <j.beisert-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <FLEPLOLKEPNLMHOILNHPOEKHECAA.a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
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

J=FCrgen,

On Tue, Feb 19, 2008 at 10:49:42AM +0100, Andrea Paterniani wrote:
> Subject: [patch-2.6.25-rc2-spi_imx] arm: SPI controller driver for Freesc=
ale iMX
> From: Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
>
> Kernel version: linux-2.6.25-rc2.
> Patch description:
> 1) Some comments changed and/or added.
> 2) End of transfers is now managed on TXFIFO empty interrupt after the la=
st
>    write to TXFIFO. This management shorten interrupt execution time remo=
ving
>    the waiting for TXFIFO emptying.
>    On TXFIFO empty interrupt the handler needs only to wait for the end of
>    ongoing transaction (polling SPI_CONTROL_XCH) to close transfer.
>    2.1) Write only transfers are closed flushing RXFIFO.
>    2.2) Read transfers are closed reading trailing bytes from RXFIFO.
>    2.3) Read transfers where RXFIFO overrun occurred are closed flushing
>         RXFIFO and aborting message.
> 3) Fifos are now flushed via SPI disable after the end of ongoing transac=
tion.

How different is the i.MX1 SPI driver from our combined i.MX27/i.MX21
driver?

Background: we have worked on i2c and SPI drivers for the i.MX27 this
week, and it is almost finished.

Robert
-- =

 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

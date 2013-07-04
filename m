From: Johannes Stezenbach <js-FF7aIK3TAVNeoWH0uzbU5w@public.gmane.org>
Subject: Re: SPI: DUAL/QUAD support
Date: Thu, 4 Jul 2013 20:06:56 +0200
Message-ID: <20130704180656.GA1974@sig21.net>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
	<20130704143645.GA27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130704143645.GA27646-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 04, 2013 at 03:36:45PM +0100, Mark Brown wrote:
> On Thu, Jul 04, 2013 at 07:36:48PM +0800, yuhang wang wrote:
> > +Description
> > +----------------------
> > +DUAL/QUAD means spi can transfer in 2bits/4bits at the same time.
> > +These spi controllers provide 8 data lines(4-tx and 4-rx). User can
> > +choose tranfer mode(SINGLE/DUAL/QUAD) by setting the certain register.
> > +Though SPI is a serial interface, some spi controllers can support
> > +transmitting and receiving in DUAL and QUAD modes aimed to improve
> > +the performance. Also as spi slave lots of flashes do support this attribute,
> > +such as serial-norflash in spansion company.
> 
> OK, so all this is about is devices that have extra data lines.  Please
> don't invent terms like "DUAL" and "QUAD", it makes things much less
> clear.  Just describe it as support for multiple data lines.

Flash data sheets use the terms Dual and Quad I/O Mode,
e.g. for MX25L25635E
http://www.macronix.com/QuickPlace/hq/PageLibrary4825740B00298A3B.nsf/h_Index/6F878CF760C559BD482576E00022E6CC/?OpenDocument&EPN=MX25L25635E

> > +struct spi_transfer {
> > ++       u8     bitwidth;
> > ++#define        SPI_BITWIDTH_SINGLE     0x01; /* 1bit transfer */
> > ++#define        SPI_BITWIDTH_DUAL       0x02; /* 2bits transfer */
> > ++#define        SPI_BITWIDTH_QUAD       0x03; /* 4bits transfer */
> 
> Calling this "bandwidth" is really unclear - I would expect a bandwidth
> to be expressed in bits per second or similar.  This would be much
> clearer if it was just the number of data signals.

"bitwidth" != "bandwidth", but maybe the name could be improved,
how about xfer_width?  The mmc susbsysem has something similar
and calls it bus_width.

> > +       t[0].rx_buf = buf;
> > +       t[0].len = len;
> > +       t[0].bitwidth = spi->rx_bitwidth/spi->tx_bitwidth;
> > +       spi_message_add_tail(&t[0], &m);
> 
> This interface won't work for bidirectional transfers with asymmetric
> numbers of data lines - we need separate fields for rx and rx.

I'm not aware that bidirectional transfers are supported in
dual or quad IO mode.  I think only flash supports it and
uses all available IO lines as either input (flash write
command) or output (flash read command).  I.e. for MX25L25635E flash
it means at least the command, but usually also the address,
are transferred in single IO mode, only then do the flash
and controller switch to parallel IO for the data transfer.


Johannes

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev

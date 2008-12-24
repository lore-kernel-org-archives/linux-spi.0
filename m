From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.28-rc9] spi:
	spi_write_then_read() regression fix
Date: Wed, 24 Dec 2008 11:43:04 -0800
Message-ID: <200812241143.04706.david-b@pacbell.net>
References: <200812202332.36281.david-b@pacbell.net>
	<200812240039.32008.david-b@pacbell.net>
	<20081224085844.GA11197@diamond.tkos.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20081224085844.GA11197-l+PWtdWbHAs2zBO71LVbc/qBs+8SCbDb@public.gmane.org>
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

On Wednesday 24 December 2008, Baruch Siach wrote:
> > I've certainly seen a couple drivers that handled the
> > full duplex behavior incorrectly, until they fixed that
> > bug. =A0As in, they wrote the tx_buf *then* read rx_buf
> > (a half-duplex model) instead of doing them concurrently
> > (the full-duplex model a spi_master must implement).
> =

> May you name those drivers and the commits with the bug fixes?
> I couldn't find them in Linus' tree.

I don't recall such a driver merging to mainline;
the idea is to catch such fundamental bugs before
they merge.


> I'm working on an SPI master (DesignWare) driver and I want
> to make sure that  I'm implementing the API correctly.

Lacking a test suite for the spi_master drivers,
I suggest that you verify your driver works with
some of the existing protocol drivers.  If at all
possible, hook up a couple SPI slaves to different
chipselects on your master, and test them all.

Then, if you find misbehavior when you test a
driver that's already known to work with a bunch
of controller drivers, it's more likely that the
bug is in your new code than the existing code.

- Dave





---------------------------------------------------------------------------=
---

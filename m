From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.28-rc9] spi:
	spi_write_then_read() regression fix
Date: Wed, 24 Dec 2008 00:39:31 -0800
Message-ID: <200812240039.32008.david-b@pacbell.net>
References: <200812202332.36281.david-b@pacbell.net>
	<200812231953.26407.david-b@pacbell.net>
	<EADF0A36011179459010BDF5142A45750458C815@pdsmsx502.ccr.corp.intel.com>
Reply-To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: "Tang, Feng" <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EADF0A36011179459010BDF5142A45750458C815-Uz4Je35TzWuiAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

On Tuesday 23 December 2008, Tang, Feng wrote:
> o. After that it fails on 2.6.28, I wrote a new API inside
> my driver which is similar to your 2.6.28 spi_write_then_read(),
> but modify the buffer layout. And the new API works fine for my
> max3111 device. =


Sounds to me like the issue is a buggy SPI controller
driver ... is this a driver that's in mainline?

I've certainly seen a couple drivers that handled the
full duplex behavior incorrectly, until they fixed that
bug.  As in, they wrote the tx_buf *then* read rx_buf
(a half-duplex model) instead of doing them concurrently
(the full-duplex model a spi_master must implement).


> > Before: WWWWWW
> > After: =A0RRRRRR

That's obviously incorrect, or you're introducing
some new notation.  See my previous notes.

- Dave



---------------------------------------------------------------------------=
---

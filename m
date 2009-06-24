From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 0/2] spi: add driver for SPI
	controller of Intel Moorestown platform
Date: Tue, 23 Jun 2009 19:09:54 -0700
Message-ID: <200906231909.54345.david-b@pacbell.net>
References: <20090615173845.59f3437b@feng-desktop>
	<20090615101815.GB21428@tarshish>
	<EADF0A36011179459010BDF5142A457501C9D987BD@pdsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org" <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	"alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org" <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
To: "Tang, Feng" <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
 Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <EADF0A36011179459010BDF5142A457501C9D987BD-Uz4Je35TzWuiAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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

On Monday 15 June 2009, Tang, Feng wrote:
> >>
> >> User can use "dw_apb_ssi_db.pdf" from Synopsys as HW datasheet
> >
> >Wow. This is a big surprise for me. I was working on a driver of the Synopsys
> >Designware SPI controller myself during the last year. I posted my work on
> >this list and got reviews from Linus Walleij. No word from David Brownell yet.
> >I'll look into your work and see whether we can merge the drivers.
> 
> Good idea, we can work together to make the driver better.
> 
> Regarding the driver name, it is implemented as a PCI device driver, also it has
> some Moorestown specific stuff like DMA operation, DMA part of the driver only
> works with the DMA controller on Moorestown, that's why I used such a name.
> Anyway, we can discuss more about it.

Then the way to structure it is the classic "bus glue plus core".

Core would be a "designware_spi" (or, "dw_spi" by analogy to the
"dw_dmac" DMA driver).  It would either expose private calls to
bus glue -- PCI or APB, I guess -- or would be a platform_bus thing
with the PCI glue creating a platform_bus child of a PCI node.

- Dave


------------------------------------------------------------------------------

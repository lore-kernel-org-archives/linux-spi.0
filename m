From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: SPI Framework chip select
Date: Sat, 1 Mar 2008 12:37:50 -0800
Message-ID: <200803011237.51349.david-b@pacbell.net>
References: <47C85451.1030809@whoi.edu>
	<200802291338.55149.david-b@pacbell.net>
	<47C88793.1050205@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47C88793.1050205-/d+BM93fTQY@public.gmane.org>
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

On Friday 29 February 2008, Ned Forrester wrote:
> David Brownell wrote:

> > The chipselect number is always useful when the SPI bus has more
> > than one slave; it's how the slaves are distinguished.
> 
> Ahh... Here is a place where pxa2xx-spi departs from the SPI framework
> by choice.  That driver never uses spi_device.chip_select

Not directly.  Indirectly, since each chip_select is associated
with a unique pxa2xx_spi_chip.cs_control().  The chipselect number
(and signal) still distinguishes chips from each other.


> I suppose that it could alternatively been implemented by storing the
> cs_control pointers in an array during setup(), and then using the index
> in spi_device.chip_select to access the various functions.  Either way
> seems to work.

Right.  The pxa2xx_spi driver could use any scheme to manage the
chipselect signals, so long as each number maps to a unique signal.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

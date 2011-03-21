From: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
Subject: Re: dw_spi CS control/transfer modes
Date: Mon, 21 Mar 2011 08:14:48 +0000
Message-ID: <20110321081448.GB3273@pulham.picochip.com>
References: <20110318201135.GE3393@pulham.picochip.com>
	<20110321100642.24c326f9@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>,
	"george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org" <george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20110321100642.24c326f9@feng-i7>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Feng,

On Mon, Mar 21, 2011 at 10:06:42AM +0800, Feng Tang wrote:
> Hi Jamie,
> 
> On Sat, 19 Mar 2011 04:11:35 +0800
> Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org> wrote:
> 
> > Hi,
> > 
> > I have a platform with a DesignWare SSI and I'm trying to use the
> > dw_spi block using a GPIO for the chip select to workaround the
> > problem of CS changing and the device losing state (we have a SPI
> > flash attached), and I've found that using interrupt driven
> > transfers, reading the SPI flash results in very few interrupts from
> > the controller and a sluggish system (and no data from the flash).
> > 
> > However, I've found that removing the conditional transfer mode
> > setting (effectively reverting commit 052dc7c45 [spi/dw_spi:
> > conditional transfer mode changes]) allows everything to work fine by
> > keeping the transfer mode to transmit+receive.
> 
> What version of code are you using? The "cs_control" will be default to
> NULL if "dw_spi_chip" as the controller data doesn't explicitly set it,
> and then that piece of code won't be called.

Sorry, I should have specified that; I'm using next as of a couple of 
days ago.  I am intentionally specifying a cs_control callback so that 
we can control the chip select using GPIO as we've seen with this block 
that allowing the FIFO to empty will cause the block driven CS to go 
low.  If we use only the block controlled CS then we get all zero's back 
from a programmed SPI flash.

Jamie

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d

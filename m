From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.24-rc8] spi: s3c drivers
	shouldn't care about spi_board_info
Date: Tue, 22 Jan 2008 00:23:33 -0800
Message-ID: <200801220023.33724.david-b@pacbell.net>
References: <200801212341.07086.david-b@pacbell.net>
	<20080122000911.4b61af5c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080122000911.4b61af5c.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
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

On Tuesday 22 January 2008, Andrew Morton wrote:
> On Mon, 21 Jan 2008 23:41:06 -0800 David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> 
> > The two S3C SPI master drivers got merged without much review, so
> > I just noticed that they're doing something that the SPI core code
> > is responsible for, rather than any adapter driver:  they try to
> > register SPI devices.
> 
> err, but these driver predate the generic SPI core, I think?

Nope.  Such predated drivers don't land in drivers/spi ... and
if they did predate it, they wouldn't have been able to try
using those interfaces!


> > drivers/spi/spi_s3c24xx.c      |   12 ------------
> > drivers/spi/spi_s3c24xx_gpio.c |   12 ------------
> > include/asm/arch/spi-gpio.h    |    6 ------
> > include/asm/arch/spi.h         |    6 ------
> 
> argh, please don't do that.
> 
> <searches>
> 
> It looks like this is referring to include/asm-arm/arch-s3c2410/

Whoops, yes -- you're right.  Sorry.

Quilt is doing a disservice there, by not using /bin/pwd to figure
out directories.  It's *way* too easy for that sort of mistake to
sneak in when you just "quilt add spi*h".  And then sometimes slip
through on upstream pushes.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

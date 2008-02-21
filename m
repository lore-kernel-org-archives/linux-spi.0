From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [patch 2.6.24-rc8] spi: s3c drivers
	shouldn't care about spi_board_info
Date: Wed, 20 Feb 2008 18:37:46 -0800
Message-ID: <200802201837.46449.david-b@pacbell.net>
References: <200801212341.07086.david-b@pacbell.net>
	<20080219101048.GA24550@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080219101048.GA24550-SMNkleLxa3Z6Wcw2j4pizdi2O/JbrIOy@public.gmane.org>
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

On Tuesday 19 February 2008, Ben Dooks wrote:
> On Mon, Jan 21, 2008 at 11:41:06PM -0800, David Brownell wrote:
> > The two S3C SPI master drivers got merged without much review, so
> > I just noticed that they're doing something that the SPI core code
> > is responsible for, rather than any adapter driver:  they try to
> > register SPI devices.
> > 
> > This removes that support from those drivers so they act normally.
> > Interestingly, none of the current boards are affected.  So it's
> > a net code shrink with no loss of functionality.
> 
> For you, for me you've just broken my current in-development patch-set.

So those patches have problems that won't get a chance to go upstream.  :)


> Numbering busses makes life more difficult when registering the things,
> as on a design using a pluggable cpu module, you do not know at compile
> time what bus numbers are going to be assigned, especially if your
> adapters are not all of the same hardware.

Those problems are workable.  There's clearly *something* which knows
which physical bus has which devices attached, and can connect them.
It can call spi_new_device() for example -- with no driver-specific
mechanisms required.

If this is a general problem, it deserves a general solution, not one
that's specific to one controller driver.  There are such mechanisms
already, which you're not using.  If you want some different generic
mechanisms, then feel free to propose them.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

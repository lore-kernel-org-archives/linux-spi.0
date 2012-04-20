From: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi/spi-ep93xx.c: use dma_transfer_direction instead
	of dma_data_direction
Date: Fri, 20 Apr 2012 15:39:51 +0530
Message-ID: <1334916592.31825.35.camel@vkoul-udesk3>
References: <201204171846.37245.hartleys@visionengravers.com>
	<20120419061020.GB18520@mwesterb-mobl.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120419061020.GB18520-p43JL9BdyTL/j2AmgGM1vP8+0UxHXcjY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 2012-04-19 at 09:10 +0300, Mika Westerberg wrote:
> On Tue, Apr 17, 2012 at 06:46:36PM -0700, H Hartley Sweeten wrote:
> > A new enum indicating the dma channel direction was introduced by:
> > 
> > commit 49920bc66984a512f4bcc7735a61642cd0e4d6f2
> >     dmaengine: add new enum dma_transfer_direction
> > 
> > The following commit changed spi-ep93xx to use the new enum:
> > 
> > commit a485df4b4404379786c4bdd258bc528b2617449d
> >     spi, serial: move to dma_transfer_direction
> > 
> > In doing so a sparse warning was introduced: 
> > 
> > warning: mixing different enum types
> >    int enum dma_data_direction  versus
> >    int enum dma_transfer_direction
> > 
> > This is produced because the 'dir' passed in ep93xx_spi_dma_prepare
> > is an enum dma_data_direction and is being used to set the
> > dma_slave_config 'direction' which is now an enum dma_transfer_direction.
> > 
> > Fix this by converting spi-ep93xx to use the new enum type in all
> > places.
> > 
> > Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
> > Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> > Cc: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> Acked-by: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Acked-by: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

-- 
~Vinod


------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2

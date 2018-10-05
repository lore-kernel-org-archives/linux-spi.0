From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] spi: spi-ep93xx: Change dir type in
 ep93xx_spi_dma_{finish,prepare}
Date: Fri, 5 Oct 2018 01:52:35 -0700
Message-ID: <20181005085235.GA2106@localhost>
References: <20181004023926.15847-1-natechancellor@gmail.com>
 <20181004103247.GC6412@sirena.org.uk>
 <20181005082844.GT2302@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        H Hartley Sweeten <hartleys@visionengravers.com>,
        Mika Westerberg <mika.westerberg@iki.fi>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181005082844.GT2302@lahna.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 05, 2018 at 11:28:44AM +0300, Mika Westerberg wrote:
> Hi,
> 
> On Thu, Oct 04, 2018 at 11:32:47AM +0100, Mark Brown wrote:
> > On Wed, Oct 03, 2018 at 07:39:26PM -0700, Nathan Chancellor wrote:
> > > Clang warns when one enumerated type is implicitly converted to another.
> > > 
> > > drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
> > > enumeration type 'enum dma_transfer_direction' to different enumeration
> > 
> > Please remember to CC driver maintainers and authors on patch
> > submissions so they can review things, copying in Hartley and Mika.
> 
> Thanks for copying me.
> 
> > > type 'enum dma_data_direction' [-Wenum-conversion]
> > >         nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> > >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > > ./include/linux/dma-mapping.h:428:58: note: expanded from macro
> > > 'dma_map_sg'
> > > \#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
> > >                                ~~~~~~~~~~~~~~~~          ^
> > > drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
> > > enumeration type 'enum dma_transfer_direction' to different enumeration
> > > type 'enum dma_data_direction' [-Wenum-conversion]
> > >                 dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> > >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > > 'dma_unmap_sg'
> > > \#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
> > >                                  ~~~~~~~~~~~~~~~~~~          ^
> > > drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
> > > enumeration type 'enum dma_transfer_direction' to different enumeration
> > > type 'enum dma_data_direction' [-Wenum-conversion]
> > >         dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> > >         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > > 'dma_unmap_sg'
> > > \#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
> > >                                  ~~~~~~~~~~~~~~~~~~          ^
> > > 3 warnings generated.
> > > 
> > > dma_{,un}map_sg expects an enum of type dma_data_direction but this
> > > driver uses dma_transfer_direction for everything. Converting to
> > > dma_data_direction would be desirable but there are a few shared
> > > structures that expect dma_transfer_direction so it is just simpler to
> > > change the parameter here. dma_transfer_direction and dma_data_direction
> > > are different sizes but this driver only uses the 1 and 2 values which
> > > mean the same thing so this change is safe.
> 
> I would rather do the conversion than passing "int" to the function even
> if both enums happen to have same value now. I would be surprised if
> there is no helper function already for the conversion :)

Hi Mika,

I will go ahead and spin up a v3 in the morning for review and copy you
and Hartley, thanks for the comments!

Nathan

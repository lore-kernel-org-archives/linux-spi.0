From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH v2] spi: spi-ep93xx: Change dir type in
 ep93xx_spi_dma_{finish,prepare}
Date: Thu, 4 Oct 2018 14:47:13 -0700
Message-ID: <20181004214713.GA7147@flashbox>
References: <20181004023926.15847-1-natechancellor@gmail.com>
 <20181004024010.15986-1-natechancellor@gmail.com>
 <CAKwvOd=QdyNnTz19Vc6FSQfbKrFnvZ7VHYvhaMtfcNCKYm2Utg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKwvOd=QdyNnTz19Vc6FSQfbKrFnvZ7VHYvhaMtfcNCKYm2Utg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Oct 04, 2018 at 02:32:48PM -0700, Nick Desaulniers wrote:
> On Wed, Oct 3, 2018 at 7:41 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > Clang warns when one enumerated type is implicitly converted to another.
> >
> > drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
> > enumeration type 'enum dma_transfer_direction' to different enumeration
> > type 'enum dma_data_direction' [-Wenum-conversion]
> 
> I'm just trying to think what this change would look like if this
> driver ONLY used `enum dma_data_direction`?  There's an additional

I can work up a proof of concept patch but it was kind of convoluted
when I tried before this patch because dmaengine_prep_slave_sg and the
direction member in struct dma_slave_config expect an enum of type
dma_transfer_direction so there are two explicit casts needed and I
thought there were one or two more places that it complained.

This was the cleanest solution to me but I'm happy to rework it in any
way that I need to.

> warning in the header that a return value is messed up there, too:
> 
> In file included from drivers/spi/spi-ep93xx.c:34:
> ./include/linux/platform_data/dma-ep93xx.h:88:10: warning: implicit
> conversion from
>       enumeration type 'enum dma_data_direction' to different
> enumeration type 'enum
>       dma_transfer_direction' [-Wenum-conversion]
>                 return DMA_NONE;
>                 ~~~~~~ ^~~~~~~~
> 

This is fixed in the dma tree and that function isn't used in this file:
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git/commit/?id=9524d6b265f9b2b9a61fceb2ee2ce1c2a83e39ca

> >         nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > ./include/linux/dma-mapping.h:428:58: note: expanded from macro
> > 'dma_map_sg'
> > #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
> >                                ~~~~~~~~~~~~~~~~          ^
> > drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
> > enumeration type 'enum dma_transfer_direction' to different enumeration
> > type 'enum dma_data_direction' [-Wenum-conversion]
> >                 dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> >                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > 'dma_unmap_sg'
> > #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
> >                                  ~~~~~~~~~~~~~~~~~~          ^
> > drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
> > enumeration type 'enum dma_transfer_direction' to different enumeration
> > type 'enum dma_data_direction' [-Wenum-conversion]
> >         dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
> >         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> > ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> > 'dma_unmap_sg'
> > #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
> >                                  ~~~~~~~~~~~~~~~~~~          ^
> > 3 warnings generated.
> >
> > dma_{,un}map_sg expects an enum of type dma_data_direction but this
> > driver uses dma_transfer_direction for everything. Converting to
> > dma_data_direction would be desirable but there are a few shared
> > structures that expect dma_transfer_direction so it is just simpler to
> > change the parameter here. dma_transfer_direction and dma_data_direction
> > are different sizes but this driver only uses the 1 and 2 values which
> > mean the same thing so this change is safe.
> >
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >
> > v1 -> v2:
> >
> > * Fix escaped hash symbols for '#define' lines
> >
> >  drivers/spi/spi-ep93xx.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> > index f1526757aaf6..189fc2225b69 100644
> > --- a/drivers/spi/spi-ep93xx.c
> > +++ b/drivers/spi/spi-ep93xx.c
> > @@ -256,8 +256,7 @@ static int ep93xx_spi_read_write(struct spi_master *master)
> >   * in case of failure.
> >   */
> >  static struct dma_async_tx_descriptor *
> > -ep93xx_spi_dma_prepare(struct spi_master *master,
> > -                      enum dma_transfer_direction dir)
> > +ep93xx_spi_dma_prepare(struct spi_master *master, int dir)
> >  {
> >         struct ep93xx_spi *espi = spi_master_get_devdata(master);
> >         struct spi_transfer *xfer = master->cur_msg->state;
> > @@ -359,8 +358,7 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
> >   * Function finishes with the DMA transfer. After this, the DMA buffer is
> >   * unmapped.
> >   */
> > -static void ep93xx_spi_dma_finish(struct spi_master *master,
> > -                                 enum dma_transfer_direction dir)
> > +static void ep93xx_spi_dma_finish(struct spi_master *master, int dir)
> >  {
> >         struct ep93xx_spi *espi = spi_master_get_devdata(master);
> >         struct dma_chan *chan;
> > --
> > 2.19.0
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers

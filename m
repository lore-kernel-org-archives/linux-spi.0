From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v4] spi: spi-ep93xx: Use dma_data_direction for
 ep93xx_spi_dma_{finish,prepare}
Date: Mon, 8 Oct 2018 21:53:02 +0300
Message-ID: <20181008185302.GE2302@lahna.fi.intel.com>
References: <20181005192508.18659-1-natechancellor@gmail.com>
 <20181008180846.14119-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: H Hartley Sweeten <hartleys@visionengravers.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181008180846.14119-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Oct 08, 2018 at 11:08:47AM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another.
> 
> drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]
>         nents = dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> ./include/linux/dma-mapping.h:428:58: note: expanded from macro
> 'dma_map_sg'
> #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
>                                ~~~~~~~~~~~~~~~~          ^
> drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]
>                 dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> 'dma_unmap_sg'
> #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>                                  ~~~~~~~~~~~~~~~~~~          ^
> drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]
>         dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> 'dma_unmap_sg'
> #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>                                  ~~~~~~~~~~~~~~~~~~          ^
> 3 warnings generated.
> 
> dma_{,un}map_sg expect an enum of type dma_data_direction but this
> driver uses dma_transfer_direction for everything. Convert the driver to
> use dma_data_direction for these two functions.
> 
> There are two places that strictly require an enum of type
> dma_transfer_direction: the direction member in struct dma_slave_config
> and the direction parameter in dmaengine_prep_slave_sg. To avoid using
> an explicit cast, add a simple function, ep93xx_dma_data_to_trans_dir,
> to safely map between the two types because they are not 1 to 1 in
> meaning.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

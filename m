From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: Fix WARN when removing spi-fsl-spi module
Date: Fri, 23 Sep 2011 17:29:36 -0600
Message-ID: <20110923232936.GI24631@ponder.secretlab.ca>
References: <1316792976-28498-1-git-send-email-jeff_harris@kentrox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Jeff Harris <jeff_harris@kentrox.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1316792976-28498-1-git-send-email-jeff_harris@kentrox.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Sep 23, 2011 at 11:49:36AM -0400, Jeff Harris wrote:
> If CPM mode is not used, the fsl_dummy_rx variable is never allocated.  When
> the cleanup attempts to free it, the reference count is zero and a WARN is
> generated.  The same CPM mode check used in the initialize is applied to the
> free as well.
> 
> Tested on 2.6.33 with the previous spi_mpc8xxx driver.  The renamed
> spi-fsl-spi driver looks to have the same problem.
> 
> Signed-off-by: Jeff Harris <jeff_harris@kentrox.com>

Merged, thanks.

g.

> ---
>  drivers/spi/spi-fsl-spi.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
> index d240755..24cacff 100644
> --- a/drivers/spi/spi-fsl-spi.c
> +++ b/drivers/spi/spi-fsl-spi.c
> @@ -825,6 +825,9 @@ static void fsl_spi_cpm_free(struct mpc8xxx_spi *mspi)
>  {
>  	struct device *dev = mspi->dev;
>  
> +	if (!(mspi->flags & SPI_CPM_MODE))
> +		return;
> +
>  	dma_unmap_single(dev, mspi->dma_dummy_rx, SPI_MRBLR, DMA_FROM_DEVICE);
>  	dma_unmap_single(dev, mspi->dma_dummy_tx, PAGE_SIZE, DMA_TO_DEVICE);
>  	cpm_muram_free(cpm_muram_offset(mspi->tx_bd));
> -- 
> 1.7.0.5
> 

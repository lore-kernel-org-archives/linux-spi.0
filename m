From: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: Applied "spi: davinci: enable DMA when channels are defined in
 DT" to the spi tree
Date: Wed, 8 Mar 2017 11:35:02 +0100
Message-ID: <11df78f1-7b4e-5093-f166-b3af21c03abc@baylibre.com>
References: <E1clG07-0006mU-6x@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        nsekhar-l0cyMroinI0@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E1clG07-0006mU-6x@finisterre>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark,

To avoid data corruption issues with UBIFS volume over SPI NOR, DMA should not be used for vmalloc'ed buffers. The 5'th patch in my series fixes that:

0003-spi-davinci-use-rx-buffer-as-dummy-tx-buffer.patch
0004-spi-davinci-do-not-use-DMA-if-transfer-length-is-les.patch
0005-spi-davinci-do-not-use-DMA-for-vmalloc-ed-buffers.patch

Thanks,

Frode



On 07/03/2017 15:22, Mark Brown wrote:
> The patch
>
>    spi: davinci: enable DMA when channels are defined in DT
>
> has been applied to the spi tree at
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 
>
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
>
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
>
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
>
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
>
> Thanks,
> Mark
>
> From 3e2e1258443ea97e40dfb4a3cf15108d17939066 Mon Sep 17 00:00:00 2001
> From: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Date: Thu, 23 Feb 2017 19:01:57 +0100
> Subject: [PATCH] spi: davinci: enable DMA when channels are defined in DT
>
> When booting with DT the SPI driver is always using
> the SPI_IO_TYPE_INTR mode to transfer data even if DMA channels are
> defined in the DT.
>
> This commit changes the behaviour to select the SPI_IO_TYPE_DMA mode
> if DMA channels are defined in the DT and will keep SPI_IO_TYPE_INTR
> if the channels are not defined in it.
>
> Signed-off-by: Fabien Parent <fparent-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Frode Isaksen <fisaksen-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>  drivers/spi/spi-davinci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
> index 164cc719be54..1e24395a04f2 100644
> --- a/drivers/spi/spi-davinci.c
> +++ b/drivers/spi/spi-davinci.c
> @@ -389,6 +389,7 @@ static int davinci_spi_of_setup(struct spi_device *spi)
>  {
>  	struct davinci_spi_config *spicfg = spi->controller_data;
>  	struct device_node *np = spi->dev.of_node;
> +	struct davinci_spi *dspi = spi_master_get_devdata(spi->master);
>  	u32 prop;
>  
>  	if (spicfg == NULL && np) {
> @@ -400,6 +401,9 @@ static int davinci_spi_of_setup(struct spi_device *spi)
>  		if (!of_property_read_u32(np, "ti,spi-wdelay", &prop))
>  			spicfg->wdelay = (u8)prop;
>  		spi->controller_data = spicfg;
> +
> +		if (dspi->dma_rx && dspi->dma_tx)
> +			spicfg->io_type = SPI_IO_TYPE_DMA;
>  	}
>  
>  	return 0;

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

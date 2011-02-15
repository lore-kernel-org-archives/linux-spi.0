From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/8] intel_mid_ssp_spi: Re-introduce quirks fields
Date: Mon, 14 Feb 2011 22:21:30 -0700
Message-ID: <20110215052130.GB28029@angua.secretlab.ca>
References: <20110209100231.555.90520.stgit@bob.linux.org.uk>
 <20110209100713.555.65955.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: spi-devel-general@lists.sourceforge.net, russ.gorby@intel.com,
	linux-kernel@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110209100713.555.65955.stgit@bob.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Feb 09, 2011 at 10:07:30AM +0000, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> This adds the quirks field to the driver and the flags. We don't yet
> implement any of them so we don't confuse the driver.
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>

Other than minor point, looks fine.  Looks like it should be squashed
into patch #1.

g.

> ---
> 
>  drivers/spi/intel_mid_ssp_spi.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> 
> diff --git a/drivers/spi/intel_mid_ssp_spi.c b/drivers/spi/intel_mid_ssp_spi.c
> index 19c62bc..f201edd 100644
> --- a/drivers/spi/intel_mid_ssp_spi.c
> +++ b/drivers/spi/intel_mid_ssp_spi.c
> @@ -125,6 +125,15 @@ struct driver_data {
>  	/* SPI framework hookup */
>  	struct spi_master *master;
>  
> +	/* Chip specific quirks */
> +	int quirks;
> +#define QUIRKS_PLATFORM_MRST		1
> +#define QUIRKS_SRAM_ADDITIONAL_CPY	2
> +#define QUIRKS_USE_PM_QOS		4
> +#define QUIRKS_BIT_BANGING		8
> +#define QUIRKS_SPI_SLAVE_CLOCK_MODE	16
> +#define QUIRKS_PLATFORM_MDFL		32
> +
>  	/* SSP register addresses */
>  	unsigned long paddr;
>  	void __iomem *ioaddr;
> @@ -137,7 +146,6 @@ struct driver_data {
>  	u32 clear_sr;
>  	u32 mask_sr;
>  
> -

unrelated whitespace change.

>  	/* Current message transfer state info */
>  	struct tasklet_struct poll_transfer;
>  	struct spi_message *cur_msg;
> @@ -1163,6 +1171,7 @@ static int intel_mid_ssp_spi_probe(struct pci_dev *pdev,
>  	}
>  
>  	drv_data = spi_master_get_devdata(master);
> +	drv_data->quirks = ent->driver_data;
>  	drv_data->master = master;
>  	drv_data->pdev = pdev;
>  	drv_data->pwrstate = PWRSTATE_ON;
> 

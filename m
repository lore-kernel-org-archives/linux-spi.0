From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2] pxa2xx_spi: fix memory corruption
Date: Sun, 10 Jul 2011 14:43:41 +0200
Message-ID: <201107101443.42307.marek.vasut@gmail.com>
References: <201107100957.06377.marek.vasut@gmail.com>
	<1310299762-20079-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.infradead.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1310299762-20079-1-git-send-email-anarsoul@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Sunday, July 10, 2011 02:09:22 PM Vasily Khoruzhick wrote:
> pxa2xx_spi_probe allocates struct driver_data and null_dma_buf
> at same time via spi_alloc_master(), but then calculates
> null_dma_buf pointer incorrectly, and it causes memory corruption
> later if DMA usage is enabled.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
> v2: - add u8 __null_dma_buf[16] to the end of driver_data structure
>     and use it as null_dma_buf after alignment.
>     - use PTR_ALIGN instead of ALIGN
>  drivers/spi/pxa2xx_spi.c |    9 +++++----
>  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> index dc25bee..25358cd 100644
> --- a/drivers/spi/pxa2xx_spi.c
> +++ b/drivers/spi/pxa2xx_spi.c
> @@ -106,6 +106,7 @@ struct driver_data {
>  	int rx_channel;
>  	int tx_channel;
>  	u32 *null_dma_buf;
> +	u8 __null_dma_buf[16];

Ah, please don't name it starting with two underscores.
> 
>  	/* SSP register addresses */
>  	void __iomem *ioaddr;
> @@ -1543,8 +1544,8 @@ static int __devinit pxa2xx_spi_probe(struct
> platform_device *pdev) return -ENODEV;
>  	}
> 
> -	/* Allocate master with space for drv_data and null dma buffer */
> -	master = spi_alloc_master(dev, sizeof(struct driver_data) + 16);
> +	/* Allocate master with space for drv_data */
> +	master = spi_alloc_master(dev, sizeof(struct driver_data));
>  	if (!master) {
>  		dev_err(&pdev->dev, "cannot alloc spi_master\n");
>  		pxa_ssp_free(ssp);
> @@ -1569,8 +1570,8 @@ static int __devinit pxa2xx_spi_probe(struct
> platform_device *pdev) master->transfer = transfer;
> 
>  	drv_data->ssp_type = ssp->type;
> -	drv_data->null_dma_buf = (u32 *)ALIGN((u32)(drv_data +
> -						sizeof(struct driver_data)), 8);
> +	drv_data->null_dma_buf =
> +		(u32 *)PTR_ALIGN((u8 *)drv_data->__null_dma_buf, 8);

Do you need that (u8 *) cast there ?

#define PTR_ALIGN(p, a)         ((typeof(p))ALIGN((unsigned long)(p), (a)))

from linux/kernel.h line 42
> 
>  	drv_data->ioaddr = ssp->mmio_base;
>  	drv_data->ssdr_physical = ssp->phys_base + SSDR;

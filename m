From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] pxa2xx_spi: fix memory corruption
Date: Sun, 10 Jul 2011 01:05:48 +0200
Message-ID: <201107100105.48168.marek.vasut@gmail.com>
References: <1310246098-21208-1-git-send-email-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Vasily Khoruzhick <anarsoul@gmail.com>,
	spi-devel-general@lists.sourceforge.net, Eric Miao <eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1310246098-21208-1-git-send-email-anarsoul@gmail.com>
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

On Saturday, July 09, 2011 11:14:58 PM Vasily Khoruzhick wrote:
> pxa2xx_spi_probe allocates struct driver_data and null_dma_buf
> at same time via spi_alloc_master(), but then calculates
> null_dma_buf pointer incorrectly, and it causes memory corruption
> later if DMA usage is enabled.
> 
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  drivers/spi/pxa2xx_spi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/pxa2xx_spi.c b/drivers/spi/pxa2xx_spi.c
> index dc25bee..ef38fbf 100644
> --- a/drivers/spi/pxa2xx_spi.c
> +++ b/drivers/spi/pxa2xx_spi.c
> @@ -1569,7 +1569,7 @@ static int __devinit pxa2xx_spi_probe(struct
> platform_device *pdev) master->transfer = transfer;
> 
>  	drv_data->ssp_type = ssp->type;
> -	drv_data->null_dma_buf = (u32 *)ALIGN((u32)(drv_data +
> +	drv_data->null_dma_buf = (u32 *)ALIGN(((u32)drv_data +
>  						sizeof(struct driver_data)), 8);

This thing looks a bit disturbing in itself. Like, where the heck is that thing 
pointing in the end ? Since some data are written to address in "null_dma_buf" 
... isn't this just changing the corruption impact ?
> 
>  	drv_data->ioaddr = ssp->mmio_base;

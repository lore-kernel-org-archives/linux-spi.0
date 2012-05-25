From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: Change FIFO flush operation and spi channel off
Date: Fri, 25 May 2012 16:57:06 -0600
Message-ID: <20120525225706.10F1E3E092A@localhost>
References: <009f01cd38df$c00cf6f0$4026e4d0$%kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: 'Kukjin Kim' <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Kyoungil Kim' <ki0351.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: Kyoungil Kim <ki0351.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <009f01cd38df$c00cf6f0$4026e4d0$%kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 23 May 2012 21:29:51 +0900, Kyoungil Kim <ki0351.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Setting SW_RST does TX/RX FIFO flush.
> After FIFO flush, SW_RST should be cleared.
> The above setting and clearing SW_RST operation should be done after spi channel off.
> 
> Signed-off-by: Kyoungil Kim <ki0351.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-s3c64xx.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 972a94c..293f097 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -191,6 +191,10 @@ static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>  	writel(0, regs + S3C64XX_SPI_PACKET_CNT);
>  
>  	val = readl(regs + S3C64XX_SPI_CH_CFG);
> +	val &= ~(S3C64XX_SPI_CH_RXCH_ON | S3C64XX_SPI_CH_TXCH_ON);
> +	writel(val, regs + S3C64XX_SPI_CH_CFG);
> +
> +	val = readl(regs + S3C64XX_SPI_CH_CFG);
>  	val |= S3C64XX_SPI_CH_SW_RST;
>  	val &= ~S3C64XX_SPI_CH_HS_EN;
>  	writel(val, regs + S3C64XX_SPI_CH_CFG);
> @@ -224,10 +228,6 @@ static void flush_fifo(struct s3c64xx_spi_driver_data *sdd)
>  	val = readl(regs + S3C64XX_SPI_MODE_CFG);
>  	val &= ~(S3C64XX_SPI_MODE_TXDMA_ON | S3C64XX_SPI_MODE_RXDMA_ON);
>  	writel(val, regs + S3C64XX_SPI_MODE_CFG);
> -
> -	val = readl(regs + S3C64XX_SPI_CH_CFG);
> -	val &= ~(S3C64XX_SPI_CH_RXCH_ON | S3C64XX_SPI_CH_TXCH_ON);
> -	writel(val, regs + S3C64XX_SPI_CH_CFG);
>  }
>  
>  static void s3c64xx_spi_dmacb(void *data)
> -- 
> 1.7.1
> 
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/

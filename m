From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: bcm63xx: set master driver mode_bits.
Date: Fri, 27 Apr 2012 11:19:24 -0600
Message-ID: <20120427171924.181503E0B4D@localhost>
References: <1334929056-1598-1-git-send-email-florian@openwrt.org>
	<1334929056-1598-4-git-send-email-florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1334929056-1598-4-git-send-email-florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 20 Apr 2012 15:37:35 +0200, Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> wrote:
> We were not properly advertising the MODE bits supported by this driver, fix
> that.
> 
> Signed-off-by: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>

Applied, thanks.

g.
> ---
>  drivers/spi/spi-bcm63xx.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
> index 80e5ed3..7491971 100644
> --- a/drivers/spi/spi-bcm63xx.c
> +++ b/drivers/spi/spi-bcm63xx.c
> @@ -404,6 +404,7 @@ static int __devinit bcm63xx_spi_probe(struct platform_device *pdev)
>  	master->prepare_transfer_hardware = bcm63xx_spi_prepare_transfer;
>  	master->unprepare_transfer_hardware = bcm63xx_spi_unprepare_transfer;
>  	master->transfer_one_message = bcm63xx_spi_transfer_one;
> +	master->mode_bits = MODEBITS;
>  	bs->speed_hz = pdata->speed_hz;
>  	bs->tx_io = (u8 *)(bs->regs + bcm63xx_spireg(SPI_MSG_DATA));
>  	bs->rx_io = (const u8 *)(bs->regs + bcm63xx_spireg(SPI_RX_DATA));
> -- 
> 1.7.5.4
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

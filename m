From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: spi-mpc52xx.c: Init bus_num to 0 as this driver only
	supports one bus
Date: Thu, 06 Dec 2012 14:37:20 +0000
Message-ID: <20121206143720.3345F3E0948@localhost>
References: <1353924587-31339-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1353924587-31339-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 26 Nov 2012 11:09:47 +0100, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org> wrote:
> By setting bus_num to 0 the resulting device is named "spi0". Otherwise
> the name was "spi32766" (dynamic numbering) which was a bit confusing.
> 
> Using 0 is correct as this driver (and the MPC5200 SPI controller) only
> supports one SPI bus.

But the chip has multiple SPI busses. If the psc spi bus gets probed
first, then there will be a number conflict.

g.

> 
> Signed-off-by: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
> Cc: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
> Cc: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
> ---
>  drivers/spi/spi-mpc52xx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
> index 0454106..b40370c 100644
> --- a/drivers/spi/spi-mpc52xx.c
> +++ b/drivers/spi/spi-mpc52xx.c
> @@ -438,6 +438,9 @@ static int __devinit mpc52xx_spi_probe(struct platform_device *op)
>  	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LSB_FIRST;
>  	master->dev.of_node = op->dev.of_node;
>  
> +	/* Only one SPI bus from this driver possible */
> +	master->bus_num = 0;
> +
>  	dev_set_drvdata(&op->dev, master);
>  
>  	ms = spi_master_get_devdata(master);
> -- 
> 1.8.0
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d

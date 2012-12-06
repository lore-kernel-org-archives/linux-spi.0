From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2] spi: sh-hspi: Improve performance
Date: Thu, 06 Dec 2012 14:34:21 +0000
Message-ID: <20121206143421.603383E0948@localhost>
References: <20121123095137.7DBB03E07BE@localhost>
	<1353681984-15850-1-git-send-email-phil.edworthy@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Phil Edworthy <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Phil Edworthy <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1353681984-15850-1-git-send-email-phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 23 Nov 2012 14:46:24 +0000, Phil Edworthy <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> The driver attempts to read the received data immediately after
> writing to the transmit buffer. If no data is available, the driver
> currently waits 20ms until trying again. Since the hardware needs
> to shift out the transmitted data, the first poll always fails,
> leading to 20ms delay between bytes.
> 
> This patch waits for the time it takes to transmit a byte before
> reading the received data.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
> v2:
>  Instead of replacing msleep(20) with udelay(1), this version now
>  calculates the time it takes to shift out a byte, and uses udelay or
>  ndelay for this time. After this it falls back to polling every 20ms
>  using msleep. The delay has an empirical element based on testing at
>  different speeds.
> 
>  drivers/spi/spi-sh-hspi.c |   25 +++++++++++++++++++++++++
>  1 files changed, 25 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
> index bc25419..407eac0 100644
> --- a/drivers/spi/spi-sh-hspi.c
> +++ b/drivers/spi/spi-sh-hspi.c
> @@ -53,6 +53,7 @@ struct hspi_priv {
>  	struct spi_master *master;
>  	struct device *dev;
>  	struct clk *clk;
> +	u32 actual_speed;
>  };
>  
>  /*
> @@ -168,6 +169,7 @@ static void hspi_hw_setup(struct hspi_priv *hspi,
>  	if (spi->mode & SPI_CPOL)
>  		spcr |= 1 << 6;
>  
> +	hspi->actual_speed = best_rate;
>  	dev_dbg(dev, "speed %d/%d\n", target_rate, best_rate);
>  
>  	hspi_write(hspi, SPCR, spcr);
> @@ -185,6 +187,8 @@ static int hspi_transfer_one_message(struct spi_master *master,
>  	int ret, i;
>  	unsigned int cs_change;
>  	const int nsecs = 50;
> +	u32 tx_us = 0;
> +	u32 tx_ns = 0;
>  
>  	dev_dbg(hspi->dev, "%s\n", __func__);
>  
> @@ -194,6 +198,23 @@ static int hspi_transfer_one_message(struct spi_master *master,
>  
>  		if (cs_change) {
>  			hspi_hw_setup(hspi, msg, t);
> +
> +			/* Calculate time to shift out 8 bits & get rx data.
> +			 * The values of 8x, 9x & 11x are empirically derived,
> +			 * using a scope to check that we haven't dropped in
> +			 * a 20ms delay between bytes.
> +			 * If delay is >1ms, poll using msleep so we don't
> +			 * block.
> +			 */
> +			tx_us = 0;
> +			tx_ns = 0;
> +			if (hspi->actual_speed > 1000000)
> +				tx_ns = 8*1000000/(hspi->actual_speed/1000);
> +			else if (hspi->actual_speed > 100000)
> +				tx_ns = 9*1000000/(hspi->actual_speed/1000);
> +			else if (hspi->actual_speed > 1000)
> +				tx_us = 11*1000000/hspi->actual_speed;
> +
>  			hspi_hw_cs_enable(hspi);
>  			ndelay(nsecs);

This is still just busywaiting. Which means just burning CPU cycles
unconditionally even if it does finish early.

Instead of doing nothing, it is actually a whole lot better to use a
small delay and check if there is stuff to do frequently than it is to
try and delay for the entire duration. Due to the way this driver is
architected, nothing else can use the CPU during the delay().

What would really be better is to load up the fifo and full as it will
go and then rely on IRQs to tell the driver when it becomes ready to
fill with more data.

g.


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d

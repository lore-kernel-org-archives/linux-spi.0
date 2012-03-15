From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/fsl-espi: Make sure pm is within 2..32
Date: Thu, 15 Mar 2012 15:15:59 -0600
Message-ID: <20120315211559.9CED93E04E5@localhost>
References: <1331833352-15058-1-git-send-email-bigeasy@linutronix.de>
	<1331833352-15058-2-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1331833352-15058-2-git-send-email-bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 15 Mar 2012 18:42:32 +0100, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:
> The reference manual says that pm has to stay within 2 and 32. So the
> lowest frequency is 32 and DIV16 set, the highest is 2 and DIV16 unset.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-fsl-espi.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
> index 43350f9..7523a24 100644
> --- a/drivers/spi/spi-fsl-espi.c
> +++ b/drivers/spi/spi-fsl-espi.c
> @@ -182,16 +182,18 @@ static int fsl_espi_setup_transfer(struct spi_device *spi,
>  		cs->hw_mode |= CSMODE_DIV16;
>  		pm = DIV_ROUND_UP(mpc8xxx_spi->spibrg, hz * 16 * 4);
>  
> -		WARN_ONCE(pm > 16, "%s: Requested speed is too low: %d Hz. "
> +		WARN_ONCE(pm > 33, "%s: Requested speed is too low: %d Hz. "
>  			  "Will use %d Hz instead.\n", dev_name(&spi->dev),
> -			  hz, mpc8xxx_spi->spibrg / 1024);
> -		if (pm > 16)
> -			pm = 16;
> +				hz, mpc8xxx_spi->spibrg / (4 * 16 * (32 + 1)));
> +		if (pm > 33)
> +			pm = 33;
>  	} else {
>  		pm = DIV_ROUND_UP(mpc8xxx_spi->spibrg, hz * 4);
>  	}
>  	if (pm)
>  		pm--;
> +	if (pm < 2)
> +		pm = 2;
>  
>  	cs->hw_mode |= CSMODE_PM(pm);
>  
> -- 
> 1.7.9.1
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure

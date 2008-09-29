From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] The of_register_spi_devices()
	was	not called after registering the spi master.
Date: Mon, 29 Sep 2008 08:12:30 -0600
Message-ID: <20080929141230.GA9448@secretlab.ca>
References: <1222417480-3144-1-git-send-email-sbabic@denx.de>
	<1222417480-3144-2-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: sbabic-ynQEQJNshbs@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1222417480-3144-2-git-send-email-sbabic-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Sep 26, 2008 at 10:24:40AM +0200, sbabic-ynQEQJNshbs@public.gmane.org wrote:
> From: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
> 
> Signed-off-by: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>

One comment below.

> ---
>  drivers/spi/mpc52xx_psc_spi.c |   16 +++++++++++++---
>  1 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
> index 25eda71..5d233e7 100644
> --- a/drivers/spi/mpc52xx_psc_spi.c
> +++ b/drivers/spi/mpc52xx_psc_spi.c
> @@ -545,8 +550,13 @@ static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
>  		id = *psc_nump + 1;
>  	}
>  
> -	return mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
> -					irq_of_parse_and_map(op->node, 0), id);
> +	if ((ret = mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
> +					irq_of_parse_and_map(op->node, 0), id)))
> +		return ret;

Preferred form is:

	ret = mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
					irq_of_parse_and_map(op->node, 0), id);
	if (ret)
		return ret;

Burying the assignment inside the if() makes the code harder to read and
understand.

Otherwise, this looks right to me.

Thanks,
g.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

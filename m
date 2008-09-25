From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: Fwd: [PATCH] The
	of_register_spi_devices()	was not called after registering
	the spi master.
Date: Thu, 25 Sep 2008 10:16:57 -0600
Message-ID: <20080925161657.GA15138@secretlab.ca>
References: <200809242257.13832.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Resent-Message-ID: <20080925161900.GA16005-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200809242257.13832.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 24, 2008 at 10:57:13PM -0700, David Brownell wrote:
> From: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
> 

Patch is missing a description of why it is needed.  I may understand
it, but will the next person?

> Signed-off-by: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>

Also, some trivial whitespace irregularities in this patch, but otherwise...

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> ---
>  drivers/spi/mpc52xx_psc_spi.c |   14 ++++++++++++--
>  1 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
> index 25eda71..41f9921 100644
> --- a/drivers/spi/mpc52xx_psc_spi.c
> +++ b/drivers/spi/mpc52xx_psc_spi.c
> @@ -18,6 +18,7 @@
>  
>  #if defined(CONFIG_PPC_MERGE)
>  #include <linux/of_platform.h>
> +#include <linux/of_spi.h>
>  #else
>  #include <linux/platform_device.h>
>  #endif
> @@ -439,8 +440,10 @@ static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
>  	}
>  
>  	ret = spi_register_master(master);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err(dev,"spi_register_master FAILED\n");

need space after ','

>  		goto unreg_master;
> +	}
>  
>  	return ret;
>  
> @@ -524,6 +527,8 @@ static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
>  	const u32 *regaddr_p;
>  	u64 regaddr64, size64;
>  	s16 id = -1;
> +	struct spi_master *master;
> +	int ret;
>  
>  	regaddr_p = of_get_address(op->node, 0, &size64, NULL);
>  	if (!regaddr_p) {
> @@ -545,8 +550,13 @@ static int __init mpc52xx_psc_spi_of_probe(struct of_device *op,
>  		id = *psc_nump + 1;
>  	}
>  
> -	return mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
> +	ret=mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,

need space both before and after '='.

>  					irq_of_parse_and_map(op->node, 0), id);
> +	if (ret==0)  {
> +		master=spi_busnum_to_master(id);

Again, need space before and after '=' and '=='

Personally, I'd do this logic the other way around by putting
of_register_spi_devices() in the main flow of code and go on an abort
path if mpc52xx_psc_spi_do_probe() != 0; but I'm not concerned enough
about it to care or withhold my ack.

> +		of_register_spi_devices(master, op->node);
> +	}
> +	return(ret);
>  }
>  
>  static int __exit mpc52xx_psc_spi_of_remove(struct of_device *op)
> -- 
> 1.5.4.3
> 
> 
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
> 
> 
> -------------------------------------------------------

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/

From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/bitbang: check for setup_transfer during
	initialization
Date: Tue, 15 Feb 2011 15:06:42 -0700
Message-ID: <20110215220642.GE28005@angua.secretlab.ca>
References: <1297158375-25528-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1297158375-25528-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Feb 08, 2011 at 10:46:14AM +0100, Uwe Kleine-K=F6nig wrote:
> From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> =

> setup_transfer is mandatory if spi_bitbang_transfer is used, so
> check for it during initialization and not each time during runtime.
> =

> Signed-off-by: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi_bitbang.c |   13 ++++---------
>  1 files changed, 4 insertions(+), 9 deletions(-)
> =

> diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
> index 8b55724..14a63f6 100644
> --- a/drivers/spi/spi_bitbang.c
> +++ b/drivers/spi/spi_bitbang.c
> @@ -259,10 +259,6 @@ static void bitbang_work(struct work_struct *work)
>  	struct spi_bitbang	*bitbang =3D
>  		container_of(work, struct spi_bitbang, work);
>  	unsigned long		flags;
> -	int			(*setup_transfer)(struct spi_device *,
> -					struct spi_transfer *);
> -
> -	setup_transfer =3D bitbang->setup_transfer;
>  =

>  	spin_lock_irqsave(&bitbang->lock, flags);
>  	bitbang->busy =3D 1;
> @@ -300,11 +296,7 @@ static void bitbang_work(struct work_struct *work)
>  =

>  			/* init (-1) or override (1) transfer params */
>  			if (do_setup !=3D 0) {
> -				if (!setup_transfer) {
> -					status =3D -ENOPROTOOPT;
> -					break;
> -				}
> -				status =3D setup_transfer(spi, t);
> +				status =3D bitbang->setup_transfer(spi, t);
>  				if (status < 0)
>  					break;
>  				if (do_setup =3D=3D -1)
> @@ -465,6 +457,9 @@ int spi_bitbang_start(struct spi_bitbang *bitbang)
>  		}
>  	} else if (!bitbang->master->setup)
>  		return -EINVAL;
> +	if (bitbang->master->transfer =3D=3D spi_bitbang_transfer &&
> +			!bitbang->setup_transfer)
> +		return -EINVAL;
>  =

>  	/* this task is the only thing to touch the SPI bits */
>  	bitbang->busy =3D 0;
> -- =

> 1.7.2.3
> =

> =

> -------------------------------------------------------------------------=
-----
> The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
> Pinpoint memory and threading errors before they happen.
> Find and fix more than 250 security defects in the development cycle.
> Locate bottlenecks in serial and parallel code that limit performance.
> http://p.sf.net/sfu/intel-dev2devfeb
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

---------------------------------------------------------------------------=
---
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb

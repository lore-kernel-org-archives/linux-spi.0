From: "eric miao" <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: fix list scan success
	verification in PXA ssp driver
Date: Thu, 5 Jun 2008 16:54:44 +0800
Message-ID: <f17812d70806050154u90fe08cu5ac1e29dbb2ae4d4@mail.gmail.com>
References: <Pine.LNX.4.64.0806051027340.6598@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, eric miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	ARM Linux <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
To: "Guennadi Liakhovetski" <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0806051027340.6598-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Content-Disposition: inline
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

Acked-by: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

And this should really go through the ARM tree, please submit the
patch to RMK's patch system. Thanks.

(I have to send this again through my gmail account, please ignore the
other copy if any,
sorry for this)

On Thu, Jun 5, 2008 at 4:37 PM, Guennadi Liakhovetski
<g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> The list search success check in arch/arm/mach-pxa/ssp.c is wrong: for
> example, it didn't recognise failure for me when I requested port 0.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
>
> ---
>
>  arch/arm/mach-pxa/ssp.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-2.6/arch/arm/mach-pxa/ssp.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-pxa/ssp.c      2008-06-04 12:11:26.000000000 +0200
> +++ linux-2.6/arch/arm/mach-pxa/ssp.c   2008-06-04 12:11:50.000000000 +0200
> @@ -330,7 +330,7 @@
>
>        mutex_unlock(&ssp_lock);
>
> -       if (ssp->port_id != port)
> +       if (&ssp->node == &ssp_list)
>                return NULL;
>
>        return ssp;
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>



-- 
Cheers
- eric

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php

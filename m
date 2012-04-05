From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: use module_pci_driver
Date: Thu, 05 Apr 2012 10:19:16 -0700
Message-ID: <20120405171916.134173E044B@localhost>
References: <1333549772.5856.3.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1333549772.5856.3.camel@phoenix>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 04 Apr 2012 22:29:32 +0800, Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> This patch converts the drivers in drivers/spi/* to use module_pci_driver()
> macro which makes the code smaller and a bit simpler.
> 
> Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-dw-pci.c     |   13 +------------
>  drivers/spi/spi-pxa2xx-pci.c |   12 +-----------
>  2 files changed, 2 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
> index 14f7cc9..ff81abb 100644
> --- a/drivers/spi/spi-dw-pci.c
> +++ b/drivers/spi/spi-dw-pci.c
> @@ -164,18 +164,7 @@ static struct pci_driver dw_spi_driver = {
>  	.resume	=	spi_resume,
>  };
>  
> -static int __init mrst_spi_init(void)
> -{
> -	return pci_register_driver(&dw_spi_driver);
> -}
> -
> -static void __exit mrst_spi_exit(void)
> -{
> -	pci_unregister_driver(&dw_spi_driver);
> -}
> -
> -module_init(mrst_spi_init);
> -module_exit(mrst_spi_exit);
> +module_pci_driver(dw_spi_driver);
>  
>  MODULE_AUTHOR("Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
>  MODULE_DESCRIPTION("PCI interface driver for DW SPI Core");
> diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
> index 3fb44af..9f6ba34 100644
> --- a/drivers/spi/spi-pxa2xx-pci.c
> +++ b/drivers/spi/spi-pxa2xx-pci.c
> @@ -164,17 +164,7 @@ static struct pci_driver ce4100_spi_driver = {
>  	.remove         = __devexit_p(ce4100_spi_remove),
>  };
>  
> -static int __init ce4100_spi_init(void)
> -{
> -	return pci_register_driver(&ce4100_spi_driver);
> -}
> -module_init(ce4100_spi_init);
> -
> -static void __exit ce4100_spi_exit(void)
> -{
> -	pci_unregister_driver(&ce4100_spi_driver);
> -}
> -module_exit(ce4100_spi_exit);
> +module_pci_driver(ce4100_spi_driver);
>  
>  MODULE_DESCRIPTION("CE4100 PCI-SPI glue code for PXA's driver");
>  MODULE_LICENSE("GPL v2");
> -- 
> 1.7.5.4
> 
> 
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev

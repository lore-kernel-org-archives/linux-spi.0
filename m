From: Paul Gortmaker <paul.gortmaker-CWA4WttNNZF54TAoqtyWWQ@public.gmane.org>
Subject: Re: [PATCH] spi: nuc900: Include linux/module.h
Date: Wed, 23 Nov 2011 22:16:19 -0500
Message-ID: <20111124031619.GC10880@windriver.com>
References: <1322104251.16201.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Grant
To: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1322104251.16201.8.camel@phoenix>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

[[PATCH] spi: nuc900: Include linux/module.h] On 24/11/2011 (Thu 11:10) Axel Lin wrote:

> Include linux/module.h to fix below build error:

Looks fine to me ; I'll assume that this is going upstream via the
nuc900 maintainer since the module split up is old news at this point
in time.

Thanks,
Paul.

> 
>   CC      drivers/spi/spi-nuc900.o
> drivers/spi/spi-nuc900.c:484: error: 'THIS_MODULE' undeclared here (not in a function)
> drivers/spi/spi-nuc900.c:489: error: expected declaration specifiers or '...' before string constant
> drivers/spi/spi-nuc900.c:489: warning: data definition has no type or storage class
> drivers/spi/spi-nuc900.c:489: warning: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
> drivers/spi/spi-nuc900.c:489: warning: function declaration isn't a prototype
> drivers/spi/spi-nuc900.c:490: error: expected declaration specifiers or '...' before string constant
> drivers/spi/spi-nuc900.c:490: warning: data definition has no type or storage class
> drivers/spi/spi-nuc900.c:490: warning: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
> drivers/spi/spi-nuc900.c:490: warning: function declaration isn't a prototype
> drivers/spi/spi-nuc900.c:491: error: expected declaration specifiers or '...' before string constant
> drivers/spi/spi-nuc900.c:491: warning: data definition has no type or storage class
> drivers/spi/spi-nuc900.c:491: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
> drivers/spi/spi-nuc900.c:491: warning: function declaration isn't a prototype
> drivers/spi/spi-nuc900.c:492: error: expected declaration specifiers or '...' before string constant
> drivers/spi/spi-nuc900.c:492: warning: data definition has no type or storage class
> drivers/spi/spi-nuc900.c:492: warning: type defaults to 'int' in declaration of 'MODULE_ALIAS'
> drivers/spi/spi-nuc900.c:492: warning: function declaration isn't a prototype
> make[2]: *** [drivers/spi/spi-nuc900.o] Error 1
> make[1]: *** [drivers/spi] Error 2
> make: *** [drivers] Error 2
> 
> Signed-off-by: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-nuc900.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/spi/spi-nuc900.c b/drivers/spi/spi-nuc900.c
> index 21c70b2..182e9c8 100644
> --- a/drivers/spi/spi-nuc900.c
> +++ b/drivers/spi/spi-nuc900.c
> @@ -8,6 +8,7 @@
>   *
>   */
>  
> +#include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/spinlock.h>
>  #include <linux/workqueue.h>
> -- 
> 1.7.5.4
> 
> 
> 

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d

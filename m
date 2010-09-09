From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] SPI: move PL022 probe call to subsys_initcall()
Date: Wed, 8 Sep 2010 22:53:44 -0600
Message-ID: <20100909045344.GC11833@angua.secretlab.ca>
References: <1283763732-19419-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lukasz Baj <lukasz.baj-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
To: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1283763732-19419-1-git-send-email-linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Sep 06, 2010 at 11:02:12AM +0200, Linus Walleij wrote:
> The PL022 SPI bus is sometimes used for early stuff like
> regulators that need to be present at module_init() time, so
> we move this to a subsys_initcall().
> 
> Cc: Lukasz Baj <lukasz.baj-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org>
> Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>

Applied, thanks.

Note on the subject line:  The preferred form for spi patches is:

    spi[/chip]: <description>

'spi' in the header and the optional driver name are both lowercase.
I fix patches up to match this form, but it is less work for me when I
don't have to.

g.

> ---
>  drivers/spi/amba-pl022.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 3db5402..f958072 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -2324,7 +2324,7 @@ static int __init pl022_init(void)
>  	return amba_driver_register(&pl022_driver);
>  }
>  
> -module_init(pl022_init);
> +subsys_initcall(pl022_init);
>  
>  static void __exit pl022_exit(void)
>  {
> -- 
> 1.6.3.3
> 

------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd

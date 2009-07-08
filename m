From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 29/44] includecheck fix: drivers/spi, amba-pl022.c
Date: Wed, 8 Jul 2009 10:39:44 -0700
Message-ID: <200907081039.44665.david-b@pacbell.net>
References: <1247063308.4382.12.camel@ht.satnam> <1247067147.4382.80.camel@ht.satnam>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	Sam Ravnborg <sam@ravnborg.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Jaswinder Singh Rajput <jaswinder@kernel.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756777AbZGHRjw@vger.kernel.org>
In-Reply-To: <1247067147.4382.80.camel@ht.satnam>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 08 July 2009, Jaswinder Singh Rajput wrote:
> 
> fix the following 'make includecheck' warnings:
> 
>   drivers/spi/amba-pl022.c: linux/delay.h is included more than once.
>   drivers/spi/amba-pl022.c: linux/errno.h is included more than once.
> 
> Signed-off-by: Jaswinder Singh Rajput <jaswinderrajput@gmail.com>

Acked-by: David Brownell <dbrownell@users.sourceforge.net>


> ---
>  drivers/spi/amba-pl022.c |    2 --
>  1 files changed, 0 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index da76797..c0f950a 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -38,14 +38,12 @@
>  #include <linux/interrupt.h>
>  #include <linux/spi/spi.h>
>  #include <linux/workqueue.h>
> -#include <linux/errno.h>
>  #include <linux/delay.h>
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/amba/bus.h>
>  #include <linux/amba/pl022.h>
>  #include <linux/io.h>
> -#include <linux/delay.h>
>  
>  /*
>   * This macro is used to define some register default values.
> -- 
> 1.6.0.6
> 
> 
> 
> 

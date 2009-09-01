From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [patch 2.6.31-rc7] spi: Freescale STMP
	driver
Date: Tue, 1 Sep 2009 13:51:12 -0700
Message-ID: <20090901135112.58f50b30.akpm@linux-foundation.org>
References: <200908271847.43226.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200908271847.43226.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 27 Aug 2009 18:47:42 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> Subject: [PATCH] Freescale STMP spi driver, revised
> From: dmitry pervushin <dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
> Date: Wed, 03 Jun 2009 20:15:46 +0400
> 
> Add SPI driver for Freescale STMP 3xxx-based boards
> 
> [dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org: cleanup sequence, spi_unregister_master]
> 

Does "freescale" have a maintainer?  Me no understand it.

> +#define busy_wait(cond)							\
> +	({								\
> +	unsigned long end_jiffies = jiffies + STMP_SPI_TIMEOUT;		\
> +	bool succeeded = false;						\
> +	do {								\
> +		if (cond) {						\
> +			succeeded = true;				\
> +			break;						\
> +		}							\
> +		cpu_relax();						\
> +	} while (time_before(end_jiffies, jiffies));			\
> +	succeeded;							\
> +	})

Oh dear.

> +/**
> + * stmp_spi_init_hw
> + * Initialize the SSP port
> + */

The /** token indicates that the comment is in kerneldoc form.  But
this comment lacks all the stuff one would expect to see in a kerneldoc
comment.

>
> ...
>

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july

From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: [driver-core:driver-core-next 94/95]
	drivers/spi/spi-atmel.c:1007: warning: 'atmel_spi_remove' defined but
	not used
Date: Fri, 30 Nov 2012 15:42:41 -0800
Message-ID: <20121130234241.GB17353@kroah.com>
References: <50b92871.ZZQqcIsuQCqNwWDs%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <50b92871.ZZQqcIsuQCqNwWDs%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Dec 01, 2012 at 05:43:13AM +0800, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-next
> head:   92e9e6d1f9844b73a26215025a922e7d7aeae361
> commit: 78d86c213f28193082b5d8a1a424044b7ba406f1 [94/95] init.h: Remove __dev* sections from the kernel
> config: make ARCH=avr32 atngw100_defconfig
> 
> All warnings:
> 
> In file included from include/uapi/linux/param.h:4,
>                  from include/linux/timex.h:63,
>                  from include/linux/jiffies.h:8,
>                  from include/linux/ktime.h:25,
>                  from include/linux/timer.h:5,
>                  from include/linux/workqueue.h:8,
>                  from include/linux/srcu.h:32,
>                  from include/linux/notifier.h:15,
>                  from include/linux/clk.h:17,
>                  from drivers/spi/spi-atmel.c:13:
> arch/avr32/include/asm/param.h:6:1: warning: "HZ" redefined
> In file included from arch/avr32/include/asm/param.h:4,
>                  from include/uapi/linux/param.h:4,
>                  from include/linux/timex.h:63,
>                  from include/linux/jiffies.h:8,
>                  from include/linux/ktime.h:25,
>                  from include/linux/timer.h:5,
>                  from include/linux/workqueue.h:8,
>                  from include/linux/srcu.h:32,
>                  from include/linux/notifier.h:15,
>                  from include/linux/clk.h:17,
>                  from drivers/spi/spi-atmel.c:13:
> arch/avr32/include/uapi/asm/param.h:6:1: warning: this is the location of the previous definition
> drivers/spi/spi-atmel.c:1007: warning: 'atmel_spi_remove' defined but not used

This is a bug, that should be __devexit_p() on that function, not
__exit_p().

greg k-h

greg k-h

------------------------------------------------------------------------------
Keep yourself connected to Go Parallel: 
TUNE You got it built. Now make it sing. Tune shows you how.
http://goparallel.sourceforge.net

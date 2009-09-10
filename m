From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] spi/spidev: remove BLK
Date: Thu, 10 Sep 2009 11:00:34 -0700
Message-ID: <200909101100.34332.david-b@pacbell.net>
References: <20090910130409.GA23433@Chamillionaire.breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090910130409.GA23433-N26foeg2n7CSQxDm3FYtNwe+0vtP5+jfMa5aj3AfGnc@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 10 September 2009, Sebastian Andrzej Siewior wrote:
> the BLK in open() is not required:
> - device_list is protected by device_list_lock
> - spidev->user is only access with device_list_lock locked
> - spidev->buffer is protected by spidev->buf_lock. Allocation & free is done
>   by the first/last user with device_list_lock locked.
> 
> Signed-off-by: Sebastian Andrzej Siewior <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>

In short:  revert 609f9e92b570f390a457a81effe0af6b758dc582
which was not needed (and ISTR that it got a NAK so why it's
in the tree is a puzzle).


> ---
>  drivers/spi/spidev.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index 606e7a4..f362c40 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -30,7 +30,6 @@
>  #include <linux/errno.h>
>  #include <linux/mutex.h>
>  #include <linux/slab.h>
> -#include <linux/smp_lock.h>
>  
>  #include <linux/spi/spi.h>
>  #include <linux/spi/spidev.h>
> @@ -477,7 +476,6 @@ static int spidev_open(struct inode *inode, struct file *filp)
>  	struct spidev_data	*spidev;
>  	int			status = -ENXIO;
>  
> -	lock_kernel();
>  	mutex_lock(&device_list_lock);
>  
>  	list_for_each_entry(spidev, &device_list, device_entry) {
> @@ -503,7 +501,6 @@ static int spidev_open(struct inode *inode, struct file *filp)
>  		pr_debug("spidev: nothing for minor %d\n", iminor(inode));
>  
>  	mutex_unlock(&device_list_lock);
> -	unlock_kernel();
>  	return status;
>  }
>  
> -- 
> 1.6.3.3
> 
> 



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july

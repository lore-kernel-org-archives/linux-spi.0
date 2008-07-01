From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH] spi: fix the read path in spidev
Date: Tue, 1 Jul 2008 13:07:08 -0700
Message-ID: <20080701130708.e8dd1b7d.akpm@linux-foundation.org>
References: <20080701154504.GA26219@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Sebastian Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080701154504.GA26219-Hfxr4Dq0UpYb1SvskN2V4Q@public.gmane.org>
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

On Tue, 1 Jul 2008 17:45:04 +0200
Sebastian Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:

> This got broken by the recent "fix rmmod $spi_driver while spidev-user is active".
> I tested the rmmod & write path but didn't check the read path. I am sorry.
> The read logic changed and spidev_sync_read() + spidev_sync_write() do not return
> zero on success anymore but the number of bytes that has been transfered over the
> bus.
> This patch changes the logic and copy_to_user() gets called again.
> 
> The write path returns the number of bytes which are written to the underlying device
> what may be less than the requested size. This patch makes the same change to the read
> path or else we request a read of 20 bytes, get 10, don't call copy to user and
> report to the user that we read 10 bytes.
> 

Looks OK.  I'll queue it for 2.6.26.

> 
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index 72282cd..60ec6f7 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -167,14 +167,14 @@ spidev_read(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
>  
>  	mutex_lock(&spidev->buf_lock);
>  	status = spidev_sync_read(spidev, count);
> -	if (status == 0) {
> +	if (status > 0) {

`status' is a poorly chosen identifier. But Iworked it out.


>  		unsigned long	missing;
>  
> -		missing = copy_to_user(buf, spidev->buffer, count);
> -		if (count && missing == count)
> +		missing = copy_to_user(buf, spidev->buffer, status);
> +		if (status && missing == status)

The test for status!=0 is unneeded - I'll remove it.

>  			status = -EFAULT;
>  		else
> -			status = count - missing;
> +			status = status - missing;
>  	}
>  	mutex_unlock(&spidev->buf_lock);
>  
> @@ -200,8 +200,6 @@ spidev_write(struct file *filp, const char __user *buf,
>  	missing = copy_from_user(spidev->buffer, buf, count);
>  	if (missing == 0) {
>  		status = spidev_sync_write(spidev, count);
> -		if (status == 0)
> -			status = count;
>  	} else
>  		status = -EFAULT;
>  	mutex_unlock(&spidev->buf_lock);
> -- 
> 1.5.5.2

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08

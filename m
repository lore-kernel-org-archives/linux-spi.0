From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: fix possible NULL dereference
Date: Fri, 11 Sep 2015 15:11:32 +0300
Message-ID: <55F2C4F4.3090704@linux.intel.com>
References: <1441883893-20596-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441883893-20596-1-git-send-email-sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi

On 09/10/2015 02:18 PM, Sudip Mukherjee wrote:
> During the last close we are freeing spidev if spidev->spi is NULL, but
> just before checking if spidev->spi is NULL we are dereferencing it.
> Lets add a check there to avoid the NULL dereference.
>
> Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
> ---
>   drivers/spi/spidev.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index fba92a5..ef008e5 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -651,7 +651,8 @@ static int spidev_release(struct inode *inode, struct file *filp)
>   		kfree(spidev->rx_buffer);
>   		spidev->rx_buffer = NULL;
>
> -		spidev->speed_hz = spidev->spi->max_speed_hz;
> +		if (spidev->spi)
> +			spidev->speed_hz = spidev->spi->max_speed_hz;
>
>   		/* ... after we unbound from the underlying device? */
>   		spin_lock_irq(&spidev->spi_lock);

Actually this fixes a *real* NULL dereference case but it is not related 
to normal open/close life cycle of spidev. It requires that spidev is 
kept open when SPI master is removed.

spidev->spi is set to NULL in spidev_remove() and it is called before 
spidev_release() in case master is removed while spidev is in use

It would be good to update this to commit log, add a tag below and Cc 
<stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Fixes: 9169051617df ("spi: spidev: Don't mangle max_speed_hz in 
underlying spi device")

You can add these too:

Reviewed-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Tested-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

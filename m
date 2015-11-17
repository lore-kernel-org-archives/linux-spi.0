From: Vegard Nossum <vegard.nossum-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Hold spi_lock over all defererences of spi
 in release()
Date: Tue, 17 Nov 2015 09:11:58 +0100
Message-ID: <564AE14E.1030008@oracle.com>
References: <1447689999-20632-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1447689999-20632-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 11/16/2015 05:06 PM, Mark Brown wrote:
> We use the spi_lock spinlock to protect against races between the device
> being removed and file operations on the spidev.  This means that in the
> removal path all references to the device need to be done under lock as
> in removal we dropping references to the device.
>
> Reported-by: Vegard Nossum <vegard.nossum-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>   drivers/spi/spidev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index 91a0fcd72423..d0e7dfc647cf 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -651,11 +651,11 @@ static int spidev_release(struct inode *inode, struct file *filp)
>   		kfree(spidev->rx_buffer);
>   		spidev->rx_buffer = NULL;
>
> +		spin_lock_irq(&spidev->spi_lock);
>   		if (spidev->spi)
>   			spidev->speed_hz = spidev->spi->max_speed_hz;
>
>   		/* ... after we unbound from the underlying device? */
> -		spin_lock_irq(&spidev->spi_lock);
>   		dofree = (spidev->spi == NULL);
>   		spin_unlock_irq(&spidev->spi_lock);
>
>

Thanks for the patch! We should probably add a stable CC too (since it
fixes "spi: spidev: fix possible NULL dereference" which went into stable):

Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>


Vegard
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Don't mangle max_speed_hz in underlying
 spi device
Date: Tue, 11 Nov 2014 07:53:59 -0600
Message-ID: <546214F7.1040007@opensource.altera.com>
References: <1415442589-29434-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415442589-29434-1-git-send-email-broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On 11/08/2014 04:29 AM, Mark Brown wrote:
> Currently spidev allows callers to set the default speed by overriding the
> max_speed_hz in the underlying device. This achieves the immediate goal but
> is not what devices expect and can easily lead to userspace trying to set
> unsupported speeds and succeeding, apart from anything else drivers can't
> set a limit on the speed using max_speed_hz as they'd expect and any other
> devices on the bus will be affected.
>
> Instead store the default speed in the spidev struct and fill this in on
> each transfer.
>
> Signed-off-by: Mark Brown<broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> ---
>
> I've not tested this at all yet.
>
>   drivers/spi/spidev.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
> index e50039f..42239fd 100644
> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -87,6 +87,7 @@ struct spidev_data {
>   	unsigned		users;
>   	u8			*tx_buffer;
>   	u8			*rx_buffer;
> +	u32			speed_hz;
>   };
>   
>   static LIST_HEAD(device_list);
> @@ -274,6 +275,8 @@ static int spidev_message(struct spidev_data *spidev,
>   		k_tmp->bits_per_word = u_tmp->bits_per_word;
>   		k_tmp->delay_usecs = u_tmp->delay_usecs;
>   		k_tmp->speed_hz = u_tmp->speed_hz;
> +		if (!k_tmp->speed_hz)
> +			k_tmp->speed_hz = spidev->speed_hz;
>   #ifdef VERBOSE
>   		dev_dbg(&spidev->spi->dev,
>   			"  xfer len %zd %s%s%s%dbits %u usec %uHz\n",
> @@ -377,7 +380,7 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   		retval = __put_user(spi->bits_per_word, (__u8 __user *)arg);
>   		break;
>   	case SPI_IOC_RD_MAX_SPEED_HZ:
> -		retval = __put_user(spi->max_speed_hz, (__u32 __user *)arg);
> +		retval = __put_user(spidev->speed_hz, (__u32 __user *)arg);
>   		break;
>   
>   	/* write requests */
> @@ -442,9 +445,10 @@ spidev_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>   			spi->max_speed_hz = tmp;
>   			retval = spi_setup(spi);
>   			if (retval < 0)
> -				spi->max_speed_hz = save;
> +				spidev->speed_hz = tmp;
>   			else
>   				dev_dbg(&spi->dev, "%d Hz (max)\n", tmp);
> +			spi->max_speed_hz = save;

I think the test should be if (retval >= 0) otherwise the value is only 
updated on an error. With this change, I was able to successfully change 
the SPI speed without affecting the max speed. This was tested using 
spidev_test.c on a Altera Cyclone V which includes the DesignWare SPI IP 
(spi-dw.c).

>   		}
>   		break;
>   
> @@ -570,6 +574,8 @@ static int spidev_release(struct inode *inode, struct file *filp)
>   		kfree(spidev->rx_buffer);
>   		spidev->rx_buffer = NULL;
>   
> +		spidev->speed_hz = spidev->spi->max_speed_hz;
> +
>   		/* ... after we unbound from the underlying device? */
>   		spin_lock_irq(&spidev->spi_lock);
>   		dofree = (spidev->spi == NULL);
> @@ -650,6 +656,8 @@ static int spidev_probe(struct spi_device *spi)
>   	}
>   	mutex_unlock(&device_list_lock);
>   
> +	spidev->speed_hz = spi->max_speed_hz;
> +
>   	if (status == 0)
>   		spi_set_drvdata(spi, spidev);
>   	else

The echo command calls spidev_write() directly. Although the speed can't 
be specified in the echo command, it did prompt me to look at that path.

In that case I think we'd need to add the .speed_hz element in 
spidev_sync_write() and spidev_sync_read().
struct spi_transfer    t = {
             .rx_buf        = spidev->rx_buffer,
             .len        = len,
             .speed_hz    = spidev->speed_hz,
         };
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH] spi: expose spi_master and spi_device statistics via
 sysfs
Date: Wed, 03 Jun 2015 13:25:58 +0200
Message-ID: <556EE446.3060407@metafoo.de>
References: <1432574909-2326-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432574909-2326-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 05/25/2015 07:28 PM, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>
> per spi-master statistics accessible as:
>    /sys/class/spi_master/spi*/statistics/
>
> per spi-device statistics accessible via:
>    /sys/class/spi_master/spi*/spi*.*/statistics/
>
> The following statistics are exposed as separate "files" inside
> these directories:
>    * messages		number of spi_messages
>    * transfers		number of spi_transfers
>    * bytes		number of bytes transferred
>    * bytes_rx		number of bytes transmitted
>    * bytes_tx		number of bytes received
>    * bytes_histo		transferred bytes/spi_transfer histogram

Having those kinds of stats in world readable files has serious security 
implications as they can be used to implement side-channel attacks. They 
should probably only be available in debugfs for root.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: devm_spi_register_master
Date: Fri, 22 Nov 2013 11:13:45 +0900
Message-ID: <000001cee728$78f73ca0$6ae5b5e0$%han@samsung.com>
References: <alpine.DEB.2.02.1311110935230.2300@hadrien>
 <002701cedf3b$19f5b280$4de11780$%han@samsung.com>
 <alpine.DEB.2.02.1311111915570.2321@hadrien>
 <000301cedf73$2ae7a3e0$80b6eba0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: 'Mark Brown' <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Julia Lawall' <julia.lawall-L2FTfq7BK8M@public.gmane.org>,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
To: 'Stephen Warren' <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <000301cedf73$2ae7a3e0$80b6eba0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday, November 12, 2013 3:48 PM, Jingoo Han wrote:
> Hi Mark,
> 
> By the way, now I am testing s3c64xx by repeating modprobe & rmmod.
> However, after s3c64xx_spi_remove() by rmmod, devm_spi_unregister()
> is not called. So, at the next calling modprobe, it makes kernel panic.
> On the other hand, When spi_unregister_master()& spi_master_put()
> are added, the kernel panic does not happen.

Hi Stephen Warren,

I tested your patch "spi: core: invert success test in
devm_spi_register_master" with spi-s3c64xx.ko.
I checked that the kernel panic is resolved.
Thank you for your patch. :-)

Best regards,
Jingoo Han

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

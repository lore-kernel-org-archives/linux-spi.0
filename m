From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH RFT] spi: qup: Get rid of using struct spi_qup_device
Date: Tue, 25 Feb 2014 09:29:26 +0200
Message-ID: <1393313366.6481.16.camel@iivanov-dev>
References: <1393254456.12394.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393254456.12394.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, 2014-02-24 at 23:07 +0800, Axel Lin wrote: 
> Current code uses struct spi_qup_device to store spi->mode and spi->chip_select
> settings. We can get these settings in spi_qup_transfer_one and spi_qup_set_cs
> without using struct spi_qup_device. Refactor the code a bit to remove
> spi_qup_setup(), spi_qup_cleanup(), and struct spi_qup_device.
> 
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
> Hi Ivan,
> I don't have this h/w, can you help testing if this patch works.

Thanks Alex. 

Tested-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>


> Thanks,
> Axel


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

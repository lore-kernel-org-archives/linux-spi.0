From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] mtd: m25p80: consider max message size in m25p80_read
Date: Tue, 29 Nov 2016 07:29:53 +0100
Message-ID: <bd0da0b0-c2a1-eade-3b27-407b3842182c@gmail.com>
References: <6c95366c-7fcc-ef4c-033a-f9f6e152a669@gmail.com>
 <20160816164204.GV9347@sirena.org.uk>
 <b65240ff-7e28-5ecb-0670-abfca871246b@gmail.com>
 <a5aad691-fb3b-39a5-943e-43068df74c44@gmail.com>
 <e2e4ecfe-b888-f335-57f6-634f5c818252@gmail.com>
 <0e38d1ed-af5c-160f-e02a-f1433c507d23@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0e38d1ed-af5c-160f-e02a-f1433c507d23-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Am 28.10.2016 um 07:58 schrieb Heiner Kallweit:
> Consider a message size limit when calculating the maximum amount
> of data that can be read.
> 
> The message size limit has been introduced with 4.9, so cc it
> to stable.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # 4.9.x
> ---
> v2:
> - This patch was part of a series and the other patches of the
>   series went into 4.9. It's needed to correctly support
>   reads > 64k on fsl-espi as first user of spi_max_message_size.
>   See commit 02a595d5d6e4 ("spi: fsl-espi: eliminate spi nor
>   flash read loop"). CC it to stable.  
> ---
>  drivers/mtd/devices/m25p80.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 9cf7fcd..16a7df2 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -172,7 +172,8 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
>  
>  	t[1].rx_buf = buf;
>  	t[1].rx_nbits = m25p80_rx_nbits(nor);
> -	t[1].len = min(len, spi_max_transfer_size(spi));
> +	t[1].len = min3(len, spi_max_transfer_size(spi),
> +			spi_max_message_size(spi) - t[0].len);
>  	spi_message_add_tail(&t[1], &m);
>  
>  	ret = spi_sync(spi, &m);
> 
This one is still open and there have been reports already from
people facing this issue. Can we still get it into 4.10 +
into 4.9 ?

Thanks

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] spi: sh-msiof: Fix DMA transfer size check
Date: Thu, 2 Nov 2017 10:36:24 +0100
Message-ID: <4ffdafd2-e81a-5fc8-54eb-765d768c202d@de.bosch.com>
References: <20171102093236.26082-1-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171102093236.26082-1-horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 02.11.2017 10:32, Simon Horman wrote:
> From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> 
> DMA supports 32-bit words only,
> even if BITLEN1 of SITMDR2 register is 16bit.
> 
> Fixes: b0d0ce8b6b91 ("spi: sh-msiof: Add DMA support")
> Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Simon Horman <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
> Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Acked-by: Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>

> ---
> v2
> * Added Geert's Ack
> 
> Sorry for letting this slip through the cracks, it appears
> to have been on my todo list for 1 year less 5 days.


Thanks for picking it :)

Best regards

Dirk

P.S.: The remaining msiof (DMA) patches are not forgotten, we are sill 
working on them (with low priority, though).


> ---
>   drivers/spi/spi-sh-msiof.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 2c5ea4c57508..94d15ef0e4e6 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -900,7 +900,7 @@ static int sh_msiof_transfer_one(struct spi_master *master,
>   				break;
>   			copy32 = copy_bswap32;
>   		} else if (bits <= 16) {
> -			if (l & 1)
> +			if (l & 3)
>   				break;
>   			copy32 = copy_wswap32;
>   		} else {
> 

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

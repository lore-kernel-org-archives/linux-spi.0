From: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: Re: [patch] spi: signedness bug in qspi_trigger_transfer_out_int()
Date: Fri, 03 Apr 2015 18:44:33 +0900
Message-ID: <551E6101.6060101@jinso.co.jp>
References: <20150403084527.GA27292@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150403084527.GA27292@mwanda>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,
On 2015=E5=B9=B404=E6=9C=8803=E6=97=A5 17:45, Dan Carpenter wrote:
> We need "ret" to be unsigned for the error handling to work.  The
> signedness of "i" and "n" don't matter but qspi_set_send_trigger()
> returns an int so I've changed them to int as well.
>
> Fixes: 4b6fe3edcbba ('spi: Using Trigger number to transmit/receive d=
ata')
> Signed-off-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
>
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index b3871d8..f6bac9e 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -727,7 +727,7 @@ static int rspi_rz_transfer_one(struct spi_master=
 *master,
>   static int qspi_trigger_transfer_out_int(struct rspi_data *rspi, co=
nst u8 *tx,
>   					u8 *rx, unsigned int len)
>   {
> -	unsigned int i, n, ret;
> +	int i, n, ret;
>   	int error;
>  =20
>   	while (len > 0) {
>
>
Thanks for your patch!

Best Regards,
Hiep.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

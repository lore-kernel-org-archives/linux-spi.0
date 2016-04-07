From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [LINUX PATCH v2 1/3] spi: Added dummy_cycle entry in the
 spi_transfer structure.
Date: Thu, 7 Apr 2016 17:02:44 +0200
Message-ID: <57067694.8030806@atmel.com>
References: <1460039969-9835-1-git-send-email-lakshmis@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Harini Katakam" <harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Anirudha Sarangi <anirudh-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	P L Sai Krishna <lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"R, Vignesh" <vigneshr-l0cyMroinI0@public.gmane.org>
To: P L Sai Krishna <lakshmi.sai.krishna.potthuri-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Javier Martinez Canillas" <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	"Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	Jagan Teki <jteki-oRp2ZoJdM/RWk0Htik3J/w@public.gmane.org>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1460039969-9835-1-git-send-email-lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi all,

Le 07/04/2016 16:39, P L Sai Krishna a =E9crit :
> This patch adds dummy_cycles entry in the spi_transfer structure.
> len field in the transfer structure contains dummy bytes along with
> actual data bytes, controllers which requires dummy bytes use len
> field and simply Ignore the dummy_cycles field. Controllers which
> expects dummy cycles won't work directly by using len field because
> host driver doesn't know that len field of a particular transfer
> includes dummy bytes or not (and also number of dummy bytes included
> in len field). In such cases host driver use this dummy_cycles field
> to identify the number of dummy cycles and based on that it will send
> the required number of dummy cycles.

Dummy cycles are only used with SPI NOR flashes, aren't they?
I guess so since there is also a patch dedicated to the m25p80 driver.

So why not using the spi_flash_read() API already introduced by Vignesh
in the SPI layer?

struct spi_flash_read_message already includes a 'dummy_bytes' member.

>=20
> Signed-off-by: P L Sai Krishna <lakshmis-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> ---
> v2:=20
>  - Changed the structure member name from dummy to dummy_cycles.
>  - Updated the documentation of dummy_cycles.
>  - m25p80 changes split into another patch.
>=20
>  include/linux/spi/spi.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 857a9a1..63135b3 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -664,6 +664,9 @@ extern void spi_res_release(struct spi_master *ma=
ster,
>   * @len: size of rx and tx buffers (in bytes)
>   * @speed_hz: Select a speed other than the device default for this
>   *      transfer. If 0 the default (from @spi_device) is used.
> + * @dummy_cycles: number of dummy cycles. If host controller require=
s
> + * 	dummy cycles rather than dummy bytes which send along with Cmd
> + *	and address then this dummy_cycles is used.
>   * @bits_per_word: select a bits_per_word other than the device defa=
ult
>   *      for this transfer. If 0 the default (from @spi_device) is us=
ed.
>   * @cs_change: affects chipselect after this transfer completes
> @@ -752,6 +755,7 @@ struct spi_transfer {
>  	u8		bits_per_word;
>  	u16		delay_usecs;
>  	u32		speed_hz;
> +	u32		dummy_cycles;
> =20
>  	struct list_head transfer_list;
>  };
>=20

Best regards,

Cyrille
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

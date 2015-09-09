From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH linux-next v6 1/8] mtd: spi-nor: read JEDEC ID with multiple I/O protocols
Date: Wed, 9 Sep 2015 15:59:40 +0200
Message-ID: <201509091559.40948.marex@denx.de>
References: <cover.1441803609.git.cyrille.pitchen@atmel.com> <735e22efa25f6529bf8ed4a709c18a719176714b.1441803609.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org,
	juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org, ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <735e22efa25f6529bf8ed4a709c18a719176714b.1441803609.git.cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday, September 09, 2015 at 03:24:11 PM, Cyrille Pitchen wrote:
> When their quad or dual I/O mode is enabled, Micron and Macronix spi-nor
> memories don't reply to the regular Read ID (0x9f) command. Instead they
> reply to a new dedicated command Read ID Multiple I/O (0xaf).
> 
> If the Read ID (0x9f) command fails (the read ID is all 1's or all 0's),
> then the Read ID Multiple I/O (0xaf) is used, first with SPI 4-4-4 protocol
> (supported by both Micron and Macronix memories), lately with SPI-2-2-2
> protocol (supported only by Micron memories).
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 28 +++++++++++++++++++++++++++-
>  include/linux/mtd/spi-nor.h   | 23 +++++++++++++++++++++--
>  2 files changed, 48 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index f59aedfe1462..80a0db078aaa 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -703,8 +703,9 @@ static const struct flash_info spi_nor_ids[] = {
> 
>  static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
>  {
> -	int			tmp;
> +	int			i, tmp;
>  	u8			id[SPI_NOR_MAX_ID_LEN];
> +	enum spi_protocol	proto[2] = {SPI_PROTO_4_4_4, SPI_PROTO_2_2_2};
>  	const struct flash_info	*info;
> 
>  	tmp = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
> @@ -713,6 +714,25 @@ static const struct flash_info *spi_nor_read_id(struct
> spi_nor *nor) return ERR_PTR(tmp);
>  	}
> 
> +	/* Special case for Micron/Macronix qspi nor. */
> +	for (i = 0; i < ARRAY_SIZE(proto); ++i) {
> +		if (!((id[0] == 0xff && id[1] == 0xff && id[2] == 0xff) ||
> +		      (id[0] == 0x00 && id[1] == 0x00 && id[2] == 0x00)))
> +			break;
> +
> +		nor->erase_proto = proto[i];
> +		nor->read_proto = proto[i];
> +		nor->write_proto = proto[i];
> +		nor->reg_proto = proto[i];
> +		tmp = nor->read_reg(nor, SPINOR_OP_MIO_RDID,
> +				    id, SPI_NOR_MAX_ID_LEN);
> +		if (tmp < 0) {
> +			dev_dbg(nor->dev,
> +				" error %d reading JEDEC ID (MULTI IO)\n", tmp);

Don't you have one space too much in front of the " error" ?

> +			return ERR_PTR(tmp);
> +		}
> +	}
> +
>  	for (tmp = 0; tmp < ARRAY_SIZE(spi_nor_ids) - 1; tmp++) {
>  		info = &spi_nor_ids[tmp];
>  		if (info->id_len) {

[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

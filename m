From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 4/4] mtd: m25p80: Enable Dual SPI read transfers for s25fl256s1 and s25fl512s
Date: Tue, 21 Jan 2014 16:42:55 +0100
Message-ID: <201401211642.55461.marex@denx.de>
References: <1390309159-19643-1-git-send-email-geert@linux-m68k.org> <1390309159-19643-5-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390309159-19643-5-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday, January 21, 2014 at 01:59:19 PM, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> 
> Spansion s25fl256s1 and s25fl512s support Dual SPI transfers, hence set the
> M25P80_DUAL_READ flag.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> ---
>  drivers/mtd/devices/m25p80.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index 73bf661100f7..f0871a2e449d 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -960,8 +960,8 @@ static const struct spi_device_id m25p_ids[] = {
>  	{ "s25sl032p",  INFO(0x010215, 0x4d00,  64 * 1024,  64, 0) },
>  	{ "s25sl064p",  INFO(0x010216, 0x4d00,  64 * 1024, 128, 0) },
>  	{ "s25fl256s0", INFO(0x010219, 0x4d00, 256 * 1024, 128, 0) },
> -	{ "s25fl256s1", INFO(0x010219, 0x4d01,  64 * 1024, 512, 
M25P80_QUAD_READ)
> }, -	{ "s25fl512s",  INFO(0x010220, 0x4d00, 256 * 1024, 256,
> M25P80_QUAD_READ) }, +	{ "s25fl256s1", INFO(0x010219, 0x4d01,  64 * 1024,
> 512, M25P80_DUAL_READ | M25P80_QUAD_READ) }, +	{ "s25fl512s", 
> INFO(0x010220, 0x4d00, 256 * 1024, 256, M25P80_DUAL_READ |
> M25P80_QUAD_READ) }, { "s70fl01gs",  INFO(0x010221, 0x4d00, 256 * 1024,
> 256, 0) },
>  	{ "s25sl12800", INFO(0x012018, 0x0300, 256 * 1024,  64, 0) },
>  	{ "s25sl12801", INFO(0x012018, 0x0301,  64 * 1024, 256, 0) },

Why don't you lump this together with 1/4 ? :)

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

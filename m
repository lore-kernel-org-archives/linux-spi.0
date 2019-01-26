From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v2 1/2] eeprom: at25: Merge "off" and "offset" in
 at25_ee_write()
Date: Sat, 26 Jan 2019 11:06:05 +0100
Message-ID: <20190126110546.360190cc@bbrezillon>
References: <20190118140525.29189-1-geert+renesas@glider.be>
        <20190118140525.29189-2-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mtd@lists.infradead.org,
        Nguyen An Hoan <na-hoan@jinso.co.jp>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118140525.29189-2-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 18 Jan 2019 15:05:24 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Since commit 01973a01f9ec34b7 ("eeprom: at25: remove nvmem regmap
> dependency") changed the type of "off" from "loff_t" to "unsigned int",
> "off" and "offset" are now the same type, and can be merged into a
> single variable.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v2:
>   - Merge "off" and "offset" into a single variable instead of just
>     killing the cast, as suggested by Arnd.
> ---
>  drivers/misc/eeprom/at25.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index 99de6939cd5ac2e3..2d8e5388e574710d 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -130,7 +130,8 @@ static int at25_ee_read(void *priv, unsigned int offset,
>  	return status;
>  }
>  
> -static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
> +static int at25_ee_write(void *priv, unsigned int offset, void *val,
> +			 size_t count)
>  {
>  	struct at25_data *at25 = priv;
>  	const char *buf = val;
> @@ -138,10 +139,10 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
>  	unsigned		buf_size;
>  	u8			*bounce;
>  
> -	if (unlikely(off >= at25->chip.byte_len))
> +	if (unlikely(offset >= at25->chip.byte_len))
>  		return -EFBIG;
> -	if ((off + count) > at25->chip.byte_len)
> -		count = at25->chip.byte_len - off;
> +	if ((offset + count) > at25->chip.byte_len)
> +		count = at25->chip.byte_len - offset;
>  	if (unlikely(!count))
>  		return -EINVAL;
>  
> @@ -160,7 +161,6 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
>  	do {
>  		unsigned long	timeout, retries;
>  		unsigned	segment;
> -		unsigned	offset = (unsigned) off;
>  		u8		*cp = bounce;
>  		int		sr;
>  		u8		instr;
> @@ -234,7 +234,7 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
>  			break;
>  		}
>  
> -		off += segment;
> +		offset += segment;
>  		buf += segment;
>  		count -= segment;
>  

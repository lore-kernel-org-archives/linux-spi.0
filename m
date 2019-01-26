From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v2 2/2] eeprom: at25: Use
 spi_message_init_with_transfers() instead of open coding
Date: Sat, 26 Jan 2019 11:06:48 +0100
Message-ID: <20190126110639.4717ec0e@bbrezillon>
References: <20190118140525.29189-1-geert+renesas@glider.be>
        <20190118140525.29189-3-geert+renesas@glider.be>
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
In-Reply-To: <20190118140525.29189-3-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 18 Jan 2019 15:05:25 +0100
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> Reduce code duplication in at25_ee_read() by using the
> spi_message_init_with_transfers() helper.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

> ---
> v2:
>   - Add Acked-by.
> ---
>  drivers/misc/eeprom/at25.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index 2d8e5388e574710d..18a093e14517ab45 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -103,16 +103,15 @@ static int at25_ee_read(void *priv, unsigned int offset,
>  		*cp++ = offset >> 0;
>  	}
>  
> -	spi_message_init(&m);
>  	memset(t, 0, sizeof(t));
>  
>  	t[0].tx_buf = command;
>  	t[0].len = at25->addrlen + 1;
> -	spi_message_add_tail(&t[0], &m);
>  
>  	t[1].rx_buf = buf;
>  	t[1].len = count;
> -	spi_message_add_tail(&t[1], &m);
> +
> +	spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
>  
>  	mutex_lock(&at25->lock);
>  

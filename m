From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi: spi-ti-qspi: clear wlen field while setting word
 length.
Date: Mon, 11 Jul 2016 10:37:08 +0530
Message-ID: <5783297C.7080702@ti.com>
References: <1468094753-8327-1-git-send-email-prahlad.eee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Prahlad V <prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1468094753-8327-1-git-send-email-prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Prahlad,

On Sunday 10 July 2016 01:35 AM, Prahlad V wrote:
> When a word length of 1 byte is selected and writing data of length
> more than QSPI_WLEN_MAX_BYTES, first MAX_BYTES will be transfered
> and remaining will be transfered byte by byte. In that case wlen
> field should be cleared before setting.
> 
> Signed-off-by: Prahlad V <prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-ti-qspi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index 29ea8d2..6c61f54 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -276,9 +276,9 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t,
>  				cmd |= QSPI_WLEN(QSPI_WLEN_MAX_BITS);
>  			} else {
>  				writeb(*txbuf, qspi->base + QSPI_SPI_DATA_REG);
> -				cmd = qspi->cmd | QSPI_WR_SNGL;

qspi->cmd always has WLEN field cleared and set to WLEN = 1 byte (see
ti_qspi_start_transfer_one()). And hence variable 'cmd' will also have
WLEN set to 1 byte.

>  				xfer_len = wlen;
> -				cmd |= QSPI_WLEN(wlen);
> +				cmd = ((qspi->cmd & ~QSPI_WLEN_MASK) |
> +					     QSPI_WLEN(wlen));

So, this won't be necessary.

-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

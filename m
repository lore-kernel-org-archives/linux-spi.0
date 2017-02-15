From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3] spi: rspi: Fix bogus received byte in qspi_transfer_in()
Date: Wed, 15 Feb 2017 09:00:45 +0100
Message-ID: <CAMuHMdVKe3yqgXSpS+RrGHAo_fVWoJgO7=5t1jZasTxBiMNa8Q@mail.gmail.com>
References: <1487144035-9075-1-git-send-email-cv-dong@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi <linux-spi@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        =?UTF-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>,
        =?UTF-8?B?56iy5ZCJ?= <h-inayoshi@jinso.co.jp>,
        Cao Minh Hiep <cm-hiep@jinso.co.jp>
To: DongCV <cv-dong@jinso.co.jp>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1487144035-9075-1-git-send-email-cv-dong@jinso.co.jp>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Dong,

Thanks for the update!

On Wed, Feb 15, 2017 at 8:33 AM, DongCV <cv-dong@jinso.co.jp> wrote:
> In qspi_transfer_in(), when receiving the last n (or len) bytes of data,
> n(or len) bogus bytes were written in the receive buffer,

1 bogus byte was written

And I think you should mention this is a buffer overflow, as this has security
implications (see also "Fixes" below).

> This code leads to the following error that related to jffs2 format
> when trying to mount, unmount, and remount a jffs2-formatted device.
> Remove the bogus write to fix this.

You forgot to mention that you replaced "n" by "len", to improve readability.

> "jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40000: 0x1900 instead
>  jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x03b40004: 0x000c instead"
>
> Signed-off-by: DongCV <cv-dong@jinso.co.jp>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Please add

    Fixes: 3be09bec42a800d4 ("spi: rspi: supports 32bytes buffer for
DUAL and QUAD")

so the stable team knows which stable kernel version this needs backporting to.

> ---
>  drivers/spi/spi-rspi.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
> index 9daf500..bc3c868 100644
> --- a/drivers/spi/spi-rspi.c
> +++ b/drivers/spi/spi-rspi.c
> @@ -808,7 +808,7 @@ static int qspi_transfer_out(struct rspi_data *rspi, struct spi_transfer *xfer)
>                         for (i = 0; i < len; i++)
>                                 rspi_write_data(rspi, *tx++);
>                 } else {
> -                       ret = rspi_pio_transfer(rspi, tx, NULL, n);
> +                       ret = rspi_pio_transfer(rspi, tx, NULL, len);
>                         if (ret < 0)
>                                 return ret;
>                 }
> @@ -845,10 +845,9 @@ static int qspi_transfer_in(struct rspi_data *rspi, struct spi_transfer *xfer)
>                         for (i = 0; i < len; i++)
>                                 *rx++ = rspi_read_data(rspi);
>                 } else {
> -                       ret = rspi_pio_transfer(rspi, NULL, rx, n);
> +                       ret = rspi_pio_transfer(rspi, NULL, rx, len);
>                         if (ret < 0)
>                                 return ret;
> -                       *rx++ = ret;
>                 }
>                 n -= len;
>         }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

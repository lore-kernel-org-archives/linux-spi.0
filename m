From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH/RFC] spi: sh-msiof: Fix FIFO size to 64 word from 256 word
Date: Mon, 15 Jun 2015 09:55:46 +0200
Message-ID: <CAMuHMdV-6zwDGxyFmzVga4ocXFDkfv8vot4ZHRgM9Kq6MBUcWw@mail.gmail.com>
References: <1434302705-31104-1-git-send-email-ykaneko0929@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Koji Matsuoka <koji.matsuoka.xm-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1434302705-31104-1-git-send-email-ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Kaneko-san, Matsuoka-san,

On Sun, Jun 14, 2015 at 7:25 PM, Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8@public.gmane.org=
m> wrote:
> From: Koji Matsuoka <koji.matsuoka.xm-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>
> The upper limit of Tx/Rx FIFO size is 64 word by the
> specification of H/W. This patch corrects to 64 word from 256 word.

Are you sure about that?

The R-Car Gen2 datasheet (up to Rev 1.01) says:

"FIFO capacity: 32 bits =C3=97 64 stages for transmission and 32 bits =C3=
=97 256 stages
 for reception"

Has this been changed in a more recent version of the datasheet?

Thanks!

> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>
> This patch is based on the for-next branch of Mark Brown's spi tree.
>
>  drivers/spi/spi-sh-msiof.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index d3370a6..a7629f8 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -48,8 +48,8 @@ struct sh_msiof_spi_priv {
>         const struct sh_msiof_chipdata *chipdata;
>         struct sh_msiof_spi_info *info;
>         struct completion done;
> -       int tx_fifo_size;
> -       int rx_fifo_size;
> +       unsigned int tx_fifo_size;
> +       unsigned int rx_fifo_size;
>         void *tx_dma_page;
>         void *rx_dma_page;
>         dma_addr_t tx_dma_addr;
> @@ -95,8 +95,6 @@ struct sh_msiof_spi_priv {
>  #define MDR2_WDLEN1(i) (((i) - 1) << 16) /* Word Count (1-64/256 (SH=
, A1))) */
>  #define MDR2_GRPMASK1  0x00000001 /* Group Output Mask 1 (SH, A1) */
>
> -#define MAX_WDLEN      256U

This is not related to FIFO size, but to max. DMA chunk transfer size.

> -
>  /* TSCR and RSCR */
>  #define SCR_BRPS_MASK      0x1f00 /* Prescaler Setting (1-32) */
>  #define SCR_BRPS(i)    (((i) - 1) << 8)
> @@ -850,7 +848,12 @@ static int sh_msiof_transfer_one(struct spi_mast=
er *master,
>                  *  DMA supports 32-bit words only, hence pack 8-bit =
and 16-bit
>                  *  words, with byte resp. word swapping.
>                  */
> -               unsigned int l =3D min(len, MAX_WDLEN * 4);

This is not related to FIFO size, but to max. DMA chunk transfer size.

> +               unsigned int l =3D 0;
> +
> +               if (tx_buf)
> +                       l =3D min(len, p->tx_fifo_size * 4);
> +               if (rx_buf)
> +                       l =3D min(len, p->rx_fifo_size * 4);
>
>                 if (bits <=3D 8) {
>                         if (l & 3)
> @@ -963,7 +966,7 @@ static const struct sh_msiof_chipdata sh_data =3D=
 {
>
>  static const struct sh_msiof_chipdata r8a779x_data =3D {
>         .tx_fifo_size =3D 64,
> -       .rx_fifo_size =3D 256,
> +       .rx_fifo_size =3D 64,

Please note the R-Car Gen2 FIFO size is also documented to be 256 in
Documentation/devicetree/bindings/spi/sh-msiof.txt

>         .master_flags =3D SPI_MASTER_MUST_TX,
>  };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

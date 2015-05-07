From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: sirf: replace kmalloc by devm_kzalloc
Date: Thu, 7 May 2015 09:25:02 +0200
Message-ID: <CAMuHMdVcKHxasYAF07Cj=EshjOpKhQJnm9crfFPdUb01WzZsWg@mail.gmail.com>
References: <1430982791-8681-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1430982791-8681-1-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, May 7, 2015 at 9:13 AM, Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>
> Signed-off-by: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
> Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
> ---
>  drivers/spi/spi-sirf.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
> index a69ccb7..ae4bd11 100644
> --- a/drivers/spi/spi-sirf.c
> +++ b/drivers/spi/spi-sirf.c
> @@ -758,7 +758,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
>         /* We are not using dummy delay between command and data */
>         writel(0, sspi->base + SIRFSOC_SPI_DUMMY_DELAY_CTL);
>
> -       sspi->dummypage = kmalloc(2 * PAGE_SIZE, GFP_KERNEL);
> +       sspi->dummypage = devm_kzalloc(&pdev->dev, 2 * PAGE_SIZE, GFP_KERNEL);
>         if (!sspi->dummypage) {
>                 ret = -ENOMEM;
>                 goto free_clk;

What about setting SPI_MASTER_MUST_RX and/or SPI_MASTER_MUST_TX,
and removing the dummy page instead, so the spi core will handle it for you?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

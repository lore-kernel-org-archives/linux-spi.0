From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi - Fix possible NULL derefrence.
Date: Mon, 30 Jan 2017 11:00:28 +0100
Message-ID: <CAMuHMdXqvLAH6NJduThQ54Ygi91A53huUHgG0jtOtrjxyagthw@mail.gmail.com>
References: <CGME20170130045527epcas2p18ca90e9cd6b0a6153bf941eec4f40ddf@epcas2p1.samsung.com>
 <1485752113-29581-1-git-send-email-shailendra.v@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        p.shailesh-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, ashish.kalra-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
        Shailendra Verma <shailendra.capricorn-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Shailendra Verma <shailendra.v-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1485752113-29581-1-git-send-email-shailendra.v-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Shailendra,

On Mon, Jan 30, 2017 at 5:55 AM, Shailendra Verma
<shailendra.v-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> of_match_device could return NULL, and so can cause a NULL
> pointer dereference later.

Can it? The driver uses DT exclusively.
There is no legacy platform code creating "mxs-spi" platform devices.

> Signed-off-by: Shailendra Verma <shailendra.v-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/spi/spi-mxs.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
> index 5b0e9a3..c3aea7e 100644
> --- a/drivers/spi/spi-mxs.c
> +++ b/drivers/spi/spi-mxs.c
> @@ -470,6 +470,11 @@ static int mxs_spi_probe(struct platform_device *pdev)
>          */
>         const int clk_freq_default = 160000000;
>
> +       if (!of_id) {
> +               dev_err(&pdev->dev, "Error: No device match found\n");
> +               return -ENODEV;
> +       }
> +

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

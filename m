From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: spi-geni-qcom: Grow a dev pointer to simplify code
Date: Tue, 4 Feb 2020 13:07:56 -0800
Message-ID: <CAD=FV=U6Yiv5i4PdDFqNhp0STqAvVi_=F_iuKyonx=MsOQFABQ@mail.gmail.com>
References: <20200204191206.97036-1-swboyd@chromium.org> <20200204191206.97036-3-swboyd@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Dilip Kota <dkota-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200204191206.97036-3-swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Tue, Feb 4, 2020 at 11:12 AM Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>
> Some lines are long here. Use a struct dev pointer to shorten lines and
> simplify code. The clk_get() call can fail because of EPROBE_DEFER
> problems too, so just remove the error print message because it isn't
> useful.
>
> Cc: Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Cc: Dilip Kota <dkota-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Cc: Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Cc: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 46e501fc87f3..f0ca7f5ae714 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -536,6 +536,7 @@ static int spi_geni_probe(struct platform_device *pdev)
>         struct spi_geni_master *mas;
>         void __iomem *base;
>         struct clk *clk;
> +       struct device *dev = &pdev->dev;
>
>         irq = platform_get_irq(pdev, 0);
>         if (irq < 0)
> @@ -545,28 +546,25 @@ static int spi_geni_probe(struct platform_device *pdev)
>         if (IS_ERR(base))
>                 return PTR_ERR(base);
>
> -       clk = devm_clk_get(&pdev->dev, "se");
> -       if (IS_ERR(clk)) {
> -               dev_err(&pdev->dev, "Err getting SE Core clk %ld\n",
> -                                               PTR_ERR(clk));
> +       clk = devm_clk_get(dev, "se");
> +       if (IS_ERR(clk))

There could be other errors besides -EPROBE_DEFER and devm_clk_get()
won't have printed in all cases.  ...but I agree that it seems highly
unlikely we'd ever hit any of those but highly likely we _would_ print
out a needless shout about -EPROBE_DEFER, so this is fine:

Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

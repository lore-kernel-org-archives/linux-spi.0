From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v4 01/14] spi: qup: Enable chip select support
Date: Thu, 20 Jul 2017 09:03:13 +0200
Message-ID: <CAMuHMdUrHszPkUqWd8y5rhEVERnz1j3UGeO55cSg1K9XX1S9dg@mail.gmail.com>
References: <1498556731-13087-1-git-send-email-varada@codeaurora.org> <1498556731-13087-2-git-send-email-varada@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Andy Gross <andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        David Brown <david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Sham Muthayyan <smuthayy-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1498556731-13087-2-git-send-email-varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Varadarajan,

On Tue, Jun 27, 2017 at 11:45 AM, Varadarajan Narayanan
<varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> Enable chip select support for QUP versions later than v1.
> The chip select support was broken in QUP version 1. Hence
> the chip select support was removed earlier in commit
> 4a8573abe965115bc5b064401fd669b74e985258. Since the chip
> select support is functional in recent versions of QUP,
> re-enabling it for QUP versions later than v1.
>
> Signed-off-by: Sham Muthayyan <smuthayy-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Signed-off-by: Varadarajan Narayanan <varada-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

> --- a/drivers/spi/spi-qup.c
> +++ b/drivers/spi/spi-qup.c

> @@ -846,6 +864,9 @@ static int spi_qup_probe(struct platform_device *pdev)
>         if (of_device_is_compatible(dev->of_node, "qcom,spi-qup-v1.1.1"))
>                 controller->qup_v1 = 1;

I know it was not introduced by your patch, but the proper way is to obtain
the version flag from spi_qup_dt_match[].data.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

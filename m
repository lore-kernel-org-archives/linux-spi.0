From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: spi-geni-qcom: Drop of.h include
Date: Tue, 4 Feb 2020 13:08:02 -0800
Message-ID: <CAD=FV=XLP4Rz9gW4hHDJRf54qFqnYJeXH259_B2Fd5ObTPZUeA@mail.gmail.com>
References: <20200204191206.97036-1-swboyd@chromium.org> <20200204191206.97036-4-swboyd@chromium.org>
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
In-Reply-To: <20200204191206.97036-4-swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Tue, Feb 4, 2020 at 11:12 AM Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> wrote:
>
> This driver doesn't call any DT functions like of_get_property(). Remove
> the of.h include as it isn't used.
>
> Cc: Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Cc: Dilip Kota <dkota-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Cc: Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> Cc: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> Signed-off-by: Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>

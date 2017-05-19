From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: imx: Revert "spi: imx: dynamic burst length adjust
 for PIO mode"
Date: Fri, 19 May 2017 12:19:42 -0300
Message-ID: <CAOMZO5BMuBjzsMcnEjC_RAHcwFg6OumOYtMiMOX9-f9NCVXH=g@mail.gmail.com>
References: <1495113735-11891-1-git-send-email-fabio.estevam@nxp.com>
 <1495115958.26925.23.camel@nxp.com> <CAOMZO5Adj+sgxgoO9gN232EEH=NtjTHpKfB+EaUAbRXyaPD_Gg@mail.gmail.com>
 <591DBFD2.4090601@mentor.com> <CAOMZO5BZvp_iWoJCTkZL-buSu6pscv1U-6XLjjEm8PjVOjf9wQ@mail.gmail.com>
 <591ECF3B.4040001@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <591ECF3B.4040001-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, May 19, 2017 at 7:55 AM, Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org> wrote:
> Hello Fabio
>
> Although I don't have this spi-nor chip populated on my sabresd,
> but I think I managed to re-create similar scenario,
>
> could you help to check if the following change address the spi-nor
> detection issue

This fixes the SPI NOR detection, thanks:

Tested-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

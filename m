From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: imx: Revert "spi: imx: dynamic burst length adjust
 for PIO mode"
Date: Thu, 18 May 2017 12:41:26 -0300
Message-ID: <CAOMZO5BZvp_iWoJCTkZL-buSu6pscv1U-6XLjjEm8PjVOjf9wQ@mail.gmail.com>
References: <1495113735-11891-1-git-send-email-fabio.estevam@nxp.com>
 <1495115958.26925.23.camel@nxp.com> <CAOMZO5Adj+sgxgoO9gN232EEH=NtjTHpKfB+EaUAbRXyaPD_Gg@mail.gmail.com>
 <591DBFD2.4090601@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <591DBFD2.4090601-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Jiada,

On Thu, May 18, 2017 at 12:37 PM, Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org> wrote:

> Which kernel and HW version are you using for test?

I am running linux-next 20170518 on a imx6q sabresd revB board.

> with the test on my imx6q sabresd board,
> no matter using upstream kernel or our internal kernel,
> the issue exists with or without the patch.

There are some imx6q sabresd boards that does not come with the SPI
NOR flash populated.

I assume your board does not have the SPI NOR populated, so that's why
you always get the same message.

Reverting 8d4a6cad7adb ("spi: imx: dynamic burst length adjust for PIO
mode") makes the SPI NOR to work again here.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

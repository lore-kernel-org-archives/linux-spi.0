From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: imx: fix issue when tx_buf or rx_buf is NULL
Date: Fri, 19 May 2017 16:15:01 +0300
Message-ID: <CAHp75VfmF-5kYdTiR0Jt3dyp-7OJDBZg_5LA3odf4M0jyiX+-w@mail.gmail.com>
References: <1495101672-3384-1-git-send-email-jiada_wang@mentor.com> <94de6e6d-a2fa-6589-151b-660bbcb42773@gtsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        leonard.crestez-3arQi8VN3Tc@public.gmane.org
To: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <94de6e6d-a2fa-6589-151b-660bbcb42773-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, May 19, 2017 at 3:45 PM, Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org> wrote:
> On Thursday, May 18, 2017 06:01 PM, jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org wrote:

> But I think we missing something here. We return from a void function()
> so the error keeps hidden. The root cause is calling this functions with a
> NULL pointer. See if you can fix this by find the caller and check if the
> parameter hand over are valid.

AFAIU some SPI controllers can have half-duplex protocol, in which the
second buffer might be absent.


> Disclaimer: http://www.gtsys.com.hk/email/classified.html

Just wondering if it's okay to have this type of footer in open source
community's mailing lists.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

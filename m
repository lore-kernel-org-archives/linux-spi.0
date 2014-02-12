From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 07/11] spi: spi-sh-msiof: RSCR register may absent
Date: Wed, 12 Feb 2014 17:06:41 +0100
Message-ID: <CAMuHMdVVC1deEQfbLzPzU08LYxf=KOtG3oL2_M4HMBGvJE+8KQ@mail.gmail.com>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
	<1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
	<1385921962-19843-7-git-send-email-takasi-y@ops.dti.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385921962-19843-7-git-send-email-takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Yoshii-san,

On Sun, Dec 1, 2013 at 7:19 PM,  <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org> wrote:
> On Ape6, Rcar-H2, and Rcar-M2,
> MSIOF lacks RSCR(Receive Clock Select Register).
> I guess this is a part of .rx_need_dummy_tx case, and use same flag.

Are you sure? I'm under the impression MSIOF on APE6 does have RSCR,
just like on A1, and SH (e.g. 7724).

Given also that:
  - dummy TX is needed during reception for  APE6, R-Car H2/M2, and
     (perhaps --- this is not 100% clear to me) A1,
  - RMDR1[15:0] must be zero on APE6, and R-Car H2/M2.

there are (at least) 4 different variants of MSIOF:
  - SH
  - A1
  - APE6
  - R-Car H2 and M2

And I don't know about SH7372 and SH73A0...

But we indeed may not need to distinguish between all variants.
You just use the value of rx_need_dummy_tx as test condition.
If this works for APE6 and A1, we can add a new platform device name
"spi_sh_mobile_msiof" instead of adding the rx_need_dummy_tx flag
to platform data (struct sh_msiof_spi_info).
This would be in line with the currently defined (but so far unused) DT
compatible values "renesas,sh-msiof" and "renesas,sh-mobile-msiof".

What do you think?

Thanks!

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

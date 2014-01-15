From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 0/9] Renesas RSPI/QSPI DT support
Date: Wed, 15 Jan 2014 09:46:14 +0100
Message-ID: <CAMuHMdXLD3RmU72nj1gGXJu26Ten+hbdSVb7MXkWJRfwYYontA@mail.gmail.com>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
	<CAMuHMdWmFa-XsderYDp4jMw6r7fnwpm5XgQGfz8gEbCryXEkHg@mail.gmail.com>
	<20140114005312.GF18217@verge.net.au>
	<CAMuHMdWMZE23JkEr7Weq6MWgPK5w-Gy_kus5HxvcLBdgPn5Daw@mail.gmail.com>
	<20140114234951.GA8769@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140114234951.GA8769-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Simon,

On Wed, Jan 15, 2014 at 12:49 AM, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org> wrote:
>> >> >     [6/9][V3] ARM: shmobile: r7s72100 dtsi: Add RSPI nodes
>> >> >     [7/9][V3] ARM: shmobile: genmai reference: Add RSPI nodes
>> >> >     [8/9] ARM: shmobile: r8a7791 dtsi: Add QSPI node
>> >> >     [9/9] ARM: shmobile: koelsch: Add QSPI nodes

> run-time dependencies of 6-9/9 ?

None, these are just DT nodes. It may print warnings due to unknown
pinctrl groups and functions, but that's it.

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

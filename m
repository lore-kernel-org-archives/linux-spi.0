From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: spi & enable gpio
Date: Wed, 13 Apr 2016 10:23:27 +0200
Message-ID: <CAMuHMdVzYr-OHba49nT3bV+5dNDtG-ubiKqfiDuN0kNMSU9j_Q@mail.gmail.com>
References: <CAF+MRtkHKuN_bCXaShsnVCJ7i_P2AiM7WCdWpbS0jX2vfvrwYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Micka <mickamusset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAF+MRtkHKuN_bCXaShsnVCJ7i_P2AiM7WCdWpbS0jX2vfvrwYg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Micka,

On Wed, Apr 13, 2016 at 9:55 AM, Micka <mickamusset-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> In my board, I have two component that are not enabled at the boot and
> need to be enabled when the spi driver start, to do that, I had to
> modify the driver spi. I would like to know if it's possible to add
> this possibility for the driver ?

Perhaps you can use the "gpio-hog" property in DT instead?

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

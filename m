From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v3 00/12] J-core J2 cpu and SoC peripherals support
Date: Wed, 25 May 2016 09:22:44 +0200
Message-ID: <CAMuHMdWdZLn=pYt1EC-k5Zd-geRaLkuQKZJjrZOaT6tqOxZ+Og@mail.gmail.com>
References: <cover.1464148904.git.dalias@libc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>,
	Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1464148904.git.dalias-8zAoT0mYgF4@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Rich,

On Wed, May 25, 2016 at 7:43 AM, Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org> wrote:
> As arch/sh co-maintainer my intent is to include as much as possible
> in my pull request for the linux-sh tree. If there are parts outside
> of arch/sh that can be included in this, please let me know. I'm not
> clear yet on what the right path to upstream is for the clocksource
> and irq drivers that are currently only useful/interesting for one
> arch, or for the DT binding patches. Even if some drivers are delayed

Drivers outside arch/sh/ should go through the respective maintainer's tree,
unless that maintainer allows you to take it by giving his Acked-by.
The same for DT bindings for such drivers.

> going upstream, I would really like to get DT bindings acked and
> ideally merged, because we want to go ahead with moving the DTB into
> J2 boot rom where it belongs, and that should only happen with stable
> bindings.

Please also add a changelog, so people who reviewed your previous series
before know what to skip and what to focus on.
Please add collected Acked-by and Reviewed-by tags when reposting.

Thanks!

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

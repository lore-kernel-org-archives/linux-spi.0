From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Applied "spi: Pick spi bus number from Linux idr or spi alias" to
 the spi tree
Date: Wed, 16 Aug 2017 22:31:11 +0200
Message-ID: <CAMuHMdW5NPQ39j=8di0t-fxkOPyn7pVkJs31ySJcsxw51sSTFQ@mail.gmail.com>
References: <E1di0ly-0003WF-HD@debutante> <CAMuHMdX0Z8prbMivN5pC+-PycDSEx1tzkjGpRKK4=3RC5aYegQ@mail.gmail.com>
 <20170816200908.lv6rxxzhvubj2b3p@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Suniel Mahesh <sunil.m-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>,
        Karthik Tummala <karthik-fINqtvHxh+hg9hUCZPvPmw@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170816200908.lv6rxxzhvubj2b3p-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Wed, Aug 16, 2017 at 10:09 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Aug 16, 2017 at 06:48:07PM +0200, Geert Uytterhoeven wrote:
>> On Wed, Aug 16, 2017 at 6:02 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> > Modify existing code, for automatically picking the spi bus number based
>> > on Linux idr scheme as mentioned in FIXME.
>
>> FIXME?
>
> It's fixing a FIXME that was in the code rather than a note to fix the
> commit message!  Slightly awkward phrasing but it makes sense if you
> look at the diff.

Thanks for the explanation! I did read the patch, but didn't realize it talked
about that FIXME (I guess my mind was too busy complaining to myself that
of_alias_get_id() is still being used ;-)

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

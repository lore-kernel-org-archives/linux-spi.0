From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 3/6] spi: sh-msiof: Add support for R-Car H2 and M2
Date: Thu, 27 Feb 2014 12:09:52 +0100
Message-ID: <CAMuHMdU6R_Wubsx2KCAXVBynzqquJekDNDZ-Sq1sKYEOM1RtTw@mail.gmail.com>
References: <1393323673-2751-1-git-send-email-geert@linux-m68k.org>
	<38730952.JbtPf2mapG@avalon>
	<CAMuHMdU_ej9cE=qmRL2WqvEW+fNA_5bj7OC2=7B7ZR33FaFUTA@mail.gmail.com>
	<1462634.UcxrmdxVtK@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	Bastian Hecht <hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1462634.UcxrmdxVtK@avalon>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Feb 27, 2014 at 11:41 AM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
>> >> -- compatible           : "renesas,sh-msiof" for SuperH, or
>> >> +- compatible           : "renesas,msiof-<soctype>" for SoCs,
>> >> +                      "renesas,sh-msiof" for SuperH, or
>> >>                        "renesas,sh-mobile-msiof" for SH Mobile series.
>> >> +                      Examples with soctypes are:
>> >> +                      "renesas,msiof-sh7724" (SH)
>> >
>> > Given that the driver doesn't handle the "renesas,msiof-sh7724" compatible
>> > string this might not be a good example. Furthermore SuperH doesn't have
>> > DT support. I would thus drop the "renesas,sh-msiof" compatible string
>> > from patch 1/6 and wouldn't mention sh7724 here. I very much doubt that
>> > someone would have developed DT support for SuperH on the side and
>> > shipped products that would be broken by this change :-)
>>
>> Upon reading your comment again: do you suggest to also remove the plain
>> "renesas,sh-msiof"? That one was present before, since DT support was added
>> to the driver in
>>
>> commit cf9c86efecf9510e62388fd174cf607671c59fa3
>> Author: Bastian Hecht <hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Date:   Wed Dec 12 12:54:48 2012 +0100
>>
>>     spi/sh-msiof: Add device tree parsing to driver
>>
>>     This adds the capability to retrieve setup data from the device tree
>>     node. The usage of platform data is still available.
>>
>>     Signed-off-by: Bastian Hecht <hechtb+renesas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>     Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
>>
>> So I prefer not to remove any pre-existing compatible values.
>> Do you agree?
>
> I'd like to remove it (in a separate patch) if we can. The reason is that
> keeping the DT ABI both forward- and backward-compatible is pretty painful
> enough without having to care about compatibility strings that have no user.
> I'd rather work on adding DT support for SuperH MSIOF later when we'll have a
> platform we can test it on, instead of trying to guess now what the needs will
> be, get users later and realize even later on that we made a mistake that we
> can't fix because those users will have DT binaries in the wild. Every
> unneeded bit of DT bindings that we keep in the kernel is one potential
> problem for future binary compatibility.

I agree about the complexity of keeping the DT ABI forward- and
backward-compatible.

However, in this case I don't think it hurts that much to just keep it:
  - DT compatible values and platform device names are kept in sync
    through a pointer to the same struct sh_msiof_chipdata, so there's
    not much maintenance needed.
  - DT compatible "renesas,sh-msiof" means exactly the same as
    the "spi_sh_msiof" platform device name, which is currently in use.

So even if SuperH never moves to DT, we have to keep support for that
specific MSIOF implementation, unless we drop the platform device version,
too (Hmm, maybe that's what you're alluding to ;-)

And if we remove "renesas,sh-msiof", we should probably remove
"renesas,sh-mobile-msiof", too, as there are no current users, and it also
assumes the same MSIOF implementation?

Bastian: What was your real plan with "renesas,sh-msiof" and
"renesas,sh-mobile-msiof"?

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

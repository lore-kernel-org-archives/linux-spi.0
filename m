From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH V2 0/3] SoC and board integration for QSPI on r8a7791/koelsch
Date: Tue, 14 Jan 2014 10:05:28 +0100
Message-ID: <CAMuHMdWYqv41RwyZROmuSeD9F9RfFFyOuCxn+66NgJ3MbhsJvw@mail.gmail.com>
References: <1389524433-2823-1-git-send-email-geert@linux-m68k.org>
	<20140114004638.GE18217@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140114004638.GE18217-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Simon,

On Tue, Jan 14, 2014 at 1:46 AM, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org> wrote:
> On Sun, Jan 12, 2014 at 12:00:29PM +0100, Geert Uytterhoeven wrote:
>> This series adds support for the Spansion s25fl512s SPI FLASH on the
>> r8a7791-based Koelsch board. It is based on
>> renesas-devel-v3.13-rc7-20140109v2, with Valentine's i2c pinctrl and
>> Laurent's SCIF DT work applied on top.
>> [Simon: I don't know in which order you will merge these. If you want me
>>  to rebase my patches, just ask! Thanks!]
>
> I see that Laruent has taken patch 1/4.
>
> Is it possible for me to merge patches 2-4/4 independently of that patch?
> That is, can I apply them and still produce a kernel that boots. If so,
> that is my preferred option. If not I will talk to Laurent about a branch
> to base things on.

Yes you can. Note that RSPI still won't be enabled without "spi: rspi: Remove
dependency on DMAE for SHMOBILE" (which has now landed in the spi tree).
And with that patch applied, you'll get warnings like:

    pinmux core: sh-pfc does not support function qspi
    sh-pfc pfc-r8a7791: invalid function qspi in map table
    pinmux core: sh-pfc does not support function qspi
    sh-pfc pfc-r8a7791: invalid function qspi in map table

which are harmless, and spi will still work, as that's the default pin config
anyway.

> Also, I would like to get an Ack from Magnus.

Sure.

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

From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] Documentation: dt: mtd: replace "nor-jedec" binding with "jedec,spi-nor"
Date: Thu, 21 May 2015 10:39:34 +0200
Message-ID: <CAMuHMdVr37hUxCJL+9WGX7BZtMpAaDyXrAb=i=xovUn6AyxfxA@mail.gmail.com>
References: <20150515195541.GL11598@ld-irv-0074>
	<20150518104501.GD3551@leverpostej>
	<20150518183442.GR11598@ld-irv-0074>
	<CAMuHMdUCj2AXk_0mAgRfAStrveHPi=Rp2g-b177zO_ode8NaCw@mail.gmail.com>
	<20150519013415.GV11598@ld-irv-0074>
	<CACna6rzpxoXEJbeRyxaR0wiPpWc_MmgvnqoW-dSw4fF-=EMM_g@mail.gmail.com>
	<20150520213546.GN11598@ld-irv-0074>
	<CACna6rxq5zOR=7LT2vdbioWp3nD0eBeELJ_d9pPk7VwTWhmStg@mail.gmail.com>
	<20150521072515.GC11112@norris-Latitude-E6410>
	<CACna6rz6O2XRt0OBmf9stLvM1xh4v4aKTD=MR2EbCKFPV1SOpA@mail.gmail.com>
	<20150521081526.GG11112@norris-Latitude-E6410>
	<CACna6rweJuyqZ-sVe-DT7yaX4pPLXt8H++BdsZ7+EyzSzoeRoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CACna6rweJuyqZ-sVe-DT7yaX4pPLXt8H++BdsZ7+EyzSzoeRoQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Rafal, Brian,

On Thu, May 21, 2015 at 10:25 AM, Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail=
=2Ecom> wrote:
> On 21 May 2015 at 10:15, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
>> On Thu, May 21, 2015 at 10:01:05AM +0200, Rafa=C5=82 Mi=C5=82ecki wr=
ote:
>>> On 21 May 2015 at 09:25, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>=
 wrote:
>>> >> > For platform devices, you might as well just use the name of t=
he driver,
>>> >> > which is 'm25p80'. Isn't that how most platform devices are ma=
tched with
>>> >> > drivers?
>>> >>
>>> >> Yes and I think it's ugly because it keeps causing the warning a=
bout
>>> >> read flash model not matching specified one (m25p80).
>>> >
>>> > Sure, I agree.
>>> >
>>> >> Are you
>>> >> seriously not going to allow platform stuff *clearly* request fl=
ash
>>> >> model detection (JEDEC RDID OP)? Just because they don't use DT?
>>> >
>>> > No, this isn't about "allowing" anything. It's just that my prima=
ry
>>> > concern was to get the DT binding straightened out properly. Linu=
s'
>>> > current tree now has the proper binding, but the m25p80.c code do=
esn't
>>> > quite bind properly. It will work if "jedec,spi-nor" is the first
>>> > entry in the compatible property (and so it becomes the 'modalias=
', but
>>> > not second, third, etc. So my patch fixes that properly.
>>> >
>>> > Now, the secondary concern is that you want platform devices to s=
pecify
>>> > something generic, and that doesn't yield a "found X, expected Y"
>>> > message. I'm perfectly fine with fixing that too, if you have a p=
atch
>>> > for it. What do you propose?
>>>
>>> Maybe I wasn't clear enough. I was going to start using struct
>>> flash_platform_data with
>>> .type =3D "spi-nor",
>>> but your proposed patch removes support for such name.
>>
>> Ah, OK. So that's the part I was overlooking.
>>
>>> While I like matching DT *clearly* against the whole "jedec,spi-nor=
"
>>> string (really, I'm all for it), I'm confused what I should use for
>>> platform stuff now. I don't have any proposal as my initial plan wa=
s
>>> exactly to use this "spi-nor".
>>> I guess I don't want to re-add support for "spi-nor" (as you just
>>> proposed to remove it),
>>
>> I wasn't really trying to remove "spi-nor", that was mostly a side
>> effect.
>
> OK, I think we understand each other now :)
>
>>> so I think I have to bounce the question: what
>>> alternative do you propose?
>>
>> I think your comments suggest that I shouldn't be removing "spi-nor"
>> from m25p_ids[] nor from this block:
>>
>>         if (data && data->type)
>>                 flash_name =3D data->type;
>>         else if (!strcmp(spi->modalias, "spi-nor"))
>>                 flash_name =3D NULL; /* auto-detect */
>>         else
>>                 flash_name =3D spi->modalias;
>>
>> So it stays in both m25p_ids[] and .of_match_table.
>>
>> I suppose that can work. It then allows people to do weird stuff lik=
e:
>>
>>         compatible =3D "idontknowwhatimdoing,spi-nor";
>>
>> in their device tree. But other than that, there's not much downside=
 I don't
>> think.
>
> It sounds like a reasonable solution. I guess there isn't a perfect
> one. Even if we decide to go for sth like "jedec-spi-nor", there
> always will be a chance of someone using
> compatible =3D "idontknowwhatimdoing,jedec-spi-nor";
> So if you rework your patch to leave "spi-nor" support in m25p_ids an=
d
> conditions block, it should be OK.

Typically platform devices just use the driver's name. Hence IMHO there=
's
no need to add a shiny new spi-nor device name.

So what's wrong with using "m25p80", and treating that as auto-detect i=
ff
!spi->dev.of_node?
Non-autodetect platform_devices use flash_platform_data.type anyway,
and thus fall under the first "if" clause above, don't they?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

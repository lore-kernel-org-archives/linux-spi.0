From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Documentation: dt: mtd: replace "nor-jedec" binding with "jedec,spi-nor"
Date: Thu, 21 May 2015 10:50:55 +0200
Message-ID: <CACna6ryXarbqAoE2W7GMmXr-Dycgrq1bQc98bwex6T4rUg_AGA@mail.gmail.com>
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
	<CAMuHMdVr37hUxCJL+9WGX7BZtMpAaDyXrAb=i=xovUn6AyxfxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdVr37hUxCJL+9WGX7BZtMpAaDyXrAb=i=xovUn6AyxfxA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 21 May 2015 at 10:39, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrot=
e:
> Hi Rafal, Brian,
>
> On Thu, May 21, 2015 at 10:25 AM, Rafa=C5=82 Mi=C5=82ecki <zajec5@gma=
il.com> wrote:
>> On 21 May 2015 at 10:15, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> =
wrote:
>>> On Thu, May 21, 2015 at 10:01:05AM +0200, Rafa=C5=82 Mi=C5=82ecki w=
rote:
>>>> On 21 May 2015 at 09:25, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org=
> wrote:
>>>> >> > For platform devices, you might as well just use the name of =
the driver,
>>>> >> > which is 'm25p80'. Isn't that how most platform devices are m=
atched with
>>>> >> > drivers?
>>>> >>
>>>> >> Yes and I think it's ugly because it keeps causing the warning =
about
>>>> >> read flash model not matching specified one (m25p80).
>>>> >
>>>> > Sure, I agree.
>>>> >
>>>> >> Are you
>>>> >> seriously not going to allow platform stuff *clearly* request f=
lash
>>>> >> model detection (JEDEC RDID OP)? Just because they don't use DT=
?
>>>> >
>>>> > No, this isn't about "allowing" anything. It's just that my prim=
ary
>>>> > concern was to get the DT binding straightened out properly. Lin=
us'
>>>> > current tree now has the proper binding, but the m25p80.c code d=
oesn't
>>>> > quite bind properly. It will work if "jedec,spi-nor" is the firs=
t
>>>> > entry in the compatible property (and so it becomes the 'modalia=
s', but
>>>> > not second, third, etc. So my patch fixes that properly.
>>>> >
>>>> > Now, the secondary concern is that you want platform devices to =
specify
>>>> > something generic, and that doesn't yield a "found X, expected Y=
"
>>>> > message. I'm perfectly fine with fixing that too, if you have a =
patch
>>>> > for it. What do you propose?
>>>>
>>>> Maybe I wasn't clear enough. I was going to start using struct
>>>> flash_platform_data with
>>>> .type =3D "spi-nor",
>>>> but your proposed patch removes support for such name.
>>>
>>> Ah, OK. So that's the part I was overlooking.
>>>
>>>> While I like matching DT *clearly* against the whole "jedec,spi-no=
r"
>>>> string (really, I'm all for it), I'm confused what I should use fo=
r
>>>> platform stuff now. I don't have any proposal as my initial plan w=
as
>>>> exactly to use this "spi-nor".
>>>> I guess I don't want to re-add support for "spi-nor" (as you just
>>>> proposed to remove it),
>>>
>>> I wasn't really trying to remove "spi-nor", that was mostly a side
>>> effect.
>>
>> OK, I think we understand each other now :)
>>
>>>> so I think I have to bounce the question: what
>>>> alternative do you propose?
>>>
>>> I think your comments suggest that I shouldn't be removing "spi-nor=
"
>>> from m25p_ids[] nor from this block:
>>>
>>>         if (data && data->type)
>>>                 flash_name =3D data->type;
>>>         else if (!strcmp(spi->modalias, "spi-nor"))
>>>                 flash_name =3D NULL; /* auto-detect */
>>>         else
>>>                 flash_name =3D spi->modalias;
>>>
>>> So it stays in both m25p_ids[] and .of_match_table.
>>>
>>> I suppose that can work. It then allows people to do weird stuff li=
ke:
>>>
>>>         compatible =3D "idontknowwhatimdoing,spi-nor";
>>>
>>> in their device tree. But other than that, there's not much downsid=
e I don't
>>> think.
>>
>> It sounds like a reasonable solution. I guess there isn't a perfect
>> one. Even if we decide to go for sth like "jedec-spi-nor", there
>> always will be a chance of someone using
>> compatible =3D "idontknowwhatimdoing,jedec-spi-nor";
>> So if you rework your patch to leave "spi-nor" support in m25p_ids a=
nd
>> conditions block, it should be OK.
>
> Typically platform devices just use the driver's name. Hence IMHO the=
re's
> no need to add a shiny new spi-nor device name.
>
> So what's wrong with using "m25p80", and treating that as auto-detect=
 iff
> !spi->dev.of_node?

Treating "m25p80" as auto-detect triggering string won't allow
platform to *force* "m25p80" flash type if there ever appears to be
needed. Maybe it's unlikely, but it still sounds like a bit bad design
for me.


> Non-autodetect platform_devices use flash_platform_data.type anyway,
> and thus fall under the first "if" clause above, don't they?

They do, but I don't see the point.

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

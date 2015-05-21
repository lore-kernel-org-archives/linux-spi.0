From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Documentation: dt: mtd: replace "nor-jedec" binding with "jedec,spi-nor"
Date: Thu, 21 May 2015 11:31:30 +0200
Message-ID: <CACna6rwmhtLhU4+aCazmkrxUpF=JC37mvs1SJVR2zetfj8oPjA@mail.gmail.com>
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
	<CACna6ryXarbqAoE2W7GMmXr-Dycgrq1bQc98bwex6T4rUg_AGA@mail.gmail.com>
	<CAMuHMdWW2mOHqOZ9dnMHU+9vYZK+X5Ns0ciBEQGzOKM6_XXE=A@mail.gmail.com>
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
In-Reply-To: <CAMuHMdWW2mOHqOZ9dnMHU+9vYZK+X5Ns0ciBEQGzOKM6_XXE=A@mail.gmail.com>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 21 May 2015 at 10:58, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrot=
e:
> On Thu, May 21, 2015 at 10:50 AM, Rafa=C5=82 Mi=C5=82ecki <zajec5@gma=
il.com> wrote:
>>>>> I think your comments suggest that I shouldn't be removing "spi-n=
or"
>>>>> from m25p_ids[] nor from this block:
>>>>>
>>>>>         if (data && data->type)
>>>>>                 flash_name =3D data->type;
>>>>>         else if (!strcmp(spi->modalias, "spi-nor"))
>>>>>                 flash_name =3D NULL; /* auto-detect */
>>>>>         else
>>>>>                 flash_name =3D spi->modalias;
>>>>>
>>>>> So it stays in both m25p_ids[] and .of_match_table.
>>>>>
>>>>> I suppose that can work. It then allows people to do weird stuff =
like:
>>>>>
>>>>>         compatible =3D "idontknowwhatimdoing,spi-nor";
>>>>>
>>>>> in their device tree. But other than that, there's not much downs=
ide I don't
>>>>> think.
>>>>
>>>> It sounds like a reasonable solution. I guess there isn't a perfec=
t
>>>> one. Even if we decide to go for sth like "jedec-spi-nor", there
>>>> always will be a chance of someone using
>>>> compatible =3D "idontknowwhatimdoing,jedec-spi-nor";
>>>> So if you rework your patch to leave "spi-nor" support in m25p_ids=
 and
>>>> conditions block, it should be OK.
>>>
>>> Typically platform devices just use the driver's name. Hence IMHO t=
here's
>>> no need to add a shiny new spi-nor device name.
>>>
>>> So what's wrong with using "m25p80", and treating that as auto-dete=
ct iff
>>> !spi->dev.of_node?
>>
>> Treating "m25p80" as auto-detect triggering string won't allow
>> platform to *force* "m25p80" flash type if there ever appears to be
>> needed. Maybe it's unlikely, but it still sounds like a bit bad desi=
gn
>> for me.
>
> To force m25p80 flash, you set flash_platform_data.type to "m25p80"?

Oh, I think I got lost in the way m25p80 is probed. Is it handled by
spi_board_info and its "modalias"?

Could I leave flash_platform_data.type set to NULL and still have m25p8=
0 probed?

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] Documentation: dt: mtd: replace "nor-jedec" binding with
 "jedec,spi-nor"
Date: Thu, 21 May 2015 00:25:15 -0700
Message-ID: <20150521072515.GC11112@norris-Latitude-E6410>
References: <1431624773-4165-1-git-send-email-computersforpeace@gmail.com>
 <20150515195541.GL11598@ld-irv-0074>
 <20150518104501.GD3551@leverpostej>
 <20150518183442.GR11598@ld-irv-0074>
 <CAMuHMdUCj2AXk_0mAgRfAStrveHPi=Rp2g-b177zO_ode8NaCw@mail.gmail.com>
 <20150519013415.GV11598@ld-irv-0074>
 <CACna6rzpxoXEJbeRyxaR0wiPpWc_MmgvnqoW-dSw4fF-=EMM_g@mail.gmail.com>
 <20150520213546.GN11598@ld-irv-0074>
 <CACna6rxq5zOR=7LT2vdbioWp3nD0eBeELJ_d9pPk7VwTWhmStg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Marek Vasut <marex@denx.de>,
	linux-spi <linux-spi@vger.kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACna6rxq5zOR=7LT2vdbioWp3nD0eBeELJ_d9pPk7VwTWhmStg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

(trim CC a bit, as this is no longer a DT binding question)

On Thu, May 21, 2015 at 09:12:25AM +0200, Rafa=C5=82 Mi=C5=82ecki wrote=
:
> On 20 May 2015 at 23:35, Brian Norris <computersforpeace@gmail.com> w=
rote:
> > On Tue, May 19, 2015 at 09:27:50AM +0200, Rafa=C5=82 Mi=C5=82ecki w=
rote:
> >> On 19 May 2015 at 03:34, Brian Norris <computersforpeace@gmail.com=
> wrote:
> >> > So how about the following patch? It seems like we'll need to be=
 able to
> >> > ignore useless 'modalias' values in cases like this:
> >> >
> >> >         // modalias =3D "shinynewdevice"
> >> >         compatible =3D "myvendor,shinynewdevice", "jedec,spi-nor=
";
> >> >
> >> > and also if somebody leaves off the entire shinynewdevice string=
:
> >> >
> >> >         // modalias =3D "spi-nor"
> >> >         compatible =3D "jedec,spi-nor";
> >> >
> >> > So we rework the spi-nor library to not reject "bad" names, and =
just
> >> > fall back to autodetection, and we add the .of_match_table to pr=
operly
> >> > catch all "jedec,spi-nor".
> >>
> >> That's nice but what about platforms using platform data instead o=
f
> >> DT? I would like to use some kind of "spi-nor" (with some prefix
> >> *maybe*) for them too.
> >
> > For platform devices, you might as well just use the name of the dr=
iver,
> > which is 'm25p80'. Isn't that how most platform devices are matched=
 with
> > drivers?
>=20
> Yes and I think it's ugly because it keeps causing the warning about
> read flash model not matching specified one (m25p80).

Sure, I agree.

> Are you
> seriously not going to allow platform stuff *clearly* request flash
> model detection (JEDEC RDID OP)? Just because they don't use DT?

No, this isn't about "allowing" anything. It's just that my primary
concern was to get the DT binding straightened out properly. Linus'
current tree now has the proper binding, but the m25p80.c code doesn't
quite bind properly. It will work if "jedec,spi-nor" is the first
entry in the compatible property (and so it becomes the 'modalias', but
not second, third, etc. So my patch fixes that properly.

Now, the secondary concern is that you want platform devices to specify
something generic, and that doesn't yield a "found X, expected Y"
message. I'm perfectly fine with fixing that too, if you have a patch
for it. What do you propose?

Brian

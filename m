From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Documentation: dt: mtd: replace "nor-jedec" binding with
 "jedec,spi-nor"
Date: Wed, 20 May 2015 14:35:46 -0700
Message-ID: <20150520213546.GN11598@ld-irv-0074>
References: <1431624773-4165-1-git-send-email-computersforpeace@gmail.com>
 <20150515195541.GL11598@ld-irv-0074>
 <20150518104501.GD3551@leverpostej>
 <20150518183442.GR11598@ld-irv-0074>
 <CAMuHMdUCj2AXk_0mAgRfAStrveHPi=Rp2g-b177zO_ode8NaCw@mail.gmail.com>
 <20150519013415.GV11598@ld-irv-0074>
 <CACna6rzpxoXEJbeRyxaR0wiPpWc_MmgvnqoW-dSw4fF-=EMM_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACna6rzpxoXEJbeRyxaR0wiPpWc_MmgvnqoW-dSw4fF-=EMM_g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, May 19, 2015 at 09:27:50AM +0200, Rafa=C5=82 Mi=C5=82ecki wrote=
:
> On 19 May 2015 at 03:34, Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
> > So how about the following patch? It seems like we'll need to be ab=
le to
> > ignore useless 'modalias' values in cases like this:
> >
> >         // modalias =3D "shinynewdevice"
> >         compatible =3D "myvendor,shinynewdevice", "jedec,spi-nor";
> >
> > and also if somebody leaves off the entire shinynewdevice string:
> >
> >         // modalias =3D "spi-nor"
> >         compatible =3D "jedec,spi-nor";
> >
> > So we rework the spi-nor library to not reject "bad" names, and jus=
t
> > fall back to autodetection, and we add the .of_match_table to prope=
rly
> > catch all "jedec,spi-nor".
>=20
> That's nice but what about platforms using platform data instead of
> DT? I would like to use some kind of "spi-nor" (with some prefix
> *maybe*) for them too.

=46or platform devices, you might as well just use the name of the driv=
er,
which is 'm25p80'. Isn't that how most platform devices are matched wit=
h
drivers?

Or if you can propose other clean solutions, I'm all ears. I'm likely t=
o
merge this patch for 4.2 unless a better solution comes up, though.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

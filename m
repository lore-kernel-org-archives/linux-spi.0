From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: fix blatant abuse of the resource
 subsystem
Date: Mon, 21 Jul 2014 14:41:04 +0200
Message-ID: <20140721144104.5e37f1a0@ipc1.ka-ro>
References: <1405683053-14104-1-git-send-email-LW@KARO-electronics.de>
	<20140718171035.GQ17528@sirena.org.uk>
	<20140721075144.251bb67d@ipc1.ka-ro>
	<20140721121820.GW17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
	Charulatha V <charu-l0cyMroinI0@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140721121820.GW17528-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

Mark Brown wrote:
> On Mon, Jul 21, 2014 at 07:51:44AM +0200, Lothar Wa=C3=9Fmann wrote:
> > Mark Brown wrote:
>=20
> > > I'm not going to apply this with a commit message such as the abo=
ve.
> > > Quite aside from the tone the fact that it doesn't describe the i=
ssue
> > > is not helpful for review, one of the things done in review is to=
 try to
> > > check that the change has the intended effect.
>=20
> > Maybe the original author or the maintainer who accepted this can c=
ome
> > up with a decent fix for this.
>=20
> Just to be clear the issue is with the presentation of your change, i=
t
> is not appropriate to provide a changelog which consists mainly of
> widely directed personal insults especially given that it omits basic
> technical content.
>
I understood that, but I feel incapable to come up with a reasonable
changelog for this.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org
___________________________________________________________
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

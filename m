From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Subject: Re: [PATCH] spi: omap2-mcspi: fix blatant abuse of the resource
 subsystem
Date: Mon, 21 Jul 2014 07:51:44 +0200
Message-ID: <20140721075144.251bb67d@ipc1.ka-ro>
References: <1405683053-14104-1-git-send-email-LW@KARO-electronics.de>
	<20140718171035.GQ17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Benoit Cousson <bcousson@baylibre.com>,
	Shubhrajyoti D <shubhrajyoti@ti.com>,
	Charulatha V <charu@ti.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140718171035.GQ17528@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

Mark Brown wrote:
> On Fri, Jul 18, 2014 at 01:30:53PM +0200, Lothar Wa=C3=9Fmann wrote:
> > Aua. This really hurts. I wonder how this could ever be admitted to
> > the Linux kernel...
> > Further comments suppressed because the would most likely violate t=
he
> > CDA.
> >=20
> > If someone should not grasp what this patch does, they should consi=
der
> > what happens upon unloading/reloading the kernel module.
> >=20
> > Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
>=20
> I'm not going to apply this with a commit message such as the above.
> Quite aside from the tone the fact that it doesn't describe the issue
> is not helpful for review, one of the things done in review is to try=
 to
> check that the change has the intended effect.
>
Maybe the original author or the maintainer who accepted this can come
up with a decent fix for this.


Lothar Wa=C3=9Fmann
--=20
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra=C3=9Fe 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch=C3=A4ftsf=C3=BChrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________

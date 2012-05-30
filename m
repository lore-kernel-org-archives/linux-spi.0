From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/6] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
Date: Wed, 30 May 2012 10:34:21 +0100
Message-ID: <20120530093421.GA9947@opensource.wolfsonmicro.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
 <20120520092113.GA20652@opensource.wolfsonmicro.com>
 <CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Cc: Thomas Abraham <thomas.abraham@linaro.org>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, kgene.kim@samsung.com,
	jaswinder.singh@linaro.org
To: Olof Johansson <olof@lixom.net>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 30, 2012 at 12:28:55AM -0700, Olof Johansson wrote:
> On Sun, May 20, 2012 at 2:21 AM, Mark Brown

> > This dev_name also isn't equivalent to dev_name() which makes matters
> > more confusing than they need to be.

> Looks like they use the name as the magic string to pick initialization data.

Right, and there's no problem at all with using the name.  The thing is
that there's no need to set the name at runtime since the struct device
being configured is always going to end up with the same name and doing
so is just causing confusion.  The device being registered is specific
to the SoC already so setting the SoC name at runtime isn't needed.

> I wonder if it makes more sense to keep the platform_data still
> around, and just fill it in with the table (from patch "spi: s3c64xx:
> move controller information into driver data") based on the OF
> compatible field for the device-tree probe case, instead of trying to
> overload and having to change the name in this way.

We could do that, though it does seem nice to have everything be
consistent.

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPxemUAAoJEBus8iNuMP3dMWUP+wTZbcGGsFGuCIND/9RCdWsM
ZHEFJqzGoXlfOnBDeE21ELj2G6+pnhho0DtThshMxDlMzag6RdowKZ4z3FHRxVA+
f2fCR3wWxu8c+Wmot28t6f1H8aDAfJ+ZmRCkq/2cm8UAGiYPDmrH67qkp9DnO5yv
SvNVeruPD4gNtK6evvpJY/FD7DeE4jx8nGGK+bB+So8GGhtLNv2/KNUXmQZ93D0/
YubNJOqMl6UVwVmR+i2IGPuqjp0efgWf3HhlKG/73xydVyFzkfATzxKILsPlPnK/
ETKfz+Op/tvKWY2M52cgUQmWAxXTSPUIO2IYhmodKgRB7G6srhnboLa5oTxnyZTu
eHUncVxgT0W5mrpgynmsdUWMXmhYQCQfPW8Q+Bjk4XvsviC/02zWTAsKoU7tv00r
uo+PdW4BsQ11AlGayAghjiq5mwzWPTSt1N7BVj4mXtKPtA6N9nNxh+s4ID6kryeo
g7RYPE/blWySa9/nBqCn03rcDt+TMpgO05Oin6yyUF1e/T4D1OVFKIBw8kU4IaGQ
nekocLphtZIn6F70l5THq7Jurqxwzcdb1z/qOrDKDKM52y8WlDA8ys+99DBqz1r3
0OSaHuJN0gZK3Akei6wWGbxa/RbNuRres+yEIisKSkpZVDc9FW23UqwTVrfLhk1+
7Dz23oKjCx7qXxMDbAgn
=h4ST
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--

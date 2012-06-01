From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/6] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
Date: Fri, 1 Jun 2012 13:39:03 +0100
Message-ID: <20120601123902.GL24139@opensource.wolfsonmicro.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
 <20120520092113.GA20652@opensource.wolfsonmicro.com>
 <CAOesGMhFcdv7QW=_1U8HHfaETD83mJt=Dgk-8z40yOrC3PB_fA@mail.gmail.com>
 <20120530093421.GA9947@opensource.wolfsonmicro.com>
 <CAJuYYwShLhKSrpGhaTyxX4dqaiKDAcjBtuWSMYAdsWcOMfP=qw@mail.gmail.com>
 <20120530101326.GF9947@opensource.wolfsonmicro.com>
 <CAJuYYwT88mpTKmOD8mpCjsQo9O_+Giri7+q-Rzz=zPNj+F7aDg@mail.gmail.com>
 <20120531113659.GB2666@opensource.wolfsonmicro.com>
 <CAJuYYwS5vPO9GNFMGArroOe57Z80+gP0vnRMjPuXRaxukNJ8uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KaGhPsiNaI6/sRd6"
Cc: Olof Johansson <olof@lixom.net>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, kgene.kim@samsung.com,
	jaswinder.singh@linaro.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuYYwS5vPO9GNFMGArroOe57Z80+gP0vnRMjPuXRaxukNJ8uw@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--KaGhPsiNaI6/sRd6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2012 at 10:47:44AM +0800, Thomas Abraham wrote:

> 1. There is one instance of 'struct platform_device' for each of the
> spi controller instances (0/1/2) named "s3c64xx-spi" (in
> arch/arm/plat-samsung/devs.c).

Right, which looks rather like it is specific to s3c64xx at least given
the naming...  there aren't any current in tree users, though I do have
one out of tree user on s3c6410.  If this is supposed to be used on the
later SoCs too then I guess it ought to be renamed anyway since what's
there looks wrong.

> 5. If point 4 is not correct, the other option is to create a separate
> instances of 'struct platform_device' for each of the s3c, s5p and
> Exynos4/5 SoC's. Is this the correct way, and if yes, could you please
> help me understand the issues in setting the name of the platform
> device at runtime.

That would seem less painful to me.  The big problem I've found is with
things like matching clocks up where if you look at the device that's
being registered it has one name but at runtime it has another name, it
makes everything much harder to follow.  There was one of the devices
where the .id also ended up getting changed which created even more
confusion.

--KaGhPsiNaI6/sRd6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPyLfgAAoJEBus8iNuMP3dw1wP/1t2M4M5d5Zmy7uEIpxDN4i1
WcUprmVQScmUZYzkfOV1qpuDg1/6oNokjnc6JPd3JgG5g5AEZRw6S5Kb5fxqxzgn
LdQBwLCcDgdwVguCetXw/rRGN1SadS+BvfozU58nXvRaP2QCAAxgEvWcWuXc//F1
w8vWPs4fk+VpuS1Vy1DWD9dGaJ+OZuAfP/GnQZk3w/1pVvWlXPz5Qcc0C35Ya6Fb
TYE3iUjUOmRmf8dQuRlpAqiYNuRHTcfr4GE3lXlCBlo4NR8WNPc+NJcgyflZZikX
98GkN15oRD7wKXaKWvfynJl8fZibv326gDIGg9tNeWMUPuRvBjNqvCKWgFL44nKo
re3tM3iDgdUcVyY8bxFQvop6zWQbmtb/j15oi8vQBr4dw3biFmXqb8j7vZkdZ/rW
dpH08RAo5J4PALF70WTvw4I8Zz4LcJsQD68G9lG32I+6ZS13hu5ALIX/xF8gh1XC
F9JwtCobKxYnHu8U0KiIkkWfb+TGLOPmBL6x1vWaVvLqHhmN/YIWh/cu3Lrp/FLD
6zOX76tX1JbyApVkVKyiXla3+yY4WHIAZZJNespz5KCA6dpzP+NPDacmBFfUWjsZ
j0RZ1eIn7ScaiwkiLhPFPS+8aY8ETRiMAXOSX5fvB22wLGwuEci0Fz+6F8ejFTdC
nIDvm2CNqylzSWAkrbgY
=AEVv
-----END PGP SIGNATURE-----

--KaGhPsiNaI6/sRd6--

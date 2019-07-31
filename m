From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/6] ReST conversion patches not applied yet
Date: Wed, 31 Jul 2019 21:20:07 +0100
Message-ID: <20190731202007.GI4369@sirena.org.uk>
References: <cover.1564603513.git.mchehab+samsung@kernel.org>
 <20190731141734.1fa9ce64@lwn.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3074929302278304555=="
Cc: Mark Rutland <mark.rutland@arm.com>, Dave Kleikamp <shaggy@kernel.org>,
 alsa-devel@alsa-project.org,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Evgeniy Polyakov <zbr@ioremap.net>, linux-cifs@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
 Evgeniy Dushistov <dushistov@mail.ru>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, samba-technical@lists.samba.org,
 Liam Girdwood <lgirdwoo
To: Jonathan Corbet <corbet@lwn.net>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190731141734.1fa9ce64@lwn.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============3074929302278304555==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9s922KAXlWjPfK/Q"
Content-Disposition: inline


--9s922KAXlWjPfK/Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2019 at 02:17:34PM -0600, Jonathan Corbet wrote:
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:

> > As promised, this is the rebased version of the patches that were not a=
pplied
> > from the /26 patch series because you had merge conflicts.
> >=20
> > They're all based on your docs-next branch, so should apply fine.
> >=20
> > The first one fixes all but one error with a broken reference.
> >=20
> > The only broken reference right now is due to a DT patch with was not
> > accepted (no idea why), but whose driver is upstream.

> All but 5/6 applied, thanks.

Oh, I still hadn't reviewed this version of the SPI stuff :(

There were outstanding questions about where it was going to get moved
to but if I read the diff correctly it looks like it didn't actually get
moved in the end?

--9s922KAXlWjPfK/Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1B9/YACgkQJNaLcl1U
h9Bg/wf5AdzUWJa+NJteGVMxcv2AdvS61I9agmCR6mMbPERTL3lRkGvteyyk4FqS
OLlGCoSv8ytbJJ7mVGt28aBLCB7cHeDQGGmdf7OM3nJGun9yy4mmhOUIWxgjWRCl
SgO2qZpfOz121zfa2goqOfdNzbPOotjeuIyVJxvNH0NLLvRjjDZ1+4rXUjvMZf26
cVK4dXIu7+m0Kh6N6EFG9vmpNjbh23zfkd89kH8bMBGaOHdhj/3cRmCw2ZxK8Uiz
Z+xwRCyTI0CIegyUp0ZKheAqubruDFR7y0F9sYcI5KR+w0cDrfxYjOUgZa2JJKn7
Rdr1TAWXS/LG/aYR09ZGPHQsIsDKIw==
=V4AT
-----END PGP SIGNATURE-----

--9s922KAXlWjPfK/Q--


--===============3074929302278304555==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3074929302278304555==--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 5/5] ARM: dts: ls1021a-tsn: Use the DSPI controller in
 poll mode
Date: Tue, 27 Aug 2019 19:13:18 +0100
Message-ID: <20190827181318.GG23391@sirena.co.uk>
References: <20190822211514.19288-1-olteanv@gmail.com>
 <20190822211514.19288-6-olteanv@gmail.com>
 <CA+h21hqWGDCfTg813W1WaXFnRsMdE30WnaXw5TJvpkSp0-w5JA@mail.gmail.com>
 <20190827180502.GF23391@sirena.co.uk>
 <CA+h21hr3qmTG1LyWsEp+hZZW2NJFtg9Dh1k6SXVDd+A_YSQjjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Qtzb1h6tVL0ohdDu"
Cc: linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hr3qmTG1LyWsEp+hZZW2NJFtg9Dh1k6SXVDd+A_YSQjjw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Qtzb1h6tVL0ohdDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 27, 2019 at 09:06:14PM +0300, Vladimir Oltean wrote:
> On Tue, 27 Aug 2019 at 21:05, Mark Brown <broonie@kernel.org> wrote:
> > On Mon, Aug 26, 2019 at 04:10:51PM +0300, Vladimir Oltean wrote:

> > > I noticed you skipped applying this patch, and I'm not sure that Shawn
> > > will review it/take it.
> > > Do you have a better suggestion how I can achieve putting the DSPI
> > > driver in poll mode for this board? A Kconfig option maybe?

> > DT changes go through the relevant platform trees, not the
> > subsystem trees, so it's not something I'd expect to apply.

> But at least is it something that you expect to see done through a
> device tree change?

Well, it's not ideal - if it performs better all the time the
driver should probably just do it unconditionally.  If there's
some threashold where it tends to perform better then the driver
should check for that but IIRC it sounds like the interrupt just
isn't at all helpful here.

--Qtzb1h6tVL0ohdDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1lcr0ACgkQJNaLcl1U
h9DiNQf44uUy1o+vPwfy6IZd76tgLRc0F21kMaHMJBkX9RYaQ3/YV3E4t0iaFjE/
3o4DF69ZkIXWQOirPQM73xvOUmU/06qCJCjU+QJAukVjKFdT2dgXLDBic+043CTR
I0I3OZH8QJiFmPodSkHgFmI0mKIagD21X1187YWrKtZ5WJ8VzWaJS8IamAMKgj2+
hiNrp/TYthXpJ3MBoY8eYJVD+EuyqaDHkHoPE+2yYePl2YPmkjTwVjR1Mbge3Sbt
pTFH4xoDnHTAiH6EYQI2YnpEKCUVK/FwK/lpCTBLUfUVhAuxJSGyqvHeSqYMDMJD
HFuQ6G6plEMXcfwYUX5gStzzs8UE
=pCt+
-----END PGP SIGNATURE-----

--Qtzb1h6tVL0ohdDu--

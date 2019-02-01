From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/9 v3] staging: spi: mt7621: Switch to SPDX identifier
Date: Fri, 1 Feb 2019 13:03:55 +0000
Message-ID: <20190201130355.GG20797@sirena.org.uk>
References: <20190201101715.3760-1-sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3146212405494790254=="
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Crispin <john@phrozen.org>, linux-spi@vger.kernel.org,
 Sankalp Negi <sankalpnegi2310@gmail.com>, NeilBrown <neil@brown.name>
To: Stefan Roese <sr@denx.de>
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20190201101715.3760-1-sr@denx.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
List-Id: linux-spi.vger.kernel.org


--===============3146212405494790254==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Content-Disposition: inline


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 01, 2019 at 11:17:07AM +0100, Stefan Roese wrote:

> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * spi-mt7621.c -- MediaTek MT7621 SPI controller driver
>   *

Please convert the entire comment into a C++ comment so it looks more
intentional.

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxUQ7sACgkQJNaLcl1U
h9CE9wf/TlH4DARc6d62teBFcMNopb0YY11DFxf8h8X0ls4tlEHXFP3kr9WQU8He
reFIb/ttLo7RV2FxbZHe6mmRQ3dCA/solV/IE+x0+6OKAEVI02KMn/t4q0BdUDyr
GDAlT0YSY8BGeJ7zYx/YzROQI9RqYImkOjQJDlY1B/C7LdPaiPtQ4RS+AchNiQXR
egTMHs8XBmZrvikfOwv5SOlV/5F0/pCs1CarnynkhzGfV5EzN1lnH9tqtLu4hNWz
Ri5dRwfNct3UzrxYV8wi05x0G9rci6tJ1IrtO90H9P4RLlE9mojJ10imelntPV7t
8Ex/OPRRtYOexK4+dWY/XY+dr6R2bQ==
=dRIm
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--

--===============3146212405494790254==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============3146212405494790254==--

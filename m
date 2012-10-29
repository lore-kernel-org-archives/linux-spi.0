From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] spi: spidev: Add device tree bindings
Date: Mon, 29 Oct 2012 16:10:24 +0000
Message-ID: <20121029161023.GC4511@opensource.wolfsonmicro.com>
References: <1351238873-25230-1-git-send-email-maxime.ripard@free-electrons.com>
 <1351238873-25230-2-git-send-email-maxime.ripard@free-electrons.com>
 <20121027221955.GO4564@opensource.wolfsonmicro.com>
 <508EA013.7050907@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2514278290556396675=="
Cc: spi-devel-general@lists.sourceforge.net, Shawn Guo <shawn.guo@linaro.org>,
 linux-arm-kernel@lists.infradead.org, Brian Lilly <brian@crystalfontz.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <508EA013.7050907@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============2514278290556396675==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Content-Disposition: inline


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 29, 2012 at 04:26:11PM +0100, Maxime Ripard wrote:

> Ok, so I guess that leaves us with 2 choices here:

>   * Declare the device in the dt as you would have with any other
>     driver, with its own compatible string, and we add this compatible
>     string to the spidev dt ids array. It allows to use the existing
>     code and thus doesn't require any effort at all, but it will
>     generate a lot of noise for the spidev driver, since all of us will
>     need to add its compatible string to spidev.

>   * Rework the spidev code so that it behaves mostly like i2c-dev, that
>     is you have an instance of it for every device enumerated in the dt,
>     regardless of wether it has a driver loaded or not. If the
>     userspace opens the device file corresponding to a device already
>     attached to a driver, you return EBUSY, and that's it. I guess it
>     would be the cleaner solution, since you only select spidev in
>     configuration, but it definitely requires way more development than
>     the first one.

> What's your views on this?
> Did you have in mind another solution?

I think either solution is good, obviously Grant's more the expert here.
Adding the IDs is obviously simpler and doesn't preclude later doing the
i2c-dev style thing so short term I'd probably add the IDs to get things
going and punt on the difficult stuff for the time being but YMMV.

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjqppAAoJELSic+t+oim9BjwQAJI2eOZhIiMmlMU9qCV7Tj9H
7fcbxECfwvyyj0ThAMfd9vDT31+NSsPrqOKrS5J4NiY04WCf9YTDGyRYL4/FveXU
6qZg+lL4g7uHAq71g/ZzB/D3JZGVQGTAEAI4uSxi2yEl1uYPDfdUuLr3+7AIs5C6
2OFcVqkrkN+JfzTUz9pOHNUiqQ1pwY+O2UX5jrReEJ4seVyrIoDKC0JCc4FgFSSt
ZwlFmR3bkOmEKdvKA1F0873HhVIcvWglLBYb6jXuFEcw8x7GBDxRvqXMl6k2Zz1D
Xvt4vCTmeQabTb0jrjEAj2F0uBuY3B3gClHVH+wuXrVLGN2Ihu8L0yxlj6+8Sty9
Rak+nN0YR2d6TNqfLIMo3JjDLrF1P131/idiR8kJdujRp3VOU9necw8Nouwh8txO
Oq3TYaL0rD+aeg1mzFjZcdqwkhsyJxF3glPsjOzXgmivmSpG4mquJRDXNrob76+q
ozkBKEg6PvMfSztmIilTHHEH9yyVpegb9OvAe0jnm3jCFYh/K8XtOlUC1JXkE8hA
1Ea3KGk2jAgQLmE/tKkLE2PKfXENxwjP8x/ytVdJr2jTgoZc0KR8pBgbbZIgkcoA
QYAAeGqBIXUgWvMqniVFl+wVyh6n3W/Is9CRPJQSuqHrAqvZSLb/wlj/LhNfI5Au
cDJAbD4McMgFmtIZ/YBH
=QcBr
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--


--===============2514278290556396675==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2514278290556396675==--

From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] spi/pl022: timeout on polled transfer
Date: Thu, 19 May 2011 16:23:23 +0200
Message-ID: <20110519142323.GD2219@pengutronix.de>
References: <1305807191-11704-1-git-send-email-linus.walleij@stericsson.com>
	<20110519124454.GC2219@pengutronix.de>
	<BANLkTinrk-FjMy1trDnsxwT_NTgQ5x_8Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0030896968=="
Cc: Linus Walleij <linus.walleij@stericsson.com>,
	Magnus Templing <magnus.templing@stericsson.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net, Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <BANLkTinrk-FjMy1trDnsxwT_NTgQ5x_8Rg@mail.gmail.com>
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


--===============0030896968==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> >> + =A0 =A0 =A0 =A0 =A0 =A0 while (pl022->tx < pl022->tx_end || pl022->r=
x < pl022->rx_end) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, time=
out)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&pl=
022->adev->dev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: timeout=
!\n", __func__);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 message->sta=
te =3D STATE_ERROR;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 readwriter(pl022);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
>=20
> What about we move readerwriter() above if (time_after...) then it atleast
> gets one chance to run even if we're preempted for 10 seconds.

This will fix the initial problem, but still exit early if e.g. the
preemption came on a subsequent iteration of the while loop, say during
readwriter().

>=20
> Any other design patterns that'd be better?

A bit better might be:

	while (...) {
		time =3D jiffies;
		readwriter();
		if (time_after(time, timeout)...)
			...
	}

So you continue triggering transfers as long as the last one was in the
valid timespan. In case of an preemption, you made sure you tried the
whole timespan (+ the jitter) which is probably better than stop trying
too early.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk3VJ9sACgkQD27XaX1/VRsJawCcCvZSi0/KjKcLJNMq5ZKrMtlY
3UcAn1XbrFuDa7xQ5/kL8/7K/MGP/Jia
=elBY
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--


--===============0030896968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0030896968==--

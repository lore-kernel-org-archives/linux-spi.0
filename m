From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: avoid unsigned->signed->unsigned promotion
Date: Mon, 02 Dec 2013 14:05:35 +0100
Message-ID: <xa1tli038ktc.fsf@mina86.com>
References: <1385745164-10534-1-git-send-email-mpn@google.com> <20131129214313.GA18036@mithrandir>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131129214313.GA18036@mithrandir>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> On Fri, Nov 29, 2013 at 06:12:44PM +0100, Michal Nazarewicz wrote:
>> u8 type, which is unsigned, is promoted to int, which is singned, when
>> doing a binary shift.  Then, on 64-bit machines, it is further promoted
>> to unsigned long which may lead to more significant half of the value
>> to be all ones.  To avoid this, explicitly promote to an unsigned type.

On Fri, Nov 29 2013, Thierry Reding wrote:
> But I don't think there's a real issue here. Even on 64-bit platforms,
> writel() will only write 32-bit registers, and therefore discard the
> upper 32 bits.
>
> I think in general perhaps a more proper fix would be to use only u32
> instead of unsigned long for these cases, since then the problem goes
> away. u32 is also the type of the value used by writel() so it makes
> perfect sense to use it.

Yes, you're absolutely right.  I dunno why I missed the fact it's used
in writel only.  I'll prepare a new patch soon(ish).

--=20
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=3D./ `o
..o | Computer Science,  Micha=C5=82 =E2=80=9Cmina86=E2=80=9D Nazarewicz   =
 (o o)
ooo +--<mpn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>--<xmpp:mina86-/eSpBmjxGS4dnm+yROfE0A@public.gmane.org>--ooO--(_)--Ooo--

--=-=-=
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"

--==-=-=
Content-Type: text/plain


--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJSnIWfAAoJECBgQBJQdR/0N3YQAIY840S8OZ7afX+q9n44AH2R
7lbWi2kQoaBcl3mTx86MxR4qNKoltcHq+syuCjGyv8SIMw0Sod7giQX6iwB+f1Kn
fgqQgTw7PYUQQBHwSn/dK1/pudJ4MprcA02MBwS2wQ5yDk9WUnF2k98OkPo4sD8n
2j3/bmLu+89FmKMNDk1QrliV1Oginv/r8004c2r1btN3gr54rjmcc5k3oP0L+i5c
GSvjniMvUIC5B6v56p5tKxst+JYblZqZ23vTOK/xTeshtiE8iTYv7msTlu5g2fIs
9mKAZFc/OYlBYMGaRVsgBjnWfCc1Q9DzGPBkvRnP87K8LC8drmCO8fQtJm0rh1KZ
D2WO9TT1aRRxTZ7SVkd61VW/jb0xxydZCDkNuat1mPP2q8oZNScWme+akwl4iyk2
NbaTmr2dTjMz2yaxStbihd1hDyyavlYOptfUINBrOFpRNqFSg44ntXKMbQmWRODy
Ct41WUBM+1AmGvrr6cgaFp93iqwIe/Dtk6sQL7br8hF0/cTuUt8miM0ddsBWGAOK
s+NHsD/Cj/9XQktTfMjFJTwblr2IP5t/5YqbjaN70V0bvpLtE5ylkrdTZOJwKw53
nc/jQynz9b/vZjHrBz1wV7nCjjW/9YuwRuXHoQp7Q2t5RoIiuvMYolinUOaSanVb
lPEyZIYSxjKq0vX3agd0
=Zblu
-----END PGP SIGNATURE-----
--==-=-=--

--=-=-=--

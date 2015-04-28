From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [linux-sunxi] [PATCH 2/3] spidev: Add DT binding example.
Date: Tue, 28 Apr 2015 16:12:05 +0200
Message-ID: <20150428141205.GG10950@lukather>
References: <553CCABA.3090504@redhat.com>
 <12F80B18-7418-430E-94F7-5A20C133BA9A@martin.sperl.org>
 <CAOMqctR8MZ_r6HHEBWhgxpUsTaV=M7DfmnJ_VxTqjWu4KMBSwA@mail.gmail.com>
 <20150426125113.GF5627@lukather>
 <20150427101601.GN22845@sirena.org.uk>
 <20150427173036.GA10950@lukather>
 <20150427180728.GW22845@sirena.org.uk>
 <cd282abf-898a-4f01-90a6-8bf2db160b8e@googlegroups.com>
 <CAOMqctRTFgnVEKDAx4roMcGOeGV35Dyz7oOsOa4jC-MKr9_xXg@mail.gmail.com>
 <28a25eda-bba0-4a2e-9890-b3d3bef7ac7e@googlegroups.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kjpMrWxdCilgNbo1"
Cc: linux-sunxi@googlegroups.com, hdegoede@redhat.com, corbet@lwn.net,
	kernel@martin.sperl.org, broonie@kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: "Eric D." <eric.dillmann@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <28a25eda-bba0-4a2e-9890-b3d3bef7ac7e@googlegroups.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--kjpMrWxdCilgNbo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2015 at 07:03:16AM -0700, Eric D. wrote:
> Hi,
>=20
> I give Maxime's patch a try and got 4 spidev devices :=20
> /dev/spidev32766.[0-3]
>=20
> root@bpi:~# ls -lh /dev/spidev*
> crw------- 1 root root 153, 0 Apr 28 15:52 /dev/spidev32766.0
> crw------- 1 root root 153, 1 Apr 28 15:52 /dev/spidev32766.1
> crw------- 1 root root 153, 2 Apr 28 15:52 /dev/spidev32766.2
> crw------- 1 root root 153, 3 Apr 28 15:52 /dev/spidev32766.3
>=20
> Shouldn't they be numbered from like spidev0.[0-3].
> Is this an udev problem ? any clues ?

You're missing an SPI alias in the DT.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--kjpMrWxdCilgNbo1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVP5U1AAoJEBx+YmzsjxAgNAYP/it3sGqNPUp3caJFMPzRrKMn
i6XM/Q6I6qQXV4fn05Tt6kK+BTVfaMHqQ7qNo2Ocpv7V8HibSkfvmWi7+5OGLJTF
Q25BhzRgbFs8PGR9KDTCXrPnJ8/nOVYhPl+CQq8vsKUEiZEhYSYS+y1EVLWTb5/e
GJmjQsak222hq/m2ZChb9juQRYQTyoH/3DOB93yfzCwjBV4DNcg/L0StFH5C0dxF
A8gxWIJEdi98wTiaF0hmxXGA3wo58D52/XJMfirhMskG0OLvXjBW2hmKJFjso65c
fEWqLCQHjc6/AdAi9fOXSt27tMNMEC91aDJ2xCl51YZgj3/DnzVMnAzm3Z9n6sfo
d58FfVLKkuuVE2e+iAFXdbxFXg9iRivM79kDFIyVX9uZpNPJPWDKo9CytthATaAO
nIKyr2UYEV37kohWxORNqFihmm7hy4YKvnkKvD/TC9Alj+pJbLMcaLDQAoBChq5f
BKqC26EqTh1zukcN8oCHugyNYDbzIIebdOLd7rPXMf6l+udqJzjJoZRks0l3pXt0
D5jZOBU9oSp2tMg7Z3slyvVahRMBvUDQHApR/BZvaCw0a+mRZAerbl9OtF98NNQN
zCKA1ru6nh1JPYPrLpZgQC7yWMT1hZVu5VJUNCd47D5BA2tlX2rcpXSUNNmiUv9s
0FnJFgKNPkfde20hP2hP
=7hU7
-----END PGP SIGNATURE-----

--kjpMrWxdCilgNbo1--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Fri, 1 Jul 2016 18:22:28 +0200
Message-ID: <20160701162228.GZ6247@sirena.org.uk>
References: <20160628183825.GS17217@sirena.org.uk>
 <CAOMqctTNmcg32PFVOZaA99GpFba9GOGOuOqmi3ujzxcHRFZsOA@mail.gmail.com>
 <20160628205736.GE17217@sirena.org.uk>
 <CAOMqctS2xGCgfXschxudcAEYq-mcfPDmFS_pTzCuXa0bFBE0NA@mail.gmail.com>
 <20160629180211.GF6247@sirena.org.uk>
 <CAOMqctR-f+dNBiWk8LEqkeYMhpvACjMi8aH3GpHY==RjfANf8Q@mail.gmail.com>
 <20160701082548.GE6247@sirena.org.uk>
 <CAOMqctRp+ua1DM82W35Df17TvhoF2suxALBaYqECWtTRrTWXCw@mail.gmail.com>
 <20160701150015.GQ6247@sirena.org.uk>
 <CAOMqctSfDKJRYf7bY7pz7LE9obUxMvV-v=Ntz3_mk0WGMKbPtA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1mpN54+oXr72ab9j"
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctSfDKJRYf7bY7pz7LE9obUxMvV-v=Ntz3_mk0WGMKbPtA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--1mpN54+oXr72ab9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 01, 2016 at 05:37:53PM +0200, Michal Suchanek wrote:

> Can you, please, specify what problems this patch creates for other users
> and maintainability?

To repeat yet again a major design goal for DT is to describe the
hardware rather than implementation details of the software you plan to
run on the system.  Not doing this breaks upgrades or changes in our
ideas of how we control a given bit of hardware.

> Without stating the problems of this solution clearly or proposing alternate
> workable solution there is not much that can be done.

You are rejecting out of hand any suggestion that is not the one
solution you are demanding.

I'm done with this thread, please come back with new code that fits in
with the device model and device tree designs.

--1mpN54+oXr72ab9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdpjDAAoJECTWi3JdVIfQPR0H+gKMT5Ok8YCkyhmokObqLRNM
W+UUv5hwBs9OskKu1Wjeeh8YxYJoEPYKef9zPXCIIr52mV1/pnTZ178Nf/VUzPWm
oH77EPkXi09vL/xm9IpivMU5rSrqa9ykf8U1/fGc96gzp3ytowx5m9agW92HygyA
Yw9ulc0OUXBWiIaRxH60REAL8iAcB9AOLv1psmQv4BKUxBvn/hkn1fQY0b7NmNdo
kYh3vsazeOnt49Vionog8c5oivbqAW1QC5+3NVaOsIHhhC033uiPwUeV7PLxBl0H
jZFBDxxa8l4OBEFGQYnSwGntNFhBo/NQKq6TiAw9WW8v3jXai3cHGLPidFMk4Xs=
=PxTr
-----END PGP SIGNATURE-----

--1mpN54+oXr72ab9j--

From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH/RFC v2] ARM: amba: Remove AMBA level regulator support
Date: Mon, 2 Apr 2012 11:41:42 +0100
Message-ID: <20120402104142.GB3172@opensource.wolfsonmicro.com>
References: <1333306720-28344-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <CACRpkdYRStgKo_e-4kZKA-V-OoMiV21jRS3R4g1Cq+4c+4=iQA@mail.gmail.com>
 <20120401212750.GE8971@opensource.wolfsonmicro.com>
 <CACRpkdbj_shuGWATGER+zxvA9MNDobGjWC3XHh+-5e0R6V4n4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Cc: Russell King <linux@arm.linux.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Samuel Ortiz <sameo@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbj_shuGWATGER+zxvA9MNDobGjWC3XHh+-5e0R6V4n4w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 02, 2012 at 12:33:20AM +0200, Linus Walleij wrote:

> Yeah ... but this sounds familiar, (searching searching) Yes! We did ask on
> the lists if regulators were proper for modeling power domains in 2008:
> http://marc.info/?l=linux-arm-kernel&m=121580531500758&w=2

> But I should've pushed for a proper answer ...

It's not unreasonable to use regulators to model the domains (or as part
of modelling the domains, I'd imagine some systems will be able to do
things to regulators as a result of power domain actions).  So long as
the hookup which might affect other systems is done from SoC specific
code and doesn't impact other systems) there shouldn't be an issue from
a framework point of view.

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPeYIfAAoJEBus8iNuMP3dM7wP/10q9MUHzhes7xv2NH2AJsJ8
PtFE1Qgu9Spk6VUZK9R77FTr1H+rXFX4+Ew/c9LKYtZBKZ2jyiAHLRjpWIzSLHYe
b2X9z7ohA884V+nRgYDjSk22vdsKYa7vMqq4wxnGCM1Ta+2GS5xIkOk/mKrITban
ugntz6dQfvS/42Q2BhFuW2seOtuX/9ppr5VhzkOQMdvNSRwTLDFZBUS5f72A5uau
X6i3+C6q+CsQeYmdl8ohdzxQAnRvUMt9inlGwCdUP3ZYXM6vDZoqoXeKCHG9M0xp
uSEgRQW4Iaq2F/EIojNipDYjxqnNPRa35UGuZ6v6W2JKnN4iyONEm4jnZ9/KPxBH
hHVBNPEYcdgd9j04i41KOv3/kP5F7ZBHNUGVBavRC1A8k0Mb1kC/K6ardWessEay
z0zOL7AL1GjJmw3l1KxnIiqISKDcSJfJbQSYex7vIuF2txP2gpYjd78IJptrHrdx
0KF5A0OZhoEfKGBtq01L3zxsioMnXhsumEfws+CTqcI1DROiXmU+9wObDlJkORmL
a+euOJ+fUR7LDULjpHjdghxoxFL5KmUjrnmNv+5UTTQs6OO39XSZ00HNDdt1saic
CAKak9lTKdE45XyY5IjxaNvtjAWbNo+7JI4jsgy5aJoyscHq54xuHgbwqJcdHEzD
A1ckpJCZ1aYDuWa6Yv+K
=tpqN
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--

From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 16/19] spi: sh_msiof: Enable the driver on all ARM
 platforms
Date: Tue, 29 Oct 2013 09:40:57 -0700
Message-ID: <20131029164057.GB6776@sirena.org.uk>
References: <1383004027-25036-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383004027-25036-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1383004027-25036-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2013 at 12:47:04AM +0100, Laurent Pinchart wrote:

> Renesas ARM platforms are transitioning from single-platform to
> multi-platform kernels using the new ARCH_SHMOBILE_MULTI. Make the
> driver available on all ARM platforms to enable it on both ARCH_SHMOBILE
> and ARCH_SHMOBILE_MULTI and increase build testing coverage.

Why is this driver specific to ARM?

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSb+UWAAoJELSic+t+oim96xwP/AhhoqqKW6Z7OgE6BKlah+Hf
9zfcpuACtbFuMrZZulhaiOVkXktTO7giI5te7WiEr+B7bDSL9k/IxJFh70iSHMu/
UYwvWYeE78QsbPjae0PLkSSxwytYstjV9GrQo2NoEKsLqiGXhjPiM8Sw1JFeFVwo
C0t4rbGamk2xZREcu1QnSOtq7mx1bfFFOqp3ZlN6WC3p0NGNvUrbsNojnOpN6DvP
ctAWNNn+hi65q2egOcY3piKWlKPjMN08lwLYQsnLGQXeBOLiZLXcLwEponN/UbKL
JfHY17Z1wiQWPZtV5iHir/XEJKc0qfPellWJTCCvTyAdsKQXBui9zMOKnTHcAs8l
yPExFcozkOdqpA/fc6ZN7yLYnk6SrpfpaLlRrRG1P6N8IFVXnFHjD6GSby2Y0YqA
TJn9Gm+AAFfByQnUiKKyDZdagzcFMShkwRkJTE0Dzpk5rSPq7q2hu8VRH6xZdJOK
GO4SnTdWnrjOMGj7HV3WvEMG8aJc8tmarTbHPNppL6BVlygFkQ9HbFM6cBHcXhwQ
RhvNKtz/aurQw8R7XlIFdRLh9gHQmBoIlp18yvMYZmY1gzivzNow0XlVNVTMm2FC
jSodBOMP0cbrhA90cGK/8o7HjraXRUwFWZtteYXhQPW7XjmgFRg/tskJlKnVdsYO
kI1iwWHsRqjtsjxCxigs
=NBc8
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--

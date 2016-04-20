From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC 1/2] spi: spidev: Use 'new_id' sysfs file for enabling
 spidev
Date: Wed, 20 Apr 2016 14:52:59 +0100
Message-ID: <20160420135259.GK3217@sirena.org.uk>
References: <1460978308-8062-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1460978308-8062-2-git-send-email-bhuvanchandra.dv@toradex.com>
 <20160418130126.GC3217@sirena.org.uk>
 <5717726C.2090302@toradex.com>
 <20160420121704.GI3217@sirena.org.uk>
 <57177FEF.8080906@toradex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zk39+mILd1OFHg5n"
Cc: gregkh@linuxfoundation.org, stefan@agner.ch,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Stefan Agner <stefan.agner@toradex.com>
To: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57177FEF.8080906@toradex.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Zk39+mILd1OFHg5n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 20, 2016 at 06:41:11PM +0530, Bhuvanchandra DV wrote:
> On 04/20/2016 05:47 PM, Mark Brown wrote:

> >The DT should describe the hardware so the DT should describe whatever
> >device is connected to the spidev, what you're trying to do is have
> >spidev bind to these new compatible strings.

> The device which i was pointing earlier is the SPI master device(spiB.C) not
> the external h/w device interfaced to it. Yes, DT will describe the h/w
> interfaced on SPI master device(spiB.C). In case of spidev we are not
> supposed to describe in DT as it is not a real h/w. The intention of this
> patchset is to completely avoid spidev in DT and load it via sysfs new_id
> file for selected SPI master device(spiB.C).

This is the problem, you've not understood what spidev is.  spidev is
providing access to a slave device so it binds to the slave device.

--Zk39+mILd1OFHg5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXF4m4AAoJECTWi3JdVIfQUCcH/35UQyFQ6ifuDqYnJSKB3VO3
o4SB7B/YZuDzKHS2Bpo3t+YUB9geV0NGn5w2lCcvAtD5Ix7+y/9lsAkXSVUCghJV
r+aNIvWHlc2Dvi+/VQdNCBJChhDDKSKvrjg/lFr1ZQavJQt1ovVsrh2qKFcWVyZD
pnMbGDiNGxDM3lU4E8vO/WBidlCuXD2441SCer7AHiy6jDG6lCPEEl2hn/7bF1tt
7Rj9rRPD+c5rqF8wt8xMyxR80iuAjLsgzlNAEmGAibYYf0nzM0EHZ5KJOqjR64qh
3ZEFnzFIIazXYNCPMMFf2QayFEIf0WJCOXm+YRUNu3ktcNTAmhKY75+5naK9TWE=
=/+Vl
-----END PGP SIGNATURE-----

--Zk39+mILd1OFHg5n--

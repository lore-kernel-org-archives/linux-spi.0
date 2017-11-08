From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [butterfly_attach] WARNING: CPU: 0 PID: 198 at fs/sysfs/dir.c:31
 sysfs_warn_dup+0x71/0x97
Date: Wed, 8 Nov 2017 12:05:07 +0000
Message-ID: <20171108120507.ajg4zcrbeykpn66w@sirena.co.uk>
References: <20171107102450.lgaujtc7f3dftvvb@wfg-t540p.sh.intel.com>
 <CA+55aFyxgvzPWiQgRjg1n-MNQe5O6xU0MtKQ9cq1OppJ-2sEXQ@mail.gmail.com>
 <20171108111750.lpr7vuhf37znxmsn@sirena.co.uk>
 <20171108115127.fpezkrqgvmatj6v3@wfg-t540p.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="t43gesyftjtib3fd"
Cc: Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171108115127.fpezkrqgvmatj6v3-q6ZYBFIlbFFi0tQiZxhdj1DQ4js95KgL@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--t43gesyftjtib3fd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 08, 2017 at 07:51:27PM +0800, Fengguang Wu wrote:

> Another option is to disable the butterfy driver in 0day boot tests.
> We've actually accumulated a kconfig enable/disable list over time.

That'd certainly avoid the reports, though it will mean if anyone else
runs the same testing we'll have to go through the same thing with them.
It is more tractable than anything else seems to be though.

--t43gesyftjtib3fd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloC8vIACgkQJNaLcl1U
h9C6Hwf9GXmHELirkpreTT04GQiqgutKIpIW1Slt10avOqlQklIKzdCXVy3Noyzs
oZstQoEFC7YJVHSLiPS+qHtjjHZW66oJKXY66S330ndWQ+qD42Lb4kBbIHpPycwO
qcU8eZlvFO1Zw5e/DgLxMT7oFiGS9lGz7PL1gPT/d9odkUU3SPHVKfxFxUgKgouf
M8xi5DzefDd7fIsXChSX2CTN3U5cfNwjtwM5RT9t4Gyqv/cq0/NxyYdpOoeZYD5h
l36nfyltE8x+hkqyHV9nN7hgyFgp2iqLbUijLcjHYSLjejPLanAvFzjLO8SPeDAX
WV+ip7+8ZZr34Foqg68gOe0s2dH4rw==
=oDUR
-----END PGP SIGNATURE-----

--t43gesyftjtib3fd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

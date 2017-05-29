From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/5] spi: moving to struct gpio_desc
Date: Mon, 29 May 2017 14:36:43 +0100
Message-ID: <20170529133643.smdiwfvcdbwsbci2@sirena.org.uk>
References: <20170525043043.1930-1-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7hcihlpxbeolayns"
Cc: andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
To: Chris Packham <chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170525043043.1930-1-chris.packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7hcihlpxbeolayns
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 25, 2017 at 04:30:38PM +1200, Chris Packham wrote:

> ep93xx wasn't as hard as I'd expected so I'm pretty happy with those
> changes. imx on the other hand has an annoying habit of conflating the GPIO
> and native chip-select so I'm pretty sure that's broken.

So, I was just looking at the list archives and I found that there's a
series that Hartley posted back in February modernizing the ep93xx
driver which didn't get copied to me so it's not being reviewed.  Can
you take a look and see if that helps with your updates to the driver?
The subject for the cover letter is "spi: spi-ep93xx: cleanup and update
driver to modern API".

--7hcihlpxbeolayns
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlksI+AACgkQJNaLcl1U
h9BsUQf/RoxiLtc1jChHYP6nbJidVPnXWBfslBqtrfem2S2aTG8hjdMRCzzu+8T2
DpDlYPUMl1aXM+wBx8IadrOICXcljhVz408IAY+7rfn1MCoNuvbtgWisdpVEvv2M
qgSPURCTM+Uj0LFjENdPdne+kSKvWH/7tNYcm12js7m34Cp+mHBuayZn7pvH2KvW
2cTkz2YoZO877RVndxMLH7bK7PWWD/o99cYMkh6L1fIhhMKRCsZcGM3MeZYeD2cu
0F4JNNSYEfslyd9Sg0r2uLRBjUarpyb2LQflH7IR0k3zHsfT1KRZi3AB8AwgISTy
Px+yYJE8g4YikUYwMklXiAGAoaQXuQ==
=7VdZ
-----END PGP SIGNATURE-----

--7hcihlpxbeolayns--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/5] spi: sunxi: Add Allwinner A31 SPI
 controller driver
Date: Fri, 31 Jan 2014 12:48:09 +0000
Message-ID: <20140131124809.GE22609@sirena.org.uk>
References: <1391165752-1819-1-git-send-email-maxime.ripard@free-electrons.com>
 <1391165752-1819-4-git-send-email-maxime.ripard@free-electrons.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iY5udFbGw2SsPZe4"
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	kevin.z.m.zh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, sunny-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org,
	shuge-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org, zhuzhenhua-0TFLnhJekD6UEPyfVivIlAC/G2K4zDHf@public.gmane.org
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBH5XV2LQKGQEG5DTFHQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391165752-1819-4-git-send-email-maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--iY5udFbGw2SsPZe4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 31, 2014 at 11:55:50AM +0100, Maxime Ripard wrote:

> +	master = devm_spi_alloc_master(&pdev->dev, sizeof(struct sun6i_spi));
> +	if (!master) {
> +		dev_err(&pdev->dev, "Unable to allocate SPI Master\n");
> +		return -ENOMEM;
> +	}

This now depends on your other series which as I said doesn't look like
the best approach.

> +	pm_runtime_enable(&pdev->dev);
> +	if (!pm_runtime_enabled(&pdev->dev)) {
> +		ret = sun6i_spi_runtime_resume(&pdev->dev);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Couldn't resume the device\n");
> +			return ret;
> +		}
> +	}

No, as discussed don't do this - notice how other drivers aren't written
this way either.  Like I said leave the device powered on startup and
then let it be idled by runtime PM.

--iY5udFbGw2SsPZe4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS65uGAAoJELSic+t+oim9eagP/1uZeSFrHuaHL6Pc/qQWV49j
vlm+fMGJFyXTkpTCSw4g/99UG4r6Tei+eoQQZ1f0FGeDCruWU+RPaN1sVtiEyfYm
srDRaS5DLjrYAki+1XiRHCegaNvcbDyaHsZVriEnw2d2Ck0FI/AEjULz8eDSPMb2
5ZU0rTW+mFweTXjbGdQJjnBV/Q1K7qzbK/ZdGN/nGCcsOKdTN9Pb77Lf+S57AqZr
KXwEfbQqlVNR2oMekrQ/nXNIjTU35yLRj+efBS21atRZur6d0RxFeYIvXfdWC0xb
DY1ramrodT4mUX8fHxq9oW4j/l+pEmd3PgIpLh7xaaEPet52ymQZmK/TvDubg4IT
TDPvV5aW6bHDykUQRNgMbuByH9Nj8SOkR5+W8tSKZ1QTcUsvo0M9nGftipHWBks4
m6hPjy1keC7G+/c5H/f+gv10L1lYAZUTcW7lHyeN1gimaCoo8Fu6cKdw+pj+C6Wo
dYaCwd8pH6cjtUxb8OAvbCBTyW+Tm5T/X+cFJpQqu6J99jcoRk2uzei1iJNqMZGd
Jgu6cGcO5GaT1liBbBezNIOI9wKZmjwODnXE4FMZeNkA1tQg1TSJLq91cf5EeP1R
i/+A+FYfkgV0uatpyV9LyhVj4zXSBwrfDb1iFJL8eTNddVuQ/C1Wg7Moz1PQme6c
NfHWSJ3HNZfZdF/bZ6M6
=nU+u
-----END PGP SIGNATURE-----

--iY5udFbGw2SsPZe4--

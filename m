From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] Add devices to spidev device tree compatibility list
Date: Fri, 30 Sep 2016 09:08:32 -0700
Message-ID: <20160930160832.fnnvxkwdh5ex4xqt@sirena.org.uk>
References: <1475230554-5986-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vp3ng6iqfzgtthk4"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabien Lahoudere <fabien.lahoudere-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1475230554-5986-1-git-send-email-fabien.lahoudere-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vp3ng6iqfzgtthk4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 30, 2016 at 12:15:54PM +0200, Fabien Lahoudere wrote:

> - "fsl,mk20fn1m0vmd12" : a cortex m4 based chip

> +	{ .compatible = "fsl,MK20FN1M0VMD12" },

This compatible is in uppercase which is not the normal style for DT
bindings at all.  I'd also guess that this is a binding for a specific
application running on this device rather than the chip itself.

--vp3ng6iqfzgtthk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX7o3/AAoJECTWi3JdVIfQMFoH/2xU+jKtWZ+qDdvst92rCc7l
VWcpuDKsXHV8/qEnTADWWyyNSxTRTebvjFRKVkYkCrRLoUqTKTuTiVt8cyEsbddZ
xz7UPOtlY65pnFtClkddTjm0YJ2GK+8eLpmEeBpq/9gvtcKMKzTTEKDCk8m/g7bV
/g3W9ll0eWbcIXUWQhR1t3ysg4zAqEY0xCaIQ2fgFW19K8p9xmyP+4mWjSK3YFJe
ttgrwGcglRidQaANmx3yP3Huw/fwF3GQz574zGJ8dwVZ/fYlyffW6v0tSabOLwAP
3IpANR02cmKiBDiM8uFMk+XDL4v7nUM5LtIQ0HNCOwj1s1WSkzQr6D7I+Ry33bo=
=BCFu
-----END PGP SIGNATURE-----

--vp3ng6iqfzgtthk4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

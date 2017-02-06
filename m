From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 3/3] spi: acpi: Initialize modalias from of_compatible
Date: Mon, 6 Feb 2017 16:31:48 +0000
Message-ID: <20170206163148.sl7xoefrxjw3i3na@sirena.org.uk>
References: <1486195228-10929-1-git-send-email-dan@emutex.com>
 <1486312214-20770-1-git-send-email-dan@emutex.com>
 <1486312214-20770-4-git-send-email-dan@emutex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kzxie6xrpilthtcj"
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1486312214-20770-4-git-send-email-dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--kzxie6xrpilthtcj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 05, 2017 at 04:30:14PM +0000, Dan O'Donovan wrote:
> When using devicetree spi_device.modalias is set to the compatible
> string with the vendor prefix removed. For SPI devices described via
> ACPI the spi_device.modalias string is initialized by acpi_device_hid.
> When using ACPI and DT ids this string ends up something like "PRP0001".

Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--kzxie6xrpilthtcj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliYpPQACgkQJNaLcl1U
h9CeLQf/bXWk3S1vf4ttePrXbgFgQK4Z3E6yqBwQ+e42gW9K3XsmRthDfe/Mowc8
q1+pBzU/EZylKYFZMLkVQc/PfM3GEth8Jdm+D+Jum0VVVFHHiFmJ2hqYdaSTe/zr
/KCdQtvNjNi7ik0TySfNpWPqE7o7gP/gGXCMcgbRwzQQkW2FnrpJJIrV/du0HczY
LyZ4ioJNwF3CWdnPonWrN1/a2qZaz0KVKhucDL7GWINEY1hXWdum+O7s11NyjSWY
8QsIIR+ZayYwHJeYQIpkm2Q7qz2oy0qBdkQ1PIzv39Ny0FBkkWfy2OC9+W1scu23
wSMHcU6FrDWLOe+cQGFBYMv8pWy7vQ==
=ml/y
-----END PGP SIGNATURE-----

--kzxie6xrpilthtcj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

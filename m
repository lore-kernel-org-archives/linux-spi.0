From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 7/8] tools/Makefile: minor whitespace cleanup
Date: Tue, 17 Nov 2015 18:09:24 +0000
Message-ID: <20151117180924.GZ31303@sirena.org.uk>
References: <cover.1447773299.git.stillcompiling@gmail.com>
 <155366ac799345f42c8c342609ffa11b2df529b0.1447773299.git.stillcompiling@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8M+BMcg+0CmQ2H7L"
Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>,
	Adrian Remonda <adrianremonda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <155366ac799345f42c8c342609ffa11b2df529b0.1447773299.git.stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8M+BMcg+0CmQ2H7L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2015 at 07:24:27AM -0800, Joshua Clayton wrote:
> Signed-off-by: Joshua Clayton <stillcompiling-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  tools/Makefile | 37 ++++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
>=20
> diff --git a/tools/Makefile b/tools/Makefile
> index 9a617ad..428fb4d 100644
> --- a/tools/Makefile
> +++ b/tools/Makefile
> @@ -80,10 +80,21 @@ turbostat_install x86_energy_perf_policy_install:
>  tmon_install:
>  	$(call descend,thermal/$(@:_install=3D),install)
> =20
> -install: acpi_install cgroup_install cpupower_install hv_install firewir=
e_install lguest_install \
> -		perf_install selftests_install turbostat_install usb_install \
> -		virtio_install vm_install net_install x86_energy_perf_policy_install \
> -	tmon
> +install: acpi_install \
> +		cgroup_install \
> +		cpupower_install \
> +		hv_install \
> +		firewire_install \
> +		lguest_install \
> +		perf_install \
> +		selftests_install \
> +		tmon \
> +		turbostat_install \
> +		usb_install \
> +		virtio_install \
> +		vm_install \
> +		net_install \
> +		x86_energy_perf_policy_install

This isn't a whitespace cleanup, this is a substantial reindentation of
the file :(  Please ensure your changelogs are accurate and in general
try to avoid mixing this sort of invasive stylistic change in with other
patch serieses, it reduces the potential for conflicts.

--8M+BMcg+0CmQ2H7L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWS21UAAoJECTWi3JdVIfQxCAH/AmX9MPAGq+lttd7YxAFVIXl
paQEcn1+dVusm1s7H79u9kUeT/ySBmfo+pvvnJUqTXUA3wwJxn2IHyQzD5J4RI0/
ED2qqEOpmXKiZv6X2xYF8KbE1IqMaWZ/7Osdhowib49ULOTNMKwhbxiiA7LHmp86
DUOaE9+bOjXg4Xv8K/xVTz9cFZ8eofvkrZXvNvsp9QrktIWPbLrM6xI1bYs8ooS/
G18Uiqp5yhseEfNVou6h3pOIWjJKx7kg18SR+KbgHCJ1xSWXG0MmDcB0AUTRm2MS
Y89SHfjghBgCLgU4DZrD5qGVUHwz4JOk+k2mUItoeKFR1bKHse4ua2ib3ZLxOjA=
=9qe1
-----END PGP SIGNATURE-----

--8M+BMcg+0CmQ2H7L--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

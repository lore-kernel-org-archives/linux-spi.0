From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] dspi: config dspi master regmap with right mode depend
 on BE or LE
Date: Wed, 13 Apr 2016 15:06:57 +0100
Message-ID: <20160413140657.GT14664@sirena.org.uk>
References: <1460545402-8162-1-git-send-email-po.liu@nxp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0WGqsT62A4RTsSXf"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Po Liu <po.liu-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460545402-8162-1-git-send-email-po.liu-3arQi8VN3Tc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--0WGqsT62A4RTsSXf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 13, 2016 at 07:03:22PM +0800, Po Liu wrote:
> When kernel config with big endian mode, spi master need
> to config regmap data value to be little endian mode. Or else,
> the kernel boot will hang.

> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +#endif

This should be unconditionally set to native endian if the IP changes
endianness along with the CPU.

--0WGqsT62A4RTsSXf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDlJ/AAoJECTWi3JdVIfQBloH/0q+2DGONd1uBlLQGKzLQs24
czHadxnfek4wgfc0+gE5sWIeX9xl31gqQNSQVbMcReqYD4oHGulkGWlaAQKqUKbY
fKaMkcXluXBcgMtx53OAFvKIuavafujywfpKzEaxBiKQj05oFkGiENL3vVso4cMr
/XHUSuW1MNmvOPuJEb189KvHr5cNdAl3k2DwF5DDYrsuerVbQ/ddRhdy/rdDiM+z
r8QFMeowaNvGb81BX0pbinXHHTzLjcX6BUfuMvG2UVmK/CunorgLBZPhtxodQLEN
Yy9vmovEpNf3fF+QLqoo3JgB+D5ouIZO4H3996V/gZR3wJiSzbB7ZGyCiUTSkZQ=
=Z+Tn
-----END PGP SIGNATURE-----

--0WGqsT62A4RTsSXf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

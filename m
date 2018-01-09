From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv1 1/3] dt-bindings: spi: Add DT bindings for Synquacer
Date: Tue, 9 Jan 2018 16:44:15 +0000
Message-ID: <20180109164415.GE11471@sirena.org.uk>
References: <1515503383-8909-1-git-send-email-jassisinghbrar@gmail.com>
 <1515503432-8971-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LSp5EJdfMPwZcMS1"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1515503432-8971-1-git-send-email-jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LSp5EJdfMPwZcMS1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 09, 2018 at 06:40:32PM +0530, jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org wrote:

> +- socionext,use-rtm: boolean, if required to use "retimed clock" for RX
> +- socionext,set-aces: boolean, if same active clock edges field to be set.

What are these and why are they configurable?  The active clock edges
thing in particular sounds a little like it might be related to the SPI
modes?

--LSp5EJdfMPwZcMS1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpU8V4ACgkQJNaLcl1U
h9DTMQf+P2m5eBQbWjEb1w8QqkD8h27UqvVEYRmcdZDXZ7Uk8P72uxMcxrATqerz
onlhm4G4O5GB43YW1ZBrYfMG1jzokHZsLTgBKGrns+q9WP5OpO1eKRtI549lpXCY
k/dDq1ggrSiATHoiaPDBfkZbVSKUBXskr0SRUKQ8bfPBljUTaIfMcgiaC4TRD7Bc
KNfZbklYfuERTNjY00pRGtL4QdXGeMXoD/mLJNl7EyBOAqAJc+80qX1DS3C9Uql/
3KWbBXoiqXt8rkU142IRZQ8v3Qjuh8TPvk4y07XgF4A/8+dNQXDqTFFzrSjgSFxi
orVGmrRGY02te5R7DyLk9dnCLiaMew==
=b18O
-----END PGP SIGNATURE-----

--LSp5EJdfMPwZcMS1--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

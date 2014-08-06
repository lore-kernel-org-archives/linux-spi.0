From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Fix warning about redefinition
Date: Wed, 6 Aug 2014 18:56:31 +0100
Message-ID: <20140806175631.GI17528@sirena.org.uk>
References: <1407344128-9754-1-git-send-email-xerofoiffy@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vdyEe3aauNFvjM8k"
Cc: "open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Nick Krause <xerofoiffy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1407344128-9754-1-git-send-email-xerofoiffy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vdyEe3aauNFvjM8k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 06, 2014 at 12:55:28PM -0400, Nick Krause wrote:

> +#ifdef WRITE
> +#undef WRITE
> +#endif
> +#ifdef READ
> +#undef READ
> +#endif
>  #define WRITE 0
>  #define READ  1

Please think about what the effect of doing this is and look at how
other similar problems have been addressed - the goal isn't to shut up
the warning, it's to fix the problem the compiler is trying to tell you
about.

--vdyEe3aauNFvjM8k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT4mxMAAoJELSic+t+oim9rBsP/iBlgIW3zoVGmL3CCtGwbDTS
MkG48W1fdTCB0bhAAe3Yg6G36Oe6Gv4tvMIB/IJNdtFNr2lutX3BGdxucAn6w3YR
vPkpy0QysdSzdFzy1vunrSFuAQpUswPL081olwbyD/iFmOsHSL+Mbbqu8p2T58Qf
W3Jkx+vvVXnZNyEUravKn9cjuymLcb9zNWBTfiVAuKiMFDUdC+JDJwyjSOFjRMfk
sUtTWuj0T5YUWHcul3KR8rMDWxSzFdh2Exduo7f029XflkCVZ4j9x/WjDNdhZus/
14ecQhl4NsiaalEzEDpVkVpBHoiNVCtHW7yKeFopT6LKbFGmBpPUlnp0bkhjzXYZ
AIiDO1KDO4dAw6to+hbP+XR7p8UtDl4eiXoak/iAEc+p+q0KiuOm9h3mK3HDBxU/
eEdAtHcCENbJYFi9BddSe+SjbxX262x5Zd7M1kvThRWXnUqHPK1jOSVpkDR9MRq/
/HJfyjn902oKtrdljYREnUrkJwUmv1ifdIElq92M2ggjAGz6LBsBEGLm3SRy+AJD
5b3NYwk1LmPky1YDEMxecAv9UTVi9t6TfC1p15cBstNLH5RfukbJKN8P/ETxpfS+
EZW3kg4fF+cVljB4AiLNKas6mPHEzkSumWNBh5VisDtvFRNUm08kvZCGT5P5h6bj
z/bMjhCPRon3pcwhIIU0
=9TI1
-----END PGP SIGNATURE-----

--vdyEe3aauNFvjM8k--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/2] Fix issues in Armada-3700 SPI controller driver
Date: Wed, 13 Sep 2017 11:12:55 -0700
Message-ID: <20170913181255.qzijnrnr4x5336a5@sirena.org.uk>
References: <20170913162139.17598-1-miquel.raynal@free-electrons.com>
 <87o9qeh5w9.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="73zsebzyeuvbgkcc"
Cc: Miquel Raynal <miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Antoine Tenart <antoine.tenart-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87o9qeh5w9.fsf-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--73zsebzyeuvbgkcc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 13, 2017 at 10:20:38AM -0700, Gregory CLEMENT wrote:

> Mark, could you amend the patches with the flags that will be provided
> my Miquel? Thanks, to this the patches will be backported to te stables
> branches.

No, I've applied them already.  The second patch looked too big to be
stable material.

--73zsebzyeuvbgkcc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlm5dScACgkQJNaLcl1U
h9BzIwf9EKIAWHIc7cH6es/UdKsWaMRlcVnhK56SdsABBxmOQC8Ot8HuRYC4Ei2t
C+0GFuIcQbvVzse/FM3C8RwMQ+6ik16HQPUTpgVOvvLUA8Q37bWHLmb8s045KHrD
+5UcjZNGYJxEzA3hawH3aibw2u5xsurqYGQP6Y/EuGe49gDq86YQqVGxm6CWrDFp
hkzky3XYATm4jWyEYXAsFp6ZjEpzLFGI0c9qLgHNc6fxjZCjGd8nuAp8sljnj96u
ocaMj2BVXTw/vdG7SRUXXlc3dM6GPWsj8A93BfcI7FNZM1l/d+TYjFjc1SozE+36
Dim58MaPd4pgiZWpdaRvsuxF63etNA==
=fDHK
-----END PGP SIGNATURE-----

--73zsebzyeuvbgkcc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

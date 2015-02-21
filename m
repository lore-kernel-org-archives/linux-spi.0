From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: imx: Chose DMA bits per word transfered
Date: Sat, 21 Feb 2015 23:35:28 +0900
Message-ID: <20150221143528.GU6236@finisterre.sirena.org.uk>
References: <1423742848-15369-1-git-send-email-a.bouin@gmail.com>
 <1423742848-15369-3-git-send-email-a.bouin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9AazSAFPVKSPmRXK"
Cc: festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aurelien BOUIN <a.bouin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1423742848-15369-3-git-send-email-a.bouin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--9AazSAFPVKSPmRXK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 12, 2015 at 01:07:27PM +0100, Aurelien BOUIN wrote:
> This patch enable to give a parameter to device tree to set the number of bits per word the DMA uses in transfer
> In device tree you can specify fsl,spi-dma-bits-per-word = <16>; in the ecspi section

Why would this be a DT property?  It seems like something the driver
ought to be able to figure out automatically if it matters.

--9AazSAFPVKSPmRXK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU6JewAAoJECTWi3JdVIfQ+6EH/RvcMgWfEYbif9rJbqegb33o
BSPSNp+IaLOo+4TBIupXKXgzYLLuVCK4dQa+s3OuAt8f5kd+Saly9WdV8K3hllJB
FVcgFfP4qTtq74n/8kirhCv8v9nVe/3kN4WEzGXAGdvoLU3Nu7UAJQgT9CYSg4uw
krTFeQQl6TJT0GSTU3aCK/+nny2RNlWxiQjaZ8MxGaoIr8MIPLfFsejo9eyG5Vey
zHM2yQYo51QzPsy3sNuMPyD79HXhP4ih6oz9z1ObmkI32q9LHxae2iGuxLQ9yvPb
/KzRh1Ezfi61UZP3WFLdZaEFcdUxStZ8wMilG2Sn4yHuLhCnrxHIpsa+AZWsa+I=
=7otB
-----END PGP SIGNATURE-----

--9AazSAFPVKSPmRXK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

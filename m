From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH v2] spi: add spi controller master
 driver for Blackfin 6xx processor
Date: Fri, 21 Jun 2013 10:57:28 +0100
Message-ID: <20130621095728.GN27646@sirena.org.uk>
References: <1371583828-23788-1-git-send-email-scott.jiang.linux@gmail.com>
	<20130619183928.GE1403@sirena.org.uk>
	<CAHG8p1C0DjPt_vNiqYtkVUWYy4M-doj50K1MAEocPs+AkXdhPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4476046533025970179=="
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org"
	<uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <CAHG8p1C0DjPt_vNiqYtkVUWYy4M-doj50K1MAEocPs+AkXdhPw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============4476046533025970179==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EqVOK5mkaJAMmtSx"
Content-Disposition: inline


--EqVOK5mkaJAMmtSx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 21, 2013 at 12:48:42PM +0800, Scott Jiang wrote:
> Hi Mark,

> >> +MODULE_DESCRIPTION("Analog Devices SPI3 controller driver");

> > Why not call the driver something like bfin_spi3 then?

> Do you mean the driver name or file name? It's the same with spi-bfin5xx driver.

Both.  What happens when someone use the IP in a different device, say
bf7xx.

> The test script may use the same name for 5xx and 6xx boards.

That sounds like something it's not impossible to fix...

--EqVOK5mkaJAMmtSx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRxCOFAAoJELSic+t+oim9bagP/1kDBBpM8Npv/wRWnFGmYw1w
UExKzVPOPPqzlAaxarN5nkQ1/DOdRTfnarpDoQp6FB/8lBUI2OorF9ihWRxPz2pT
U+ZPcAt59H8ljHfnf5L6sIwyqLfXD/d6wchEGgiUSppPM3r97QGUE92vxEF8qBd4
2JUIqWde7WsICWv5vNrD17xLHXKbnqmjtnC4IpY6AAE5aY/3bRmo27xweD03U3DZ
aNRaC41U/TIZgDxuPRP8XnYFjt14qvLvRIcO9dShvYqP51R/j8kSzO3SdR2AJOFO
GhaPYZT33Hcy1FDBfoQtRuSSoyFc/ZGihv67ELcz1rnrB3lHS10MKZBvp3Wfv3cr
cF0my2sV67wDIV6DzqP4wAfYksgMcCf+f8eSvDTqaUIYNbVPfOmDD6hS3+I33aaV
Yma3f2O9+glsuw5pTLSnJbpZferSD4ugdN0f6lbPFRDDXSokXC7xj7nwpduzNCce
Fi7MhZz8+CG93AlaxxmI84KCac9tql0vMycsdRhsHmI/6vLSSIIhTSACjc25N1Q2
26saL2d++rHYWG09F4PRzexAGDZox4LlGGbXkS15GeSlGSMfcFMPYD+9TUlj1t+4
V71S24S2VqB0Bca1bNXwzg5bIDekBDANMpuAK+D91mahWewOGdme+zLY9aqwNX5h
C9Ytv74JHgen1jq/4RBb
=YHfp
-----END PGP SIGNATURE-----

--EqVOK5mkaJAMmtSx--

--===============4476046533025970179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Uclinux-dist-devel mailing list
Uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel
--===============4476046533025970179==--

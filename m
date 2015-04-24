From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: fsl-espi: fix behaviour for full-duplex xfers
Date: Fri, 24 Apr 2015 19:17:45 +0100
Message-ID: <20150424181745.GG22845@sirena.org.uk>
References: <1429111398-21444-1-git-send-email-jonatas.rech@datacom.ind.br>
 <20150418125556.GR26185@sirena.org.uk>
 <363371145.339730.1429715343024.JavaMail.zimbra@datacom.ind.br>
 <20150422195746.GM22845@sirena.org.uk>
 <20150423180622.GC12637@datacom.ind.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uIEElZ5lEmatLCfT"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Jonatas Rech <jonatas.rech@datacom.ind.br>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150423180622.GC12637@datacom.ind.br>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--uIEElZ5lEmatLCfT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2015 at 03:06:22PM -0300, Jonatas Rech wrote:

> I agree, but please note that this came up while I was trying to fix the
> full-duplex functionality, and it's a different problem. Fixing this would
> impact protocol drivers, as stated earlier. It would take some time for me to
> study other drivers and come up with the best solution for this driver plus
> (at least) the m25p80, which supports the hardware I currently have access to.

> I know this must be fixed, but wouldn't it be subject to a different patch?
> Thanks in advance for the advice.

The commit message says "this correction has exposed an inconsistency"
which suggests that the problem was masked before this fix.  Did you
mean to say that while fixing this you noticed a separate bug that's
present anyway?

--uIEElZ5lEmatLCfT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOojIAAoJECTWi3JdVIfQ2d8H/RQ3pr1M71aSUqJkwMNnHC5U
ybabdFShQW8l439+/2QSzdAgaY394E/68E9gOT9BlIkY+ub7iEUrcJ+skh5P+At+
1qmbRve0/7ya6fZcdPnIBRRY1DOCjn99ni9JA05YvCNRBtb3m11Rkn9ObplPyhoA
+QVKpDgEbCFpOnyX/nxpaAHkzN9EXr+DcSBxnGbBYTUBCRIm1SJ/po55qKTjvPsc
XGXVirosOeeCtrXmEAbIB4I7cKgwdZl5lXOjX4HSF2ypdq2MNQL+Avj/ZWCyjxtn
jZh5AhjK9lHBHFgPXdV9XiSXMCwpnlnRSkso8GxmpdbdvZAAN3gmIo+pt+dr0/Y=
=wpu/
-----END PGP SIGNATURE-----

--uIEElZ5lEmatLCfT--

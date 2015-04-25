From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-espi: fix behaviour for full-duplex xfers
Date: Sat, 25 Apr 2015 14:01:24 +0100
Message-ID: <20150425130124.GF31708@sirena.org.uk>
References: <1429111398-21444-1-git-send-email-jonatas.rech@datacom.ind.br>
 <20150418125556.GR26185@sirena.org.uk>
 <363371145.339730.1429715343024.JavaMail.zimbra@datacom.ind.br>
 <20150422195746.GM22845@sirena.org.uk>
 <20150423180622.GC12637@datacom.ind.br>
 <20150424181745.GG22845@sirena.org.uk>
 <20150424200326.GA14443@datacom.ind.br>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XIiC+We3v3zHqZ6Z"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonatas Rech <jonatas.rech-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150424200326.GA14443-rCUF4CxDseZknzVnJbg3IA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XIiC+We3v3zHqZ6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2015 at 05:03:26PM -0300, Jonatas Rech wrote:
> On Fri, Apr 24, 2015 at 07:17:45PM +0100, Mark Brown wrote:

> > The commit message says "this correction has exposed an inconsistency"
> > which suggests that the problem was masked before this fix.  Did you
> > mean to say that while fixing this you noticed a separate bug that's
> > present anyway?

> Exactly. Besides fixing the full-duplex capability I reorganized things
> inside the main loop so that anybody can spot where the extra bytes are
> being sent, but the code works just the same as before in that respect.

OK, please be clear when writing changelogs - it makes life easier.

--XIiC+We3v3zHqZ6Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVO5AjAAoJECTWi3JdVIfQ5uwH/AsR2TeDpgNGcG7oASpbx+X0
nTMDnskjHZTJ8l3Wqz5VeFe7mL9wdJZmj7El1mBLlX+j5WT5WjJ4UJJgseEr+1aL
Dbn8nhPH7In30UjRWugV9/LZJJ606VzabRnJ2BGq6cWBRg5fwnSXMl09JM8L3rjq
qvN4SZMpgPfaNoqYWVUQ75G3TYeEYS+Kz+vyZnx/ixLDwegG9WdaI8ZNJcUPejtR
0m/WhCMktt3MjcG+Eg9I4x5rco70HFMVZkJe8suir+6NfEGqDSZiPN4rZBrg59Wg
qZSvyzlmkP/29W/4UfOb0G4mzqrrZS92UH/lquBKSzTABhijr3EijfB7r2nIIhY=
=wxuZ
-----END PGP SIGNATURE-----

--XIiC+We3v3zHqZ6Z--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

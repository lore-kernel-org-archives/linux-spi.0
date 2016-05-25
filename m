From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Wed, 25 May 2016 14:08:18 +0100
Message-ID: <20160525130818.GY8206@sirena.org.uk>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524174140.GE11605@leverpostej>
 <5744BC76.9090403@gmail.com>
 <20160525092034.GE1337@leverpostej>
 <20160525103810.GU8206@sirena.org.uk>
 <57458A64.2090901@weinigel.se>
 <20160525123423.GL1337@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AAxWdR3COjAeVN+/"
Cc: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>,
	Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160525123423.GL1337@leverpostej>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--AAxWdR3COjAeVN+/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 25, 2016 at 01:34:24PM +0100, Mark Rutland wrote:
> On Wed, May 25, 2016 at 01:20:04PM +0200, Christer Weinigel wrote:

> > Does everything have to be so damn difficult?

> With the varied hardware that exists, and the constant expansion of the
> set of things which exist, there is very little that is simple any more.
> Things which are simple today can become alarming non-simple tomorrow,
> with only minor changes. So unfortunately, yes.

> I appreciate that it can feel like all the feedback has been negative,
> and that can be especially annoying given that you did not write the
> code in question. Please be aware that we are trying to work in your
> best interests, along with the best interests of many others who are
> using this code and binding today, or may in future.

> Specification work is a difficult, tiring process for all involved, for
> anything meaningful.

Right, this is one of the costs that the community decided to take on
when it decided to move away from platform devices to push everything
into DT as an ABI.  Things that are fine as platform data internal to
the kernel aren't so good as OS neutral ABIs.

--AAxWdR3COjAeVN+/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRaPBAAoJECTWi3JdVIfQ0LMH/iA2e3jH9L01airvUMPoDq4o
C0bGcWZAvtGw93Ca5mF1Egx+bpP9Zs6A4yj8VrLp+jW5paiL6brEkx0si8ckXX/t
3hqkSWQAz/nPHNZrDTmbhm73sLSnwVY8bG8UN78P6/v2r40HRS15dDUG13ZWGRJT
zUlY3MjJJVEx8PahKLTxhtCxB7sdqcZgMtpEi17tvGkdODeVFAj9R86+nYkI/YPd
kEGgYueObh6i3V4ulLiwjwRPIJ3iJqKsQZU0fZZ3zAVv378OlmVbFIrh1K3Qorjs
/pTFrp/XO3qYx3ASygRI2QuXblFTDH103QwDUaO2pBsaNhm1WMl7xN4d1Y4CCjg=
=LWdx
-----END PGP SIGNATURE-----

--AAxWdR3COjAeVN+/--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

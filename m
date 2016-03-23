From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion.c: Add direct access mode
Date: Wed, 23 Mar 2016 13:27:32 +0000
Message-ID: <20160323132732.GN2566@sirena.org.uk>
References: <1458663893-13766-1-git-send-email-sr@denx.de>
 <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de>
 <20160323113316.GH2566@sirena.org.uk>
 <56F2852C.5010006@denx.de>
 <20160323125448.GM2566@sirena.org.uk>
 <56F295E1.4030505@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E1kmbH3dIWlEOf9A"
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56F295E1.4030505-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--E1kmbH3dIWlEOf9A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 23, 2016 at 02:10:57PM +0100, Stefan Roese wrote:
> On 23.03.2016 13:54, Mark Brown wrote:

> > I haven't looked at your new code at all.  What I'm saying is that
> > specifying a per-device MBus window seems like pointless complexity.

> I don't necessarily share this opinions. Code-wise, its less complex
> that re-configuring (removing the old and creating the new) the MBus
> window. But I have no strong feeling here. Whatever is decided that
> should be used, I can go with.

No, really - it's just unhelpful.  Putting this in the ABI means that
every single system integrator who cares about performance is going to
need to go and manually figure out how to configure this in DT and
manually select values.  That's not doing a good job for users, it's
making their lives harder for no gain.  If there are no physical
constraints then how we allocate space in the MBus should be a runtime
thing, it shouldn't be part of the ABI.

--E1kmbH3dIWlEOf9A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW8pnAAAoJECTWi3JdVIfQXKYH/j2r5QkR4yr9Dl20J2RLUgY8
7m7yvBx1xU+q9bzTd65OUFjmAqF1Wz1KIzANi6C1DDaeFoubbJmJ60+cNMqB6lUl
F0zkAcH63H94EUtGVXf6i6JRr3M4FBl3Xpvu+rRH6cau3L/cQuwzw/8RvShD6etT
Pf8ZBoIsA/loX1NGvnAi1tCfzBHy6wGY+7Wnl75QYiB2Z4AJoOp5HpdacczY4EnL
HtAkgqGLx+6smpJVHwitYqsALtlDGes8rDlvMjD8xsA4S3mGo7aWeGNOPQDA7iWF
zM7V5cRX2nd1nDKbFXbn7Dq9j73PgYJWVgUUChFfQDS1nGBNOf8Keq2LFCgTlSE=
=0Pf2
-----END PGP SIGNATURE-----

--E1kmbH3dIWlEOf9A--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

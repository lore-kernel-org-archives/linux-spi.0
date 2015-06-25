From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Fix per-page mapping of unaligned vmalloc-ed buffer
Date: Thu, 25 Jun 2015 17:12:13 +0100
Message-ID: <20150625161213.GU14071@sirena.org.uk>
References: <1434351560-29463-1-git-send-email-andrew_gabbasov@mentor.com>
 <000001d0af39$e499dd70$adcd9850$@mentor.com>
 <20150625140054.GM14071@sirena.org.uk>
 <6C5EA58090A5ED459815C4D04C2B466FF82082B4@EU-MBX-03.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K30cfNVc8Txg/TJP"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "Gabbasov, Andrew" <Andrew_Gabbasov-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6C5EA58090A5ED459815C4D04C2B466FF82082B4-Codg+kbhZ4/nlEkxMdpx1dQH9K4/4qFeAL8bYrjMMd8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--K30cfNVc8Txg/TJP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2015 at 03:57:50PM +0000, Gabbasov, Andrew wrote:
> > Please don't quote entire messages, it makes it hard to find any new
> > content you have added.  If you want to submit a patch for inclusion in
> > the kernel please follow the patch submission process in
> > SubmittingPatches.

> I did. This patch was sent to linux-spi mailing list twice (June 1 and Ju=
ne 15),
> and only after getting no response I asked the maintainer. Sorry if it's =
too early,
> but I believe the existing bug should be fixed. I'll submit the patch onc=
e more.

SubmittingPatches says:

| 5) Select the recipients for your patch.
| ----------------------------------------
|=20
| You should always copy the appropriate subsystem maintainer(s) on any pat=
ch
| to code that they maintain; look through the MAINTAINERS file and the

which you haven't done.  If you don't send patches to people they won't
see them and can't review them.

--K30cfNVc8Txg/TJP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVjChdAAoJECTWi3JdVIfQ26kH/27q1WNBlntBVf911U/QxGBC
RgnZea5iRt0DQrVUdf5Az0YE1j41EYFzYYjIMq6ojxtTSe54sY0bbgjf5ZieAW5D
5YR45uX2GKgV8gYRH8jRYvd4hHaqQLSrR8LGywwPZvjJSI0QSnjPCYqvyJTrQB16
9kPxjlOjLgUYTJQmT37u1UrZDBnWVaNVSmz4kSM8Maq6ABxbUWQUXazxXtalgSNb
URgwS+hzqcB1mxAIgPc9ApMqRrizkOoic2hQGGHPX7zTM6W0gv/8levQiax9TDjg
NNpcgjEuM5x/Iz/+tCG87ormXQr2kWXyTU+tuP+eAOCu+JM4g3xxG1eJH+a9jqI=
=VzPg
-----END PGP SIGNATURE-----

--K30cfNVc8Txg/TJP--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

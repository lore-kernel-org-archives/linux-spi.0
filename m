From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: add check_finished() callback
Date: Sat, 4 Feb 2017 16:37:31 +0100
Message-ID: <20170204153731.vspkf57eap7gpoqj@sirena.org.uk>
References: <20161211200350.13590-1-hauke@hauke-m.de>
 <20161211200350.13590-2-hauke@hauke-m.de>
 <20161214152156.uehjhqoxpng47pnh@sirena.org.uk>
 <7b420e94-3c33-3304-f7a0-ed87c8db425a@hauke-m.de>
 <20170110123429.t6vsyqtnavranbdn@sirena.org.uk>
 <1d4bfe6a-c5a6-8fd5-310b-748413f7c946@hauke-m.de>
 <2b2776c7-4322-e5c7-e169-7d60c1830518@hauke-m.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wpnwuhimvbz57qwv"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2b2776c7-4322-e5c7-e169-7d60c1830518-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wpnwuhimvbz57qwv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 04, 2017 at 02:45:57PM +0100, Hauke Mehrtens wrote:
> ping Mark,
>=20
> What should I do in the driver now?

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

Please don't send content free pings and please allow a reasonable time
for review.  People get busy, go on holiday, attend conferences and so=20
on so unless there is some reason for urgency (like critical bug fixes)
please allow at least a couple of weeks for review.  If there have been
review comments then people may be waiting for those to be addressed.
Sending content free pings just adds to the mail volume (if they are
seen at all) and if something has gone wrong you'll have to resend the
patches anyway.

> > I can add the transfer status in some other way, no problem, but how do
> > I tell Linux that the transfer finished when it really finished. I also
> > tried to just ignore the last word, but when the controller is
> > configured for the next transfer, the old one gets corrupted.

As I've now said three or four times this sounds like you should use a
workqueue or something similar to do whatever is needed wait for the
hardware to finish whatever it's doing.

--wpnwuhimvbz57qwv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliV9TgACgkQJNaLcl1U
h9AMYQf/USLxBtzMkJP+YtXV4tQ6bfeQqwTiXTWYzHj616cM94jYIPLZStaCmxT1
+ZM2Vh6zMcBOQ+41xejVPHADnAG8Ifrf65LeKW8PcEPpEqcI4myPtTAbo3OTDEpm
HFbxR5WAbejcXUpLKFlDvC1Plt7+t9wkpNLh+TIcw6cnqwyzvgfYGVQJyvo1DEwm
TelYOoFuZZoLq1aUr1Pl2vPVA0oc+BKW5U9pKo0ZtOUigcCk9049xmodvreo5YQz
c9Hg/Mci+rz7qGuJXl8Fb02hqRqouQovL5iAlmnc5FLTWhg+8wu48zHJC4y66msS
AtXgyiPLNk11IH0JGq9r4sfsw5sdaQ==
=gb/J
-----END PGP SIGNATURE-----

--wpnwuhimvbz57qwv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

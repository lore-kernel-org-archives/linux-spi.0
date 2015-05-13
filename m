From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: race in spi_finalize_current_message starting
 queue_kthread_work before the message is unmapped
Date: Wed, 13 May 2015 12:47:15 +0100
Message-ID: <20150513114715.GM3066@sirena.org.uk>
References: <8C375B28-1C09-4545-8A5B-78F6CD04102F@martin.sperl.org>
 <3374181B-61BE-4DAA-9D92-68B43BEF3E1D@martin.sperl.org>
 <20150513075228.GA3394@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bEAlbH1hodbw2omC"
Cc: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150513075228.GA3394@x1>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bEAlbH1hodbw2omC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 08:52:28AM +0100, Lee Jones wrote:
> > Forwarded to linux-spi as well for documentation, was only sent to linux-rpi-kernel.
> > Apologies.

> FYI: You should always Cc LKML (and LAKML if ARM related) for upstream
> discussions.

If there's a more specific upstream list it's OK to not copy one of the
generic lists (and adding too many of them can cause problems with CC
limits), it's just CCing downstream only lists like the RPi kernel list
that's an issue.

--bEAlbH1hodbw2omC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUznCAAoJECTWi3JdVIfQO+0H/i97sY37XE6SQ/Bfl4VrseTY
9/54r+iPI9UZBgEhiCcI72eZwYZbx9NBoGb5D5+zf0IoohI+N4N/cXeuMHGThWYn
A5EjArecejxhikor/hucAOWxOErTFr5vhSZ+DMQ5MdjWMzwFYmS2l1JwGxhN+qIt
MsZYtEnLlB5gxitCJ9fFIdB7XRjXOD4Yu3Db9EMCMjmx+M7y3mkJbNTLSFK+OWo2
3UC3vAtPoSbzHL5vuMWkg0xVZKk1ug/ZbSC1JQK8YcBYOcwbZms36lBPuiLSo7VI
2lg6SG9cRKsqNdJ/zNmf2uXyOfJGiLEy/KrByCxtNwcswq+9f8AS0i4Ou/EkoJs=
=Qp3Y
-----END PGP SIGNATURE-----

--bEAlbH1hodbw2omC--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

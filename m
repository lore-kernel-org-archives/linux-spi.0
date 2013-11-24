From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: Fix the build warning with
 CONFIG_ARM_LPAE=y
Date: Sun, 24 Nov 2013 13:31:03 +0000
Message-ID: <20131124133103.GS14725@sirena.org.uk>
References: <1380567179-20174-1-git-send-email-santosh.shilimkar@ti.com>
 <20131001104840.GL19304@sirena.org.uk>
 <CAOesGMhRoEvsQoSvoCSY=zm71zeZec3MG_FpHOy1zUkYronZcw@mail.gmail.com>
 <20131113132952.GK878@sirena.org.uk>
 <52911B64.3020009@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BuGwuXnZwGGQ9GEc"
Cc: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52911B64.3020009-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BuGwuXnZwGGQ9GEc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 23, 2013 at 04:17:24PM -0500, Santosh Shilimkar wrote:
> On Wednesday 13 November 2013 08:29 AM, Mark Brown wrote:

> > Looks lie it never got pushed and nobody looked at the warnings for over
> > a month.  Oh well, sorry about that.

> Are you going to push this one ? The warning is still showing up at
> 3.13-rc1.

It's a warning fix only so no, I was going to leave it till the next
merge window.  It'll appear in -next as soon as Linus releases -rc1.

--BuGwuXnZwGGQ9GEc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSkf+UAAoJELSic+t+oim9sAcQAJhS4VRWXXsPJacA1Gvshibs
ajn7/lwRR8eEcHWa+JCYPq8OwrQDGAIh8EZaHCiVQtbFx3UFthDzAHvSPqcMZ3Ls
QilSPHRUp/g8AnwloiBAFtCfmjgmOONllb0BKysO5HOwvPPsaeZvpJCoTKD8nb2c
gsd81zenzdxkT/QoqL0dEOC7vxCi832hRrBQ7uWke/706LhjIAKqUgaOfnjzx0xf
sX+IIrOLhsiE2Bcj1xT9NrwCUXsmkh7k8wnRuMPzw8IIYLF+v97tDl9Z+FKejg7l
PxOU6b34pe5qDLU1a8hYINCgVCDYKep9NZbF+twRdVybDkRZ53sAkM2oZ8kfSTge
mrj4CUAi6lUATMVKXg+Y/jhvW93TMZW/z/A1bMYZPqh/mX3Jd0OHw8xkQcar8xMU
Z0kM03BWaQHCKurHzMrtdxSadSPgcX38FLk+al1XEMbCorPUnP8yR+qUGEn1CkMQ
FLGI0tLUpuDMqfA2aJ6kxlh91KiugDIY2fMhkS7y9HdO3HKCTQbljDS/xghzG5kA
Roft90igt4l9B73NFquFeoo2IDKnAp7ZokQvkMKyGgyzcDg/MjaJQbOswcsjhti4
bikSIrg1mtgryTvHRtExGMQfHJ04Wkl/Q3IiZYaoT7uQun1WwoU4UN+c1jPheFNK
v/9dnUNf2JS+9cGIw/Hg
=x2ia
-----END PGP SIGNATURE-----

--BuGwuXnZwGGQ9GEc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

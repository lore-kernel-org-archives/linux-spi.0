From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: Fix the build warning with
 CONFIG_ARM_LPAE=y
Date: Wed, 13 Nov 2013 13:29:52 +0000
Message-ID: <20131113132952.GK878@sirena.org.uk>
References: <1380567179-20174-1-git-send-email-santosh.shilimkar@ti.com>
 <20131001104840.GL19304@sirena.org.uk>
 <CAOesGMhRoEvsQoSvoCSY=zm71zeZec3MG_FpHOy1zUkYronZcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NhBACjNc9vV+/oop"
Cc: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMhRoEvsQoSvoCSY=zm71zeZec3MG_FpHOy1zUkYronZcw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--NhBACjNc9vV+/oop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 12, 2013 at 10:38:13PM -0800, Olof Johansson wrote:
> On Tue, Oct 1, 2013 at 3:48 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > Applied, thanks.

> These warnings are showing up (again?), so wherever it was applied is
> not making it into -next. Did it fall between the cracks?

Looks lie it never got pushed and nobody looked at the warnings for over
a month.  Oh well, sorry about that.

--NhBACjNc9vV+/oop
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSg37NAAoJELSic+t+oim99AMP/3YY3ssWoN+AAotvrTBZ20PD
aJrZuEGaYbgmhdh5lu4/HXp0WbAjl5mbe1/HmFoGKFHyQkckvN+ZduaeB1sXabjb
FvJOkqyZmN2rF5N3TRmMHoIirbB11tudyzVGzh+gw7MZl+yBjqxf/JXmjlx7KVuy
b62V0rSFnHtNyOOFYAvyjmqI6L95jT1/Ag2otHNoIGmdrGfbEUtkeMteJrwwjv3q
0zwcoHyc/RqerMfAMD+6HPZhPe9Ldefh2m0IUvUa3YjDyS+Rj3IbZBb4S6Cj1ajo
23xDvHj9+8G+dNZq/4enDwNIvn8614HzOJ4LYBSwXFmfFIbgwvATNaTWrXR4pwux
GqPgpN2087GQrLm8qMrXF1AX3NiH6RbOpJJDzCEj0FVeXabdo5m+yQSk7Yp9255Y
rWAq2eVvgWU0nJWe68YEa651qdlGWY0ZG+F0wOx9yhpdyjW6zVBgwNto0/qdBRBa
JqTqYH5gTwxfL+4gBDtVOLeOmjUeabdxkg/uONEjQsNogoMxRwDkCZkL6l1GyIEs
FW+1AH9aF3iKOfsqF3XsrcE1cw1UT53zgUC1Hpc6A6RbiyysP/CRMfhGMXwrqEJj
nZTpyDr5GpdIZ6xezgY6HnXk6ASJPAf//Fjx1kXQRYTnbhA3F+pTx3wI3UTVZ/q6
kpC+UD73kv/EXO/sVkJO
=Mr20
-----END PGP SIGNATURE-----

--NhBACjNc9vV+/oop--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

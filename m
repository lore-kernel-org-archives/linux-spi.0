From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Sat, 9 Nov 2013 18:30:56 +0000
Message-ID: <20131109183056.GU2493@sirena.org.uk>
References: <20131106162410.GB2674@sirena.org.uk>
 <3B0EDE3F-3386-4879-8D89-2E4577860073@sperl.org>
 <20131106232605.GC2674@sirena.org.uk>
 <72D635F5-4229-4D78-8AA3-1392D5D80127@sperl.org>
 <20131107203127.GB2493@sirena.org.uk>
 <86AE15B6-05AF-4EFF-8B8F-10806A7C148B@sperl.org>
 <20131108161957.GP2493@sirena.org.uk>
 <5F70E708-89B9-4DCF-A31A-E688BAA0E062@sperl.org>
 <20131108180934.GQ2493@sirena.org.uk>
 <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EzyTiZo8w1pFn3ee"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--EzyTiZo8w1pFn3ee
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 08, 2013 at 08:18:25PM +0100, Martin Sperl wrote:
> On 08.11.2013, at 19:09, Mark Brown wrote:
> > On Fri, Nov 08, 2013 at 06:31:37PM +0100, Martin Sperl wrote:

> > This sounds like an artificial benchmark attempting to saturate the bus
> > rather than a real world use case, as does everything else you mention,
> > and the contributions of the individual changes aren't broken down so it
> > isn't clear what specifically the API change delivers.

> As explained - it is a reasonable use-case that you can easily trigger.

> For example: updating the firmware of a 128KB Flash via the CAN bus requi=
res
> about: 22528 8 byte can packets to transfer just the data and some signal=
ing.
> With 3200 CAN-messages/s as the upper limit for these 8 byte messages
> this requires 7.04seconds to transfer all the Flash data.

You mentioned that systems could be constructed but you didn't mention
examples of doing that; in general prolonged bus saturation tends to be
something that people avoid when designing systems.

> OK, there would be gaps every 44 packets while a flash page gets written.
> But even then, at that time other devices that are blocked, will send the=
ir
> messages as the Firmware update is idle. So with more nodes under such a=
=20
> situation the bus becomes very likely saturated for 10 seconds.

> So it is IMO a realistic load simulation to take the "automatic re-broadc=
ast"
> as a repeatable scenario.

What I'm missing with this example is the benefit of having an API for
pre-cooked messages, how it will deliver a performance improvement?
Flashing should be an infrequent operation and I'd expect it to involve
little reuse of messages which I'd expect to be the main thing that we
could gain from the API change.  I'd also not expect the controller
specific work to be especially expensive.

> > I'd like to see both a practical use case and specific analysis showing
> > that changing the API is delivering a benefit as opposed to the parts
> > which can be done by improving the implementation of the current API.

> I have already shared at some point and also it shows in the forum:

You've been doing a bunch of other performance improvements as well,
it's not clear to me how much of this is coming from the API change and
how much of this is due to changes which can also be done by improving
the implementation and without requiring drivers to be specifically
updated to take advantage of it.=20

> Does this answer your question and convince you of this being realistic?

It's still not clear to me exactly how this works and hence if the
benefit comes from the API change itself.

> Also my next work is moving to DMA scheduling multiple messages via "tran=
sfer".
> This should bring down the CPU utilization even further and it should also
> decrease the context switches as the spi_pump thread goes out of the pict=
ure...
> (and that will probably decrease the number of overall interrupts as well=
=2E..)

Right, and simply driving transfers from interrupt rather than task
context probably gets an awfully long way there.  This is the sort of
improvement which will benefit all users of the API - the main reason
I'm so cautious about changing the API is that I don't want to make it
more complex to implement this sort of improvement.

--EzyTiZo8w1pFn3ee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSfn9dAAoJELSic+t+oim9aQMP/iDeSDVCVDhW6+NmmftcA27u
Xd55amCQ4MX026JQ6uNrbG2EeAeq8nglnbcX5UWCk7V2ixGytGgM49esbfca5Gur
x+v9YW+XfrZ7REr1ZOOGidG1WmpHl/Ad15vymoqcmPD2KoDvb8GbtLOn+vsaUtMg
/rucVjWy5To946dak8N+3IqTbFcZFegp1iu7yfXqNyalXbb7T3BCHiYzUtrUuykn
Ne21/Gsp1c5Rt2nVTZP2BtPizGxI7bJZdZHRuCC7YSFb+w3yDmu7ZEjemZNCmSaO
QeG6Ea3wrnawAC/43TOdlPmbfhVQGS0sgj45FSA4pIMGLWxeMKxbBojUU9ncpEE3
YJMTgno68Lg3+UUtrFZxogOcflWthYY7AKjIiaGzsWESyzv1qD1TURLZzxiknsH+
zp1aZT6RkZaXeuuZr0jdOEoy2g0sV3eqmY5XlGOv+ixwKrShJjLCeT5SLdoZGVwh
EYY28gJ0v8AKmuImrg095F0bU9lGdocgl7ZbQzwdAJIveOx2aQ2hrltKaAs3p6/G
sLj5Sl5ZV+1zEsB74Sr7cMV/E417lvSflCoSTJWmrftV9xUCwDm3TOvth8yqczuG
WjSQC6188o5mmMGVQyjCDFBu3Nb+c5ipZI6dRzgaAXdinuuz8Rw368WeNqZusmRP
EezM2xar1qU9MXMhlMwx
=UjFQ
-----END PGP SIGNATURE-----

--EzyTiZo8w1pFn3ee--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

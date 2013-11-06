From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Wed, 6 Nov 2013 16:24:10 +0000
Message-ID: <20131106162410.GB2674@sirena.org.uk>
References: <20131030215716.GV2493@sirena.org.uk>
 <3342FD19-4438-463B-89B2-A83D3475AC22@sperl.org>
 <20131031001004.GW2493@sirena.org.uk>
 <18639D9A-630E-44F3-AA7A-ADFF5D5E8B56@sperl.org>
 <20131104184511.GR2493@sirena.org.uk>
 <5A55A832-5313-499C-A483-BF5A6649D69D@sperl.org>
 <20131106094854.GF11602@sirena.org.uk>
 <844EDAEA-3FDC-48D0-B59E-CECC0A83761E@sperl.org>
 <20131106113219.GJ11602@sirena.org.uk>
 <C6C68042-63A0-40FD-8363-B4553ECB4774@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LyciRD1jyfeSSjG0"
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <C6C68042-63A0-40FD-8363-B4553ECB4774-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--LyciRD1jyfeSSjG0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 06, 2013 at 01:10:32PM +0100, Martin Sperl wrote:

> How can you check that the code does not do something like this?

> struct spi_message msg;
> struct spi_transfer a,b;
> spi_message_init(&msg);
> spi_message_add_tail(&msg,&a);
> spi_sync(spi,&msg);
> spi_message_add_tail(&msg,&b);
> spi_sync(spi,msg);

> The above is an allowed sequence, that must work - otherwise we would=20
> break an existing API.

This would be broken anyway with existing drivers; if we want to support
that we need to take copies of both the messages and the transfers but
really that just looks crazy.

> The explicit one time call spi_prepare_message states that the driver
> delegates ownership over the message object to the SPI bus-master until=
=20
> it takes ownership back with spi_unprepare_message. So it may not free
> or change the structures in any way, but it still may use the message
> (spi_async) and read write in the data bytes (not the location).

No, modifying an in flight transfer is not supported or sensible.
There's a whole bunch of problems there, including synchronisation with
DMA.

--LyciRD1jyfeSSjG0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSem0nAAoJELSic+t+oim9JBIP/2fnqA3OfNZhdTuuYzcux2dY
Vtp1R3uKH85sovwtY4P2XGsNGmPmNRV4yNDjSg0+ZyLdGvqRKkYll3nZfGP8hUcJ
X1I5Qlydat2/KU+e7rxlGcvNuOZcng+PNYzU/2CLDuKhmUUkl7gHPUxjK2j99n/u
4qq/XhTQvldAUr6W7zybyFCGhNE5qym5cc6BVUiLKxYkwq7TtOmlpHV8eENCdCGr
F4eNFOBSRabt3rQrpw9D6oXKlRjfq/QHKncZjHfBpIG8VcAW4pca2HSSlLVNefMa
6uGcxRdNMJB7v7S3fm+9giUVl69fkLWfEqJIT2bBI6xgAUQQg8BXAEazKgeR8Wdh
G2V8OXM1Li+U8y9Tt5m40IcaHgNQ94Z72u4XG0RmiY6ObW89ayQmG6g+YEyanchs
4inApl4ngL9V2NHapfmeuHez9HXXNwDhhDgU3crpIdFfJnL1QeEvgHS5WjItPjyw
2cmTu5Rv0AegT8USahRBXSA2e2sPvl1zH2VTqjnmxOrpzQXzmprK4bJ0Pm35/ZsC
yssPgv2euGq/j+hQHov4JmDANmte0Y75Ow8b5f3pebDZvT8tFw+LSLp1OcvL3R2i
4dRHm4RB+DiWdA2UP2Za6LnjIGbRFg0h3i5ZWVkrrAJh/WHzlibrltpTxC97T9UJ
A4QWSBNKzX6KMbQzay5p
=+HDo
-----END PGP SIGNATURE-----

--LyciRD1jyfeSSjG0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

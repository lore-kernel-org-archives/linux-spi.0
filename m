From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Depreciated spi_master.transfer and "prepared spi messages" for
 an optimized pipelined-SPI-DMA-driver
Date: Tue, 19 Nov 2013 15:02:04 +0000
Message-ID: <20131119150204.GA2674@sirena.org.uk>
References: <C375DEE6-1AEC-4AFB-A9D6-583DCB4476A3@sperl.org>
 <20131109183056.GU2493@sirena.org.uk>
 <6C7903B3-8563-490E-AD7D-BA5D65FFB9BC@sperl.org>
 <20131112011954.GH2674@sirena.org.uk>
 <52823E73.503@sperl.org>
 <20131114015009.GB26614@sirena.org.uk>
 <9640F4C7-7F82-453E-9D83-5875A1559A20@sperl.org>
 <5286026B.2090903@sperl.org>
 <20131116142356.GY15393@sirena.org.uk>
 <528B6370.9000903@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1y/7ip9Z0l6NTTti"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <528B6370.9000903-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1y/7ip9Z0l6NTTti
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 19, 2013 at 02:11:12PM +0100, Martin Sperl wrote:

> So I will call it:
> int spi_init_message(struct spi_device*,struct spi_message,
>  	unsigned long flags);
> int spi_done_message(struct spi_device*,struct spi_message);

> (or you want to call it spi_message_init/done instead?)

The latter might be better for consistency with spi_message_add_tail()
and similar.

> I will post a patch for this soon.

Excellent.

--1y/7ip9Z0l6NTTti
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSi31pAAoJELSic+t+oim99xwP/2D8AlWllOHyoe/bzN5HNEuf
Li7smMVmr9P6SqoWrzV6yWCf5DOTQklh7GaNoMzIYuVQzrFBEcgJUU0Vc9M/0oeo
ck4D8a2PwnXRcy170SdUrydw1ev+UN7ALJkjfEenKJgAw9tthtqTOcsUUfou6zwQ
kN2s76KedVtO3fAZ/krCOInMnuD8V4ZyhxbuqWUpBbj1fcE9g0QhQz+WGpDeTuPn
tmayr3Omk88Wi2VAezI0Dt3RjyGWvCEFbXFwAhsV6JTL/jbHguj7ioxMp4R0t4Lu
fKLRDrskHH+ePOPcM0dwqNeWyanru2XcTwnN/PYqsTrm65KFhwXkKkaPFF05NMY1
+k2auPet7E15K+HMwn8L/pLrITlbwWFXD3xk36dw06k0xGghh91IOmLCPb6RXzzT
5592L5XxvHkBDzU5NrAX0HovE0ee87ZrVRWL9rBiqgsMnOYndAO2+UcEYfUirLKX
cwmDeAQsDs3smfN7H8yhrwUbdCZgOeQJCCmCI/RkmXpzmEOMFCTJyq4tB8FivLJ7
9bUFkitPL0pOu/416gSN4OTLr3F4V2qU5CK415HNB+Y6PnP94IMQwmQB9c8+loTK
C68/rXFr10i4ot0ibjwhUtzRaWCnZptHTCnOeDRfpXbivdSFFmo72SPZOcVD5Nr3
NcO/UYQZ4z/CYW+AGKiN
=ZRQj
-----END PGP SIGNATURE-----

--1y/7ip9Z0l6NTTti--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

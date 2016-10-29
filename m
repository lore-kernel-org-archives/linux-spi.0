From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] mtd: m25p80: consider max message size in m25p80_read
Date: Sat, 29 Oct 2016 12:09:08 -0600
Message-ID: <20161029180908.txwr5tgr3ixux6gy@sirena.org.uk>
References: <6c95366c-7fcc-ef4c-033a-f9f6e152a669@gmail.com>
 <20160816164204.GV9347@sirena.org.uk>
 <b65240ff-7e28-5ecb-0670-abfca871246b@gmail.com>
 <a5aad691-fb3b-39a5-943e-43068df74c44@gmail.com>
 <e2e4ecfe-b888-f335-57f6-634f5c818252@gmail.com>
 <0e38d1ed-af5c-160f-e02a-f1433c507d23@gmail.com>
 <6f1aed1e-9467-aa94-56cb-5e9435b21ae4@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uqohw3pro2mebook"
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
        Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <6f1aed1e-9467-aa94-56cb-5e9435b21ae4-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--uqohw3pro2mebook
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 29, 2016 at 07:59:09PM +0200, Marek Vasut wrote:
> On 10/28/2016 07:58 AM, Heiner Kallweit wrote:

> > - This patch was part of a series and the other patches of the
> >   series went into 4.9. It's needed to correctly support
> >   reads > 64k on fsl-espi as first user of spi_max_message_size.
> >   See commit 02a595d5d6e4 ("spi: fsl-espi: eliminate spi nor
> >   flash read loop"). CC it to stable. =20

> Does this imply that we have to fix every single driver this way ?

Ideally.  Any SPI driver that has an upper limit really ought to export
it, and any driver that might bump into one of those limits should
check.  A lot of drivers are either unlikely to be deployed in a system
that has relevant limits or tend to only do short enough transfers
though - if systems are currently working it's just neatening things up
really.

--uqohw3pro2mebook
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYFOXDAAoJECTWi3JdVIfQqUsH/2l2kHRKVuubOKBBGSPDp4Qz
bV2N/bLAcfI3O9Ij4ni/RVplY2TEnZbVewFhO4/yKRCKKtoDY4GG59Sc8ho6hIJH
7poQNByMzHuNGvNa/QgyrSgAVmeidBfZxFOinUdVkyUN8+sAhugkIPXA7k3KpKZC
Z6oFtCYxDfimkM6OtrH6ICNF1K/6Cn9xHveAm6EW6r4W6ydnzEg1tFWwt3qVGnR0
2IT7moSr3g/mgDILqw3lpZZRjtG1g6wLEQ4ZJZGtG3BBFp2zArswptusFDbvKd1j
Na/XEBjS+gKog1f0JfSMNWzYjl6R5pM1f/X3mbJc/kL2JVSK4RqeTZ5EWWOjVyw=
=BG72
-----END PGP SIGNATURE-----

--uqohw3pro2mebook--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: core: add max_msg_size to spi_master
Date: Sun, 22 Nov 2015 13:16:26 +0000
Message-ID: <20151122131626.GN26072@sirena.org.uk>
References: <20151119114057.GN31303@sirena.org.uk>
 <F224F5F3-FAD5-47FE-9419-39E53BCBB8C6@sperl.org>
 <20151119171538.GO31303@sirena.org.uk>
 <9CDADBED-FD18-4635-82A9-5AB14C9ABCAE@sperl.org>
 <20151120120502.GT31303@sirena.org.uk>
 <08871ECD-52DF-4CBF-AF3D-4C3A442C008A@sperl.org>
 <20151121134946.GI26072@sirena.org.uk>
 <56507B3B.4080608@gmail.com>
 <CAOMqctR=UDEPbgJDY3YvxpbVEEp4t6ajkyv=cVAZp2fLBNBanA@mail.gmail.com>
 <5650F7D4.1090209@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Y4VYWfdFdHwFhC6D"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5650F7D4.1090209-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Y4VYWfdFdHwFhC6D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 22, 2015 at 12:01:40AM +0100, Heiner Kallweit wrote:
> Add a member to spi_master allowing to better handle
> SPI chips with a message size HW limit.

How many devices have an actual message size limit (as opposed to a
transfer size limit)?  It seems like the restrictions here are really on
transfer sizes and that we probably want a second limit for devices that
aren't able to deal with multiple transfers independently.

For slightly more complex things like this it probably also makes sense
to use an accessor - I can see us wanting to combine restrictions from
DMA engines into restrictions for the SPI controller for example.  That
gives us a bit of insulation between the clients and the API.

--Y4VYWfdFdHwFhC6D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWUcApAAoJECTWi3JdVIfQ4XUH/3LAysWT0IHOek1MOZ6Onkft
rzI2snBSXHn7zKmCJaaxQexOy7f2nsdc6HA5CzPJXfS3hhyUgBevxq4bUW0FjIz1
i2suXaobAg5gr5RiT42XqGvWTLCCoUGvymDLmRB8olA3mvwIoS2VMaDnsYQKALtO
mmhrzx7lGVJVIutUWEtmr+147S9mYWIOeC5kjL7CsBr68o+Itm/aFUDX2loKGIqE
+aps418wOFw0E7TyRIeC6NHL2CDV1zGvgZai2SqdsNFeR51nttsq9ANUDH9OBFWZ
PFNuynaJMDtzzeUdnG272dzJtPXm2qig9eh32KYpHlpCPUx97gKK+aGqK2AAFb0=
=CKFi
-----END PGP SIGNATURE-----

--Y4VYWfdFdHwFhC6D--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

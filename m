From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] mtd: m25p80: consider max_transfer_size when reading
Date: Mon, 6 Jun 2016 18:40:03 +0100
Message-ID: <20160606174003.GE7510@sirena.org.uk>
References: <56D22823.7090005@gmail.com>
 <20160405193952.GA5243@localhost>
 <57041B43.2000109@gmail.com>
 <20160405210727.GB5243@localhost>
 <5706B084.2070909@gmail.com>
 <20160505235700.GA99474@google.com>
 <20160506121431.GQ6292@sirena.org.uk>
 <77a22258-95ca-031a-825d-a9e98e30a162@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IU5/I01NYhRvwH70"
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <77a22258-95ca-031a-825d-a9e98e30a162-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--IU5/I01NYhRvwH70
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 04, 2016 at 12:22:37AM +0200, Heiner Kallweit wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> Am 06.05.2016 um 14:14 schrieb Mark Brown:

> > Yes, it's called the maximum transfer size because it is the maximum
> > size of a transfer, not because it's the maximum size of a message.

> I'd like to come back to this discussion. You said best would be to fix
> the chip driver. To do this and calculate an appropriate value for
> max_transfer_size the chip driver would have to know that the spi_device
> is a spi-nor device.

That doesn't make any sense, the controller hardware doesn't magically
change based on what is connected to it.

--IU5/I01NYhRvwH70
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXVbVzAAoJECTWi3JdVIfQuBQH/1wKyzmTle/eEii7s7ClGaHJ
dxoR0bbNQEcdvLydEyhwpmpWBeMk/353M/o+hWpWw0FW3/phxqTFMzn1yArzSlQw
YSrsEGhtq/gnEjRt35fNUCWsk9eGb6eQvxLTq+T2+usjWXxd7QG1CgdN9kQ/4aFE
a6HERm1B8KcMY0xw16u+ylGyKP+9FCjb4lW3QRBuEilmmcCQ0CsSJuQ7kGDf5WWN
ra87iXUbI5uEVh/U4BQGCauKZC9l1NQ+SwBt9XDXXK12lhMiw+PUKtmyx35GGVSp
JEir+L2kRsh/73B68savijIYP+35afet7C6hhKCXGw73HnzmRk6AlPQsU7yq/ms=
=vsZS
-----END PGP SIGNATURE-----

--IU5/I01NYhRvwH70--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

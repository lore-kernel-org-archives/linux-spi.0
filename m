From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add driver for the CPLD chip on Mikrotik RB4xx
 boards
Date: Fri, 20 Mar 2015 13:28:21 +0000
Message-ID: <20150320132821.GL2869@sirena.org.uk>
References: <1426853793-24454-1-git-send-email-bert@biot.com>
 <1426853793-24454-3-git-send-email-bert@biot.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qMyE1nnBIN65x+Vj"
Cc: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426853793-24454-3-git-send-email-bert-Nh2F35Ii2RQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qMyE1nnBIN65x+Vj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2015 at 01:16:33PM +0100, Bert Vermeulen wrote:
> The CPLD is connected to the NAND flash chip and five LEDs. Access to
> those devices goes via this driver.

None of this driver looks like a SPI controller - this appears to be a
MFD so should have a core in drivers/mfd with function drivers for the
individual features in the relevant subsystem directories.

--qMyE1nnBIN65x+Vj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDCB0AAoJECTWi3JdVIfQoMAH/2Ixc3w+dFlBJNP3qwbpTWUs
VLNcRdoK5jURRp0eGap/7MQa1edVMF4SGF3iiIp9yoAjPu89FK7P7PrODjWjRMIx
y86O0p3qlhM/aoE3VyLLGnKv6MDWlu6tBRCj+IlxSG2V8onZKAGO3LNsXX3hkstm
aB4ZHRv3I81oNafOjf3pQBSkn3c3EW+iDTahOrcwowj3HUIIRYp7gwkolUlZJXNC
AXRKFDnsKJdIbPkbwAAYEm8OdVdZEfOoDI+I/LpdDLtzyWh2+WarpllfSp5n6o6g
31/ZW6j1/8sR+vqyQhyaPCpImTq26Vf/VUpFN3zGl+mIoCBfMa0KkmsFWnbZIlU=
=kbUp
-----END PGP SIGNATURE-----

--qMyE1nnBIN65x+Vj--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

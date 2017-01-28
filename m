From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH v4 2/3] i2c: acpi: Initialize info.type from of_compatible
Date: Sat, 28 Jan 2017 22:38:51 +0100
Message-ID: <20170128213851.7s5nloo2spumtevx@ninjato>
References: <1485187737-22414-1-git-send-email-dan@emutex.com>
 <1485523815-9629-1-git-send-email-dan@emutex.com>
 <1485523815-9629-3-git-send-email-dan@emutex.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jy77lo326ymla2fk"
Cc: linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Crestez Dan Leonard <leonard.crestez@intel.com>
To: Dan O'Donovan <dan@emutex.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1485523815-9629-3-git-send-email-dan@emutex.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--jy77lo326ymla2fk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 27, 2017 at 01:30:14PM +0000, Dan O'Donovan wrote:
> From: Crestez Dan Leonard <leonard.crestez@intel.com>
>=20
> When using devicetree i2c_board_info.type is set to the compatible
> string with the vendor prefix removed. For I2C devices described via
> ACPI the i2c_board_info.type string is set to the ACPI device name. When
> using ACPI and DT ids this string ends up something like "PRP0001:00".
>=20
> If the of_compatible property is present try to use that instead. This
> makes it easier to instantiate i2c drivers through ACPI with DT ids.
>=20
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> Signed-off-by: Dan O'Donovan <dan@emutex.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

I assume this shall go in as one series via ACPI tree, so:

Acked-by: Wolfram Sang <wsa@the-dreams.de>


--jy77lo326ymla2fk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAliND2oACgkQFA3kzBSg
KbaOWxAApIsIFBJMYCsAfi2Odnkj/L6176Hr3NZt/hIYYqav4CrkkRewiOkJUY7I
5F6l5YbwRDMhJvLOUODwz5+/Qzcb67KpS7uyDtcbJryXs84Bh4qLcPRcPI2698pZ
S6EbukNPg4pzSXdLum8XAMHgRHG9h1aFo/DuV+QDLzZvKSiMSl8NhIM2itk1x5Lp
Tw0wmjBx3xlKXQa0QlhEaMtng3KHlaRg1V1LxdhPvnynwXA8Gk8zw5rf0aa8ybPj
BRMKWrYi8VKc80iL9PRAWWthPLJy77+F27iqaA2HlGRUCdzJURJs9Qmytg1Kz/XP
VziDpmWxrvnzbqMnB+Y5warF4misEuoM3RAJLD0vgNqClXfTCNRCyto5P5VHLy7Q
5OX0BsJfM4oMJa3ICe7NAzb0ZlQW+O5nVEFoC6HWMOqZcdrZhcnJ5knjYu61OkoM
MVy7fsgG5etsK+PF99pp3lXrpsBcKYpf3q5+ChxXod3NOboU5+ZiGnkMrFoRfCWB
aSm3M2AQBTA+1HKtWrpsFowiP9teFuaaVtH5uiSP7lXpvLom11cM6Y2mXL9ewNxq
RWM5zp6o5ZdPvj/8MF7w9dAYZGbZQLMo2iaUUtvlXXzMGuzjasWB7MRpyZkk2gUR
ihIyzzPXpsbr/a8o9x9u5f9t3pwXVbu8kT3dawu7omnCq9DHt4s=
=K5NF
-----END PGP SIGNATURE-----

--jy77lo326ymla2fk--

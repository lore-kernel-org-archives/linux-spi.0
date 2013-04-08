From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 4/5] spi: s3c64xx: Added provision for dedicated cs pin
Date: Mon, 8 Apr 2013 13:20:57 +0100
Message-ID: <20130408122056.GG9243@opensource.wolfsonmicro.com>
References: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
 <1363157014-9615-5-git-send-email-ks.giri@samsung.com>
 <20130401125744.GG18636@opensource.wolfsonmicro.com>
 <CAKrE-Kd+YAFmteDdh3odtV+YU1=OjoMuQV9usF4NmUse+TXhTg@mail.gmail.com>
 <20130408101530.GC9243@opensource.wolfsonmicro.com>
 <CAKrE-KevVramLc1n_9kcfHVb=RKT_kexQ8iUP-5+BL3wxpMPbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EemXnrF2ob+xzFeB"
Cc: spi-devel-general@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tomasz Figa <t.figa@samsung.com>
To: Girish KS <girishks2000@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKrE-KevVramLc1n_9kcfHVb=RKT_kexQ8iUP-5+BL3wxpMPbQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--EemXnrF2ob+xzFeB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2013 at 05:15:26PM +0530, Girish KS wrote:
> On Mon, Apr 8, 2013 at 3:45 PM, Mark Brown

> > Two options here, one is to just assume nobody will use GPIO 0 and the
> > other is to set the number appopriately during probe so that only probe
> > needs to worry about the issue.
>=20
> In the second option if the gpio number is set in the probe, then we
> are overwriting the
> actual gpio number assigned in the platform data.
> If I move the cs_gpio from the platform data to controller private
> data then the dependency
> on other platforms can be removed, but still the check (true or false)
> before setting the gpio
> line will remain. If agreed upon this i can go ahead and post the patch

I think logic in probe should be fine, it just felt really cumbersome
having this on every single use but doing it once on probe ought to be
OK.

--EemXnrF2ob+xzFeB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRYrYaAAoJELSic+t+oim9FXEP/267JPgYOyCReHGdw06v0VBN
WhBbRkU3HlKrWBrs1tD9owmL9q9BtDqTxpIXwUOpLpBqHqQW/r3V6bI8/xjNMH7U
3OwysjbAJWnsuN4bp1M/0exT15gc9gcNn+9k1YSRJMR2c5PPryBROrBk7H4Dyqzy
vBZlPabRp7Dk7rzwU1krRAR74BfhQ9xT3K4O9uASSyPzXu385vVBdPUzJ85XE0If
FKtgQecE4DZ+P/hTA/CSmhv11iAEaOaDt3VEJn0XNYHfmpFX2+oOpzd9OwFO0iyY
OsXVJ/ul3G9f+bNckapBa6yDth8T9R5OLttkddXv0+AQvbnCiV+GPHDhFDjXyheH
6FW2flw5W02YQZWXAaA0JznypL6EgANlH3itJMWu1sfkFBWpO7st/BSJEV835XW1
eVqb5YI8zwCZs2a7987sY8hhxm+SrqVbiFADkC7bf64PPTIroTbPdATqSRR2O9J1
C6aplsBzoeTxCnjLgggZWSnfX1LqX0AaAA0FfcCud6ZDj6nZAaaYn2FzKZ66YTQ7
TAOMM0DImOsZ0TQ2jEwkQ458tCC0p8VK7oSQwnfIMQVZBEKURayjgYWY1obSk4Rb
ZCY7J/Rnf02lB9gelxA/jkKw5lHYNC79KmqJn7WcdbY/K0mEjpdxNWVv/UziZlAm
JCsRjBJ7XUfgFmRkLA+d
=GnQU
-----END PGP SIGNATURE-----

--EemXnrF2ob+xzFeB--

From: Mark Brown <broonie@kernel.org>
Subject: Re: support DUAL and QUAD[patch v1]
Date: Tue, 16 Jul 2013 10:29:06 +0100
Message-ID: <20130716092906.GB22506@sirena.org.uk>
References: <CAHSAbzP0Nc1ahf_ra6yDuMvV998_+EGcUOGDv5ifKaagYf+NOg@mail.gmail.com>
 <20980858CB6D3A4BAE95CA194937D5E73E9E84D2@DBDE04.ent.ti.com>
 <CAHSAbzMDOWo5oBqUHqMxybuDwUjFbczYwN+85gH+rxZ9z8u2Pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2739852701002753624=="
Cc: linux-mtd <linux-mtd-bounces@lists.infradead.org>,
 Grant Likely <grant.likely@secretlab.ca>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "Gupta,
 Pekon" <pekon@ti.com>, "spi-devel-general@lists.sourceforge.net"
 <spi-devel-general@lists.sourceforge.net>, "Poddar,
 Sourav" <sourav.poddar@ti.com>
To: yuhang wang <wangyuhang2014@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <CAHSAbzMDOWo5oBqUHqMxybuDwUjFbczYwN+85gH+rxZ9z8u2Pw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============2739852701002753624==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 16, 2013 at 04:59:49PM +0800, yuhang wang wrote:

> > [Pekon]: Instead of adding new fields you can use existing 'mode' field to
> > pass on the platform specific configurations. And if 'u8 mode' does not
> > suffice you can increase it to 'u32'.
> > #define QSPI_MODE       1 << 5; // just check which bit-fields are un-used
> > spi_board_info->mode |= QSPI_MODE;

> well, can dual and quad be regarded as a spi mode? if so, your comment seems
> to be right.

Yes, I think this is a good suggestion.

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR5RJfAAoJELSic+t+oim98/sP/iKi9jFpAXvgxltJdF5qJgYW
L42pQh057j6SuEb0To0CyjsFVcz+M4sws+SzXs9dox1RbGmVhG2JwAXi5Is6/Uvj
KgJ/9UYHZCyY8BSZecruGKrth1cSpO6xP5fGNFK2KpURoQLXjAL074DxVL9SNlVm
5Ipj3Nfz7Z5VrsivQcyH2WqKquPeDILFKNzW75bx3+clL4n05C+zQrE+/5N1hQ9D
ssA8lnvfNVfU+6kGJ9y2kZDKI3p25wxfv1C23BmNUfCldOJwO5xHZHq86Z970Pgi
cyIqn8BIlv6dMGbFdde32t+TEndGk7M8R9E2YH9cb0ZFnd3UJtnNNSN+3oInHYM/
cixPzvON8Dyfrb7mv7Xf30bACFBQKoBQKMpJRtRwzPeZgJhJMuIEQ4F6wFGVSQuX
DzNvweEQ4pfdGn8Yq4z7cEcUiaboR+RrFu/VqjxhyeNZG790m+2RMN+y2+K9EIKr
JJ0xF0dOM65If8GOfZRdGg0QLTW2JnqBGhWdtJJDOdMRZchq+Uy3d99/4BCwKz3B
5ZI8jt9fY3Koss0W3CmkhQ/l74v1CmQWCGavp3USVSfI4NshBhLWKPuKaqFm6qLi
VGXij6x8KceC0CeCTZvVr8E/eiOq2C5eOmIt+3VMlkFQEIw5I6f7ev8RRZS90W0C
duoXjRB2gKWOIXAsEiwz
=DjBw
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--


--===============2739852701002753624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============2739852701002753624==--

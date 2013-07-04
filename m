From: Mark Brown <broonie@kernel.org>
Subject: Re: SPI: DUAL/QUAD support
Date: Thu, 4 Jul 2013 16:49:27 +0100
Message-ID: <20130704154927.GE27646@sirena.org.uk>
References: <CAHSAbzPNDSr_6N79fh0DTWSEg8buRRPyiw8SPodtKLPjzWXJsg@mail.gmail.com>
 <20130704130017.GA25997@sig21.net>
 <OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2495884557310337075=="
Cc: linux-mtd <linux-mtd-bounces@lists.infradead.org>,
 Johannes Stezenbach <js@sig21.net>, Grant Likely <grant.likely@secretlab.ca>,
 linux-mtd@lists.infradead.org, spi-devel-general@lists.sourceforge.net,
 yuhang wang <wangyuhang2014@gmail.com>, linux-arm-kernel@lists.infradead.org
To: Thomas.Betker@rohde-schwarz.com
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <OFA0D5839D.0594EA10-ONC1257B9E.004A7347-C1257B9E.00524BA5@rohde-schwarz.com>
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


--===============2495884557310337075==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="u57qSRWxBnzOWp9B"
Content-Disposition: inline


--u57qSRWxBnzOWp9B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 04, 2013 at 04:58:52PM +0200, Thomas.Betker@rohde-schwarz.com w=
rote:

> This situation is certainly a bit special. To me, the patch looks like a=
=20
> short-time workaround; I would rather see the flash driver support actual=
=20
> dual or quad mode commands. Is there any work in progress?

Well, there's two bits here.  One is the support in the client drivers
for using the extra data lines and the other is the support in the SPI
core for telling controllers to do this.  We need that second bit in
place before the first one can be implemented.

--u57qSRWxBnzOWp9B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1ZmEAAoJELSic+t+oim9ZAAP/ja6QWkpO7xP1J8TDcBs18QW
zh/jJUqo3PQJ6FifH8wsqYh+ONDN+RXUQ7QX/zKrqCzgoQ14o4SmchUPKwkuIbwc
GZbAoXeVYbJE7yItR++r/mhNeVlxgMJ1o7aU4fM1U6jIrp6kBqjqumlLgGmxGJ7L
4JBRmotC7gYy7970L5slpMmeYLEA+o1TaNi7SqRHIaAHbx0Wto2MhwDWzFQQyu8o
F0Fc/uCYjzdYYRI9X4tHBc9pDUPe7PLFTYzqefqYHoYkmUD27cTe3OALhQlllKjF
YHScPv83+tGnctZD9opURK1Z3Nj+t4O1WfZxV0golfpRmakndCjDCR/vQqpzDde2
OtgKB93MQ5lOCINs6NJNqgkFa7+e/G8nerrg1ApX8Vz3pIw1yRAU6KETE0Uni7bJ
xdjd3Np4iDHJl3sCytAEtauWEoSVyYnCHnAuICJoe/plfMlN6RTUF2k0mw0swYu6
fsplKD1jLX0OGqr+ZgvzAjjDKsGK7KxlG+iPymFGFTI2x7OdHX8UEMXcd3/rMAC5
ksymgjJuv5xeG5/xjyhWI1cB/zNhxyLu9knqYXvc8R792J/UvbfczpEPIW5Y4qF5
cUVzvXYHkDzf2V//PLodtiuBPjQiGgpJCx56eyICs7gtNtjmikWjEET77QquB3eT
109xV+u7yIRIeXvLTIgy
=E6Yp
-----END PGP SIGNATURE-----

--u57qSRWxBnzOWp9B--


--===============2495884557310337075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============2495884557310337075==--

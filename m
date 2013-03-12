From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH V2] spi: add driver for BCM2835
Date: Tue, 12 Mar 2013 18:24:05 +0000
Message-ID: <20130312182405.GE19942@opensource.wolfsonmicro.com>
References: <1363059504-13284-1-git-send-email-swarren@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8306032635234281790=="
Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1363059504-13284-1-git-send-email-swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============8306032635234281790==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Content-Disposition: inline


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2013 at 09:38:24PM -0600, Stephen Warren wrote:
> From: Chris Boot <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>
>=20
> The BCM2835 contains two forms of SPI master controller (one known
> simply as SPI0, and the other known as the "Universal SPI Master", in
> the auxilliary block) and one form of SPI slave controller. This patch
> adds support for the SPI0 controller.

Applied, thanks.

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRP3K+AAoJELSic+t+oim9NPYQAIeK0g/fXOGppgJTG6uSroCN
ZV9Z0+84XwnxR7JaUh8/ibJT3kz+dAvPgFjHJuLuPNBqflsnlI8FlDm6suZ3Jxb6
namNl2MNfMj4+5/q03rb3G60ib+iIw09a0+fhRu29Wj2ZsixBwSxc89ZefO6i+Mn
sWBlkD7/Mlr/MoterCqIX6NiWsNA8yqt9BAQggg6tWySoK7pcDJwPVEzyOXcBY+k
mOjQHnj5ED8PwMkECjUsIgq3765uSkRtMgu7FBESDL9bl1sH8DchulZaKir1nLfT
BdQxe/P2dAYTKcIx8BKz/MgmN7cD/DdUkaRcdnpMdoIhyBiWjnLfZArQVUeW6fdu
2TUKMiEY3qCDL8D9IUQJmiSDm4nsU3URL+ZMFce2EU42VLr7KJtUjXrnEqlobZf7
PA+djdvo7mFxgCowARucL7W++mW0fOMb4m4/52M+UJEIlXEHycRnIgM1dy2Ix9B/
uxcuJtXyohbfjlHskug36ZPkJHDcDltHlNBoxbOHA8tH7K8sXv9oBl8/4VuVLO+k
XUVyCszzKg8irU2OPYHO+tW42q5295O1E8yHWRnOpYXybpdQqZ74+U+CRWG9t6q5
Dt1ivm3ki0+qwpGg37WMw9ljIbuV5gBieGeXNwyPh810GEh0Er5QdisPuKMrE9KD
H3/5wUmss4YDqi+ilzSL
=b1MG
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--


--===============8306032635234281790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============8306032635234281790==--

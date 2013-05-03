From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] drivers: spi: bmc2835: use devm_ioremap_resource()
Date: Fri, 3 May 2013 10:41:40 +0100
Message-ID: <20130503094140.GN4945@sirena.org.uk>
References: <1367496810-5400-1-git-send-email-laurent.navet@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6467834221350808259=="
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Navet <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1367496810-5400-1-git-send-email-laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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


--===============6467834221350808259==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vDEbda84Uy/oId5W"
Content-Disposition: inline


--vDEbda84Uy/oId5W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 02, 2013 at 02:13:30PM +0200, Laurent Navet wrote:
> Replace a call to deprecated devm_request_and_ioremap by devm_ioremap_resource.

Applied, thanks.  Please use subject lines that match those normally
used by the subsystem.

--vDEbda84Uy/oId5W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRg4ZQAAoJELSic+t+oim9EL8P/R9rwcW06Xsij3wBvm25H+Uj
rN9CB13D1LcPIxNlO9lIsaW5qXZfsl82UHYXomYblK5FeLoXvtC13iY/dqTwAKZi
vYI1VHxeNlmiUbb1PMS5aNa4NUiJ1WSRUPCTzHmEjfCO3Lucy8wIQkGvgfBZhTi8
xbbAxwtf/EALdycyyy28uipvneQ0eIeCdsER/NBBB3oGtpfi3NXxBYv5ARra702w
PsO+ra0nfread7ljbEcbKkHJ8rU1JCyQ/BplD9bRmkZLG/BdsuhOm8DGnmfQs24g
waA5Y4J/Yd+y5yF4UmVAtOT3719TIBEZv9oLQYTeWP/9Jqbi/gGYvsfu7ZdSNTv/
I+CiMQJVT7HDapSdQg+HKWDEzcNuooT2AgwG2ryT6lXHnT5DYjTWubxivoxw2Cvm
Ow0mfXeYg+BqvJrhP9/lt33RIHKTORRYN1CW5Gm6waScXOzYzD2PodblfUzWPmJh
LDIYieyPxzv0I6eVN9lZz2t56QZN3+kxfQiuG30USMXiUNd7/OcN2TVLXnfZWItE
q5PicdhqaXo9jevKhA05JLdPEv2NSigeeu8dO/MrwDtmPopq+9VZEZ1BaAZJUo3/
bszAI3bIuMGaJAZrKe2p3IdqvTPAxUlOG+v/dNpL3pqasu7nZqjTBkzgF7qNvlkx
CLJQKM3a4Uk5LEU4zLDk
=prgh
-----END PGP SIGNATURE-----

--vDEbda84Uy/oId5W--


--===============6467834221350808259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-rpi-kernel mailing list
linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel

--===============6467834221350808259==--

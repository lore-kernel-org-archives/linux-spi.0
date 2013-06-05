From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-omap2-mcspi.c: Add dts for slave device
 configuration.
Date: Wed, 5 Jun 2013 12:57:34 +0100
Message-ID: <20130605115734.GY31367@sirena.org.uk>
References: <1370432398-7796-1-git-send-email-illia.smyrnov@ti.com>
 <1370432398-7796-2-git-send-email-illia.smyrnov@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7025899251743981900=="
Cc: linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
 Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Illia Smyrnov <illia.smyrnov-l0cyMroinI0@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1370432398-7796-2-git-send-email-illia.smyrnov-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--===============7025899251743981900==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sW3EvpYZ43JhLhGX"
Content-Disposition: inline


--sW3EvpYZ43JhLhGX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2013 at 02:39:57PM +0300, Illia Smyrnov wrote:

> +SPI Controller specific data in SPI slave nodes:
> +- The spi slave nodes can provide the following information which is used
> +  by the spi controller:
> +  - ti,spi-turbo-mode: Set turbo mode for this device.
> +

What is turb mode and why would we not want to just enable it all the
time?  Based on this documentation it's not really possible to tell...

--sW3EvpYZ43JhLhGX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRryeqAAoJELSic+t+oim9lj0QAINQ1Ap0ZL+76ujjUSr+gXGi
r//eyC1CLPnbUSl6d3lKZgwYicaU//IPib4CDinZERsR2dHaaq+FHX6TqwoHPPdU
BDFxzOc8V09DWcTo9TyXV58B0ruE/JxFQOsTsVl3SN4s9gMVKpLG3BLiw/C6Rdt6
/hV2kp7198v/jxXYGB2Q8g6GJNdyQKcoasR1syMtCfrmUWiK3tnfrJFV1U3Zw625
bQAzAj0FUKmghQcENXBojlcLWviHvs02vfWl6UmEv9nr0sPC7L0WKy3YAAvCkT6Z
falnolIAplq+lRQtv2sXRNzKr1qqK11p8hKetsT77RtzYzlGUpzVXznEO2JKu9gQ
L2o/FYdNZw6oJpFwFSN/Xqe49/fhpYiaUfgI63EKz3exIB+sarA5oQcGoPM0BhBS
dXQCdtyloTpTVnr5Uinqw4XdvS0zMcxamS9ECA5kGg9FHDALrH4umXA7qyYnigr/
1QGnWRCJhZ1ejMVsvIXhPhdUmL8+Gdrspr0+zsvuPMQJT061boQbz6oYUg4rL+3t
aMpW5GaMHvtKZIQK47FXD+wPbEE0WCqMN8wq82d0K6n3F00zKjExpFk/yaMUI73v
dR+scazZvyM8UcEo2Fj5viXPf55Bpt/Q0opEIqiScCyKgrUGdMx0D6nJ039sq9yY
ueaQq1YQVh6mPi4rmM+f
=k/vI
-----END PGP SIGNATURE-----

--sW3EvpYZ43JhLhGX--

--===============7025899251743981900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7025899251743981900==--

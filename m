From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 2/5] spi: pl022: use generic DMA slave configuration if
 possible
Date: Tue, 29 Jan 2013 10:41:15 +0800
Message-ID: <20130129024111.GF4748@opensource.wolfsonmicro.com>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-1-git-send-email-arnd@arndb.de>
 <1359410300-26113-3-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4709867372452733740=="
Cc: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
 Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1359410300-26113-3-git-send-email-arnd-r2nGTMty4D4@public.gmane.org>
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


--===============4709867372452733740==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2013 at 09:58:17PM +0000, Arnd Bergmann wrote:
> With the new OF DMA binding, it is possible to completely avoid the
> need for platform_data for configuring a DMA channel. In cases where the
> platform has already been converted, calling dma_request_slave_channel
> should get all the necessary information from the device tree.
>=20
> Like the patch that converts the dw_dma controller, this is completely
> untested and is looking for someone to try it out.

Acked-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>

I've no ability to test this but it looks good from a code point of view.

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRBza0AAoJELSic+t+oim9BOAP/2Ie5gEDao+LZi7KmPWr6Mgz
5X8l+O5ymljUGOVACCYboQvDjBxAAu2egAxHL+vHEgvrX6NC1m515a6LjLabASCu
/0I/oJpToRQvhYIbWaW76E/w4NG8Fj2Pfx/y7fUfe9QvKOX0nGzo29aqjPthDuGC
9JJlEZMENp1CNxhcJLi8RXjSp3qvB3z9nCeoapwE/Xmp6iIXaRxPpY3u7NC0gG9l
2/GYYRhBoaiNpiRIWsEFCdbXjSe6eTmkaiNAWRLvo44aVUFdAD8Nm/UZUpBABgRS
Kiwcgm3qqlYg4mPsoh7VFS8jtAyO2uJFCAy+uuLGVjeo0jeuju09Dlr2OAIGYrSI
L1iUn14JTNjwZlhpCjDXe6BSiKploY6FAgqCcv3ode2yTrcfoYkZeEe9bmoRdOxS
THN/7sFozAXGPhFg0EL+Dzv8P+gcDQNXpGDIhXpLiAf5fe9v4INxr9p7KazSMXuJ
KDzf/6txL54iYjBULDErqaz1huyxHMSRFklMc0wgotNp+WfcpxTri/FLsavBtUSj
NHqdswDeP1ct/xiIRRdU6OvwWQHtJIvrjDmLPvlThpnLJUB0SSZFLOK8H6f1uYUV
PbjgjhzQz4ufqwtFv5bBgMIBGLyq9H2XSPZjNRzLUsSB5Mi/hA9iW832TaykVN9d
2iFCfweXP2DvCDyGatD6
=0in+
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--

--===============4709867372452733740==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============4709867372452733740==--

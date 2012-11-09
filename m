From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 5/6] ARM i.MX: rename ssi1 clock for imx27
Date: Fri, 9 Nov 2012 14:58:26 +0000
Message-ID: <20121109145825.GI23807@opensource.wolfsonmicro.com>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352469625-32024-6-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7620142604200450687=="
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1352469625-32024-6-git-send-email-s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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


--===============7620142604200450687==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9iyR+p8Z2cn535Lj"
Content-Disposition: inline


--9iyR+p8Z2cn535Lj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 09, 2012 at 03:00:24PM +0100, Steffen Trumtrar wrote:

> Signed-off-by: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

You don't say anything about why you're renaming here...

> -	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
> +	clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "10010000.ssi");
>  	clk_register_clkdev(clk[ssi2_ipg_gate], NULL, "imx-ssi.1");

I'm guessing this is for DT...  why are we only renaming one of the
clocks here and will this not break non-DT users?

--9iyR+p8Z2cn535Lj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnRoLAAoJELSic+t+oim9CHgP/3lgqWdDU1a2AufQU34AsR4S
5bxRge0KLI4vZ9OBgGZnL/tKdEaHIZkXaHuAUkJNq1Iy32XoYmVxkwjAodItDwub
IZy4sBAX8aSeAt2lMLotndBl0UX199H/2m+OGVWR309fpzk0d5RWcpu2SD9a67um
HQKTD4GPLYq64T/nQnOZXM7xTLSVPXvyXWfsh88ldokucaL8SDJ0hjCWSFLRrxTB
hAeNVSGUYAq/t80E0RoG04Wf7kUsIiMDZltDes7J37V6DUDV6PRno5v3WAgcokpD
AQVMJK6hhjzI1vn7cdYXgpT9TWsGUcjI/EklmSVvMOpP929IwoC+r7BG48E3Bprx
usbXK9/pfBhveDV1KNaJXJ8RPiOxmGAzfTP9uIlWhgdbeVrmkVKWD4yIT+GCootc
Psn0L16OLCefBmvbeedUz8fvzreMcrMt/lhMgN3PjNjXrNDQtekJQP4uevs9Fp3S
cQZ4eTNmj4lwpNtd3Bn/0JTSbugh84xtB/tNa1yLYk/tP+B4SLISV5BuHOUMp2Fy
PC3V5PNc2mCgGJn0G607ojCx2M+bRjy1x5cM4dZb7VimgZ7KhDVcDKvplFhe/St9
qPTpNlQbzdmg4FVJ66PupENI0NFPGQLTVVzpQ2CGd7UfhsGLmIfXX0eqeCOw0nFT
QhsVkAs20tzLC0eUQiez
=jm2f
-----END PGP SIGNATURE-----

--9iyR+p8Z2cn535Lj--

--===============7620142604200450687==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7620142604200450687==--

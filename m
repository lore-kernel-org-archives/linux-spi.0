From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 6/6] ASoC: fsl: add imx-wm8974 machine driver
Date: Fri, 9 Nov 2012 15:36:30 +0000
Message-ID: <20121109153629.GK23807@opensource.wolfsonmicro.com>
References: <1352469625-32024-1-git-send-email-s.trumtrar@pengutronix.de>
 <1352469625-32024-7-git-send-email-s.trumtrar@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0255094436439317653=="
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
 spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Liam Girdwood <lrg-l0cyMroinI0@public.gmane.org>,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Steffen Trumtrar <s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1352469625-32024-7-git-send-email-s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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


--===============0255094436439317653==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HTLCc13+3hfAZ6SL"
Content-Disposition: inline


--HTLCc13+3hfAZ6SL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 09, 2012 at 03:00:25PM +0100, Steffen Trumtrar wrote:

> +static int imx_wm8974_dai_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct imx_wm8974_data *data = container_of(rtd->card,
> +					struct imx_wm8974_data, card);
> +	struct device *dev = rtd->card->dev;
> +	int ret;
> +
> +	/* the pll stability peaks at N=8 and around 90MHz.
> +	 * This values are best reached with a 12.288MHz or
> +	 * 11.289MHz clock. As the first is closer to N=8 in
> +	 * more situations, chose 12.288MHz as the target clock
> +	 * (ref: datasheet section "Master Clock and Phase Locked Loop")*/
> +	ret = snd_soc_dai_set_pll(rtd->codec_dai, 0, 0, data->clk_frequency,
> +		12288000);

This seems far from ideal - it's starting the PLL at system boot and
just leaving it running.  This will be power inefficient when the system
is not playing audio as the PLL will be consuming power but not used for
anything.  You could also do the same thing with the MCLK.

Note also that a 12.288MHz clock is only suitable for 8kHz based sample
rates, for CD audio 44.1kHz based rates like most media files 11.2896MHz
should be chosen.  The driver may want to switch dynamically at runtime
to support the widest possible range of rates.

> +	data->codec_clk = clk_get(&codec_pdev->dev, NULL);
> +	if (IS_ERR(data->codec_clk)) {

devm_clk_get() - this'd free the clock that's leaked on removal.

--HTLCc13+3hfAZ6SL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQnSKxAAoJELSic+t+oim9FlkP/3QBWznByoBL7pT4QOTkNzBl
PAcA+6LGPTkLgFsJwOeC+jPfmQ/AFU1k7UW+jxQZm/KfTlxtkmIOJRcS32M6bCkA
PyLoOFKea2KQYjrxaWrgGmYhNA1B1Dl6Ecos1rk4rmRytphGvNbeJ4tPPKAvpw8S
W59yYRDPje/wcXVzywT9bbLWQhW5dbQmQa0yNwbYVEvzC+IYL4z7MMijdlMn86Dt
m20jszZtnoVA16yxz18Be4aesILo8axjDMVNVTc3EjEZvjlEyUw+udged5KZsNwj
ozTt2g3OFPQnFbCuBD4uDGuAVAB4o33QdqBdIxEOmt6xeYWhb/A8feUiMO03eOvv
1qE80r3ywDZFuHl9zSGxerdqc9fndeykwXdCd7E6HmFeBthGBlnNi4UtftZtHdbL
656VpVlwgVSmqOkd2qtE/UvHjhteC6z6Hjw8nwfpHORlm3cqOrtE1DFHcQXIyee4
EnzmGW2t11IQ3dJ6Mcaoc8X1fISIYhlAq2sgbAB+x8+3YB+AOMWi1fcDhtaIyjCQ
EKf3MXzW0kNGPgJwe1FYgZ4O8o09B0JgJ/vqvXVVJ0H0K6srChVpvTIRlN+DdrL1
TgCp1igBUhXR6FWIS6zDp/sqj29J5ePuM1uzM0Us+0Mb8sOrZG3kLOcmmB5uwjr/
H51jAHu31xAma5yFQYNN
=VBF8
-----END PGP SIGNATURE-----

--HTLCc13+3hfAZ6SL--

--===============0255094436439317653==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============0255094436439317653==--

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 10/10] ASoC: rockchip_i2s: modify DMA max burst to 1
Date: Fri, 11 Sep 2015 12:53:31 +0100
Message-ID: <20150911115331.GM12027@sirena.org.uk>
References: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
 <1441502008-14116-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lWL8cm7oyu1su5Oz"
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>,
	Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Olof Johansson <olofj-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yiwei Cai <cain.cai-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1441502008-14116-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lWL8cm7oyu1su5Oz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 06, 2015 at 09:13:28AM +0800, Shawn Lin wrote:

> @@ -460,7 +463,6 @@ static int rockchip_i2s_probe(struct platform_device =
*pdev)
>  	i2s->playback_dma_data.addr =3D res->start + I2S_TXDR;
>  	i2s->playback_dma_data.addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	i2s->playback_dma_data.maxburst =3D 4;
> -
>  	i2s->capture_dma_data.addr =3D res->start + I2S_RXDR;
>  	i2s->capture_dma_data.addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
>  	i2s->capture_dma_data.maxburst =3D 4;

This random whitespace change shouldn't be in here.

> @@ -489,6 +491,18 @@ static int rockchip_i2s_probe(struct platform_device=
 *pdev)
>  		goto err_pcm_register;
>  	}
> =20
> +	dma_quirk =3D snd_dmaengine_pcm_get_quirks(&pdev->dev);
> +	if (dma_quirk =3D=3D ROCKCHIP_I2S_BROKEN_BURST_LEN) {
> +		/*

I'd expect this to be a switch statement given the way this is written.

--lWL8cm7oyu1su5Oz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV8sC6AAoJECTWi3JdVIfQglEH/03kNmkMXsPDpolkU+klcBdk
DKxDaID7PPOEinEcsEiZ86/sOp5HfOpQcvOUppTW1ewcKDD5iAobv5J0VKvToeQo
2XKnWf9IpwC5707ov/RbwAZE7P957YWm4eHoYBQ8146A1lHNY1sfusBaJzdpHge1
4GNI33jyLeBFnXfnUlq7E/PP6y1DNe75a1SnXCTnG9yKnv+Q/Ar8B7XZzuPm8J+S
e7pqmVKlDCN3D9B+y+cXTyuVzgtKpLgrOJNQOzUST76DCo/Pek5P86+8Ww6VVMno
NUzWtxGnhS+XkxXroA5Q20gY7BySpfKet3LxwBsYH3plKii5KQsyDrjxwjl9pts=
=jYIa
-----END PGP SIGNATURE-----

--lWL8cm7oyu1su5Oz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 10/10] ASoC: rockchip_i2s: modify DMA max burst to 1
Date: Wed, 16 Sep 2015 20:22:09 +0100
Message-ID: <20150916192209.GN12027@sirena.org.uk>
References: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
 <1442188182-6181-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2237829752277140351=="
Cc: Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
 alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
 Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Yiwei Cai <cain.cai-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
 Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>,
 Olof Johansson <olofj-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1442188182-6181-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============2237829752277140351==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aj68N5rnBpm/Ladk"
Content-Disposition: inline


--aj68N5rnBpm/Ladk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 14, 2015 at 07:49:42AM +0800, Shawn Lin wrote:

> +	default:
> +		dev_info(&pdev->dev, "Default no dma_quirk!\n");
> +		break;
> +	}

Probably printing a message when not using the quirk is a bit noisy
(hopefully future devices will fix this!).  Otherwise

Acked-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

--aj68N5rnBpm/Ladk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+cFgAAoJECTWi3JdVIfQC9AH/3JFxsm2/XrJ9OsHMR3e2gRz
JsTWeO3MgbMTPXE6SzP76GpnT4ecoiEhliYFk/Hga5u4PaYfz91V2aCMzShIwSY5
bRa9oGCGl4WhIYWyawDDgLKnMj+Q6pOokqQU/dAf3Rw9p4A+8Znemmbb4SxOAIXD
rk5UtGlAtmapn9JIyWaLTExTe5LczKTU6wAHiekZVhF7q8Wahd+8u1wRZF/QDAdW
ohzs1gm8qNQhie3tYy/CMgM4QhaMIhjFA9B+3sxtRopnHjyryYnnoBqJPmdeepRs
CTjqxko9KRv2ov83PrTblWESlreMTpYuuZS2YPEafhgPv/ZCnj1BRZAtvB5kiYo=
=Dbng
-----END PGP SIGNATURE-----

--aj68N5rnBpm/Ladk--


--===============2237829752277140351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-rockchip mailing list
Linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-rockchip

--===============2237829752277140351==--

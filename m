From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6 09/10] snd: dmaengine-pcm: add
 snd_dmaengine_pcm_get_caps interface
Date: Thu, 15 Oct 2015 09:35:01 +0530
Message-ID: <20151015040500.GB27370@localhost>
References: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
 <1444872998-2548-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>,
	Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Boojin Kim <boojin.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444872998-2548-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Oct 15, 2015 at 09:36:38AM +0800, Shawn Lin wrote:
> +int snd_dmaengine_pcm_get_caps(struct device *dev, struct dma_slave_caps *caps)
> +{
> +	struct snd_soc_platform *platform;
> +	struct dmaengine_pcm *pcm;
> +	int ret = -ENODEV;
> +
> +	platform = snd_soc_lookup_platform(dev);
> +	if (!platform)
> +		return ret;
> +
> +	pcm = soc_platform_to_pcm(platform);
> +
> +	if (pcm->chan)
> +		ret = dma_get_slave_caps(pcm->chan[0], caps);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_get_caps);

I don't see the need of this wrapper if you are not going to use this inside
common code.. Why not read this in driver, anyway you setting taht up in
next patch

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

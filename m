From: Jianqun Xu <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v6 10/10] ASoC: rockchip_i2s: modify DMA max burst to 1
Date: Thu, 15 Oct 2015 18:47:26 +0800
Message-ID: <561F843E.8040803@rock-chips.com>
References: <1444872865-2169-1-git-send-email-shawn.lin@rock-chips.com>
 <1444873008-2589-1-git-send-email-shawn.lin@rock-chips.com>
 <561F6990.7080809@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>,
	Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Boojin Kim <boojin.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yiwei Cai <cain.cai-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Jianqun Xu <xjq-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
	Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>,
	Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <561F6990.7080809-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

=E5=9C=A8 2015=E5=B9=B410=E6=9C=8815=E6=97=A5 16:53, Lars-Peter Clausen=
 =E5=86=99=E9=81=93:
> On 10/15/2015 03:36 AM, Shawn Lin wrote:
> [...]
>> +
>> +	if (snd_dmaengine_pcm_get_caps(&pdev->dev, &dma_caps) =3D=3D 0) {
>> +		if (dma_caps.max_burst > 4) {
>> +			i2s->playback_dma_data.maxburst =3D 4;
>> +			i2s->capture_dma_data.maxburst =3D 4;
>> +		} else {
>> +			i2s->playback_dma_data.maxburst =3D 1;
>> +			i2s->capture_dma_data.maxburst =3D 1;
> So this is what this is all about? I though you might have to program=
 some
> FIFO threshold registers in the peripheral itself.
>
> But it seems all this does is to read the maximum burst length from t=
he DMA
> controller only to tell the DMA controller that this is the maximum b=
urst
> length it should use. That seems rather unnecessary.
>
> The maxburst field of the dma_data indicates the maximum burst length=
 that
> the audio peripheral can handle. Typically this is the number of samp=
les the
> audio FIFO can receive without overflowing after sending the DMA requ=
est
> signal. Since as the name suggests this is the maximum burst size the=
 DMA
> controller is free to choose a burst size smaller than this when writ=
ing
> data to the peripheral.
>
> So in your case instead of introducing all these facilities to query =
the
> maximum burst size it should be OK to simply reduce the burst size in=
 the
> DMA controller itself when it gets a request with a burst size larger=
 than
> it can handle, or is there a reason why this is not possible?
Agree with Lars, it's better to fix on DMA driver side since issue=20
caused by dma-controller instead of i2s controller
>
> - Lars
>
>
>

--=20
Jianqun Xu | Software engineer | 18750760928


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

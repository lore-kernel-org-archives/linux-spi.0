From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v4 10/10] ASoC: rockchip_i2s: modify DMA max burst to 1
Date: Fri, 11 Sep 2015 20:31:16 +0800
Message-ID: <55F2C994.4040007@rock-chips.com>
References: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
 <1441502008-14116-1-git-send-email-shawn.lin@rock-chips.com>
 <20150911115331.GM12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: shawn.lin@rock-chips.com, Vinod Koul <vinod.koul@intel.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Doug Anderson <dianders@chromium.org>,
	Olof Johansson <olofj@google.com>,
	Sonny Rao <sonnyrao@chromium.org>,
	Addy Ke <addy.ke@rock-chips.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
	linux-spi@vger.kernel.org, Yiwei Cai <cain.cai@rock-chips.com>,
	Jianqun Xu <xjq@rock-chips.com>,
	Olof Johansson <olof@lixom.net>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150911115331.GM12027@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

=E5=9C=A8 2015/9/11 19:53, Mark Brown =E5=86=99=E9=81=93:
> On Sun, Sep 06, 2015 at 09:13:28AM +0800, Shawn Lin wrote:
>
>> @@ -460,7 +463,6 @@ static int rockchip_i2s_probe(struct platform_de=
vice *pdev)
>>   	i2s->playback_dma_data.addr =3D res->start + I2S_TXDR;
>>   	i2s->playback_dma_data.addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
>>   	i2s->playback_dma_data.maxburst =3D 4;
>> -
>>   	i2s->capture_dma_data.addr =3D res->start + I2S_RXDR;
>>   	i2s->capture_dma_data.addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
>>   	i2s->capture_dma_data.maxburst =3D 4;
>
> This random whitespace change shouldn't be in here.

yes, sorry for this bit.

>
>> @@ -489,6 +491,18 @@ static int rockchip_i2s_probe(struct platform_d=
evice *pdev)
>>   		goto err_pcm_register;
>>   	}
>>
>> +	dma_quirk =3D snd_dmaengine_pcm_get_quirks(&pdev->dev);
>> +	if (dma_quirk =3D=3D ROCKCHIP_I2S_BROKEN_BURST_LEN) {
>> +		/*
>
> I'd expect this to be a switch statement given the way this is writte=
n.

Ahh.. agreed, but we don't expect more quriks for this driver.  =EF=BC=9A=
=EF=BC=89)))
Will be done for the next version.

Thanks.

>


--=20
Best Regards
Shawn Lin

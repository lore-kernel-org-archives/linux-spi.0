From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2] spi: mediatek: single device does not require cs_gpios
Date: Tue, 17 Nov 2015 11:49:14 +0100
Message-ID: <564B062A.90003@gmail.com>
References: <1447042491-1199-1-git-send-email-drinkcat@chromium.org>
 <1447468039.27169.1.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
To: lei liu <leilk.liu@mediatek.com>,
	Nicolas Boichat <drinkcat@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1447468039.27169.1.camel@mhfsdcap03>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 14/11/15 03:27, lei liu wrote:
> On Mon, 2015-11-09 at 12:14 +0800, Nicolas Boichat wrote:
>> When only one device is present, it is not necessary to specify
>> cs_gpios, as the CS line can be controlled by the hardware
>> module.
>>
>> Without this patch, older device tree bindings used before
>> 37457607 "spi: mediatek: mt8173 spi multiple devices support"
>> would cause a panic on boot. This fixes the crash, and
>> re-introduces backward compatibility.
>>
>> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>
> Acked-by: Leilk Liu <leilk.liu@mediatek.com>
>

Please make sure this fix get applied to v4.3 as well.

Thanks,
Matthias

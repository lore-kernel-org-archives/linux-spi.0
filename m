From: Sunny Luo <sunny.luo@amlogic.com>
Subject: Re: [PATCH v2 3/3] spi: meson-axg: add a linear clock divider support
Date: Thu, 13 Dec 2018 21:25:38 +0800
Message-ID: <35518e71-027c-749e-1075-19ddc0410b19@amlogic.com>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
 <1544690354-16409-4-git-send-email-sunny.luo@amlogic.com>
 <3cc699dc-4021-b993-2b47-b00b40f380f8@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Yixun Lan <yixun.lan@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-spi@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
To: Neil Armstrong <narmstrong@baylibre.com>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3cc699dc-4021-b993-2b47-b00b40f380f8@baylibre.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Neil,

On 2018/12/13 16:55, Neil Armstrong wrote:
> Hi Sunny,
> 
> On 13/12/2018 09:39, Sunny Luo wrote:
>> The SPICC controller in Meson-AXG SoC is capable of using
>> a linear clock divider to reach a much fine tuned range of clocks,
>> while the old controller only use a power of two clock divider,
>> result at a more coarse clock range.
> 
> This patch should definitely go before patch 1.
Would you please show the reason?
> 
>>  
>> +	/* Set master mode and enable controller */
>> +	writel_relaxed(SPICC_ENABLE | SPICC_MODE_MASTER,
>> +		       spicc->base + SPICC_CONREG);
> 
> Please remove it from meson_spicc_prepare_message() now.
>
Yes, I moved it here and forgot remove it at prepare_message().

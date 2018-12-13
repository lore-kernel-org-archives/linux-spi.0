From: Sunny Luo <sunny.luo@amlogic.com>
Subject: Re: [PATCH v2 2/3] spi: meson-axg: enhance output enable feature
Date: Thu, 13 Dec 2018 21:12:23 +0800
Message-ID: <c85195d4-29e5-0e66-da09-cb86248660a3@amlogic.com>
References: <1544690354-16409-1-git-send-email-sunny.luo@amlogic.com>
 <1544690354-16409-3-git-send-email-sunny.luo@amlogic.com>
 <6ba11b0a-3629-5378-61c7-3cc364237f5c@baylibre.com>
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
In-Reply-To: <6ba11b0a-3629-5378-61c7-3cc364237f5c@baylibre.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Neil,

On 2018/12/13 16:53, Neil Armstrong wrote:
> Hi Sunny,
> 
> On 13/12/2018 09:39, Sunny Luo wrote:
>> The SPICC controller in Meson-AXG is capable of driving the CLK/MOSI/SS
>> signal lines through the idle state (between two transmission operation),
>> which avoid the signals floating in unexpected state.
> 
> This is welcome, because it's really missing on GX...
> I tried implementing it with pinctrl at [1], but it's complex.
> 
> Can you provide more info on how we should implement in on GX to be on par ?
> 
> [1] https://github.com/superna9999/linux/commit/9c3a95659dd532d186556c1570c54d79ea5a4d45
> 
GX is incapable of OEN. To be on par with it ,we have to pullup/down clk 
pin as
you did at[1].

>>   static const struct meson_spicc_data meson_spicc_gx_data = {
>> -	.max_speed_hz	= 30000000,
>> +	.max_speed_hz		= 30000000,
> 
> Nitpick, but I would have kept the indentation here ...
> 
>>   };
>>   
>>   static const struct meson_spicc_data meson_spicc_axg_data = {
>> -	.max_speed_hz	= 80000000,
>> +	.max_speed_hz		= 80000000,
>> +	.has_oen		= true,
> 
> same here
> 
> Anywy it's nitpick,
>  
ok, i will revert it next patch.

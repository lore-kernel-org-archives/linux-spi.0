From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
Date: Tue, 20 Nov 2018 14:35:30 +0100
Message-ID: <31c9518a-2088-7c3f-aec0-9e1b69b30745@gmail.com>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
 <0223f43b-c6a6-eade-49af-4e7b7ef7f022@gmail.com>
 <OF4FAD10C5.F4F6D29B-ON4825834B.001FAB40-4825834B.00289635@mxic.com.tw>
 <6b024f18-d0bc-3e65-f07c-cef913f795ab@gmail.com>
 <20181120143209.49217efb@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: masonccyang@mxic.com.tw, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, tpiepho@impinj.com,
        zhengxunli@mxic.com.tw
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181120143209.49217efb@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 11/20/2018 02:32 PM, Boris Brezillon wrote:
> On Tue, 20 Nov 2018 14:09:05 +0100
> Marek Vasut <marek.vasut@gmail.com> wrote:
> 
>> On 11/20/2018 08:23 AM, masonccyang@mxic.com.tw wrote:
>>> Hi Marek,  
>>
>> Hi,
>>
>>>> Marek Vasut <marek.vasut@gmail.com>
>>>> 2018/11/19 下午 10:12
>>>>
>>>> To
>>>>  
>>>>> +
>>>>> +static int rpc_spi_set_freq(struct rpc_spi *rpc, unsigned long freq)
>>>>> +{
>>>>> +   int ret;
>>>>> +
>>>>> +   if (rpc->cur_speed_hz == freq)
>>>>> +      return 0;
>>>>> +
>>>>> +   clk_disable_unprepare(rpc->clk_rpc);
>>>>> +   ret = clk_set_rate(rpc->clk_rpc, freq);
>>>>> +   if (ret)
>>>>> +      return ret;
>>>>> +
>>>>> +   ret = clk_prepare_enable(rpc->clk_rpc);
>>>>> +   if (ret)
>>>>> +      return ret;  
>>>>
>>>> Is this clock disable/update/enable really needed ? I'd think that
>>>> clk_set_rate() would handle the rate update correctly.  
>>>
>>> This is for run time PM mechanism in spi-mem layer and __spi_sync(),
>>> you may refer to another patch [1].
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-4.21&id=b942d80b0a394e8ea18fce3b032b4700439e8ca3  
>>
>> I think Geert commented on the clock topic, so let's move it there.
>> Disabling and enabling clock to change their rate looks real odd to me.
> 
> Look at the CLK_SET_RATE_GATE definition and its users and you'll see
> it's not unusual to have such constraints on clks. Maybe your HW does
> not have such constraints, but it's not particularly odd to do that
> (though it could probably be automated by the clk framework somehow).

I think you stated my concern right at the end, good, no need for me to
add to this. Yes, I don't think any random driver should deal with
peculiarities of the clock controller.

-- 
Best regards,
Marek Vasut

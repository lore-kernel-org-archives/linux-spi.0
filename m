From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] spi: qup: provide proper bus numbers
Date: Thu, 21 Jan 2016 19:26:19 +0000
Message-ID: <56A130DB.4080202@linaro.org>
References: <1453401227-27135-1-git-send-email-srinivas.kandagatla@linaro.org> <20160121183810.GN6588@sirena.org.uk> <56A127C6.9000409@linaro.org> <20160121190357.GO6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andy Gross <andy.gross@linaro.org>, linux-spi@vger.kernel.org,
	David Brown <david.brown@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20160121190357.GO6588@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 21/01/16 19:03, Mark Brown wrote:
> On Thu, Jan 21, 2016 at 06:47:34PM +0000, Srinivas Kandagatla wrote:
>> On 21/01/16 18:38, Mark Brown wrote:
>>> On Thu, Jan 21, 2016 at 06:33:47PM +0000, Srinivas Kandagatla wrote:
>
>>>> This driver reuses pdev->id for spi bus numbers resulting in random
>>>> or very large bus numbering when used with device trees. pdev->id
>>>> is not the correct choice when using device trees. So add code to
>
>>> What makes you say this, why is pdev->id not "correct"?  It is worrying
>>> if anything cares what number we pick.
>
>> Issue is that using pdev->id for bus number, as pdev->id does not get
>> populated in device tree cases.
>
> That's a statement of what currently happens...
>
>> The end users who are reading the schematics would not be able to map the
>> actual bus numbers on the schematics with the bus numbers allocated using
>> pdev->id. It add more confusion.
>
>> Without this patch the bus number allocated to this driver is 32766.
>> This does not really reflect the actual bus numbers on the boards
>> schematics.
>
> Is this really causing anyone any confusion?  Normally people are
> looking at the devices on the SPI bus rather than the bus itself...  In
> any case if this *is* causing confusion should we not be doing something
> at the bus core level that allows us to assign a descriptive name since
> this doesn't seem in the least bit SPI specific but could apply to any
> bus?
>
> There's also the problem that if someone has decided to label the bus
> with a descriptive name in their schematic (eg, "SPI_FLASH") then being
> able to assign a number doesn't do much to help, we'd need to be able to
> provide strings.  A brief survey of schematics I have to hand suggests
> that this is a thing people do.
>
>>>> get bus numbers via device tree aliases and if it fails then generate
>>>> a unique bus number.
>
>>> The other question is even if this is a good idea why is it something
>>> that should be open coded in individual drivers, if we want to change
>>> the policy we should be consistent between drivers.
>
>> Device tree aliases seems used very much in many drivers.
>> The unique bus number scheme was actually inspired by the
>> driver/tty/serial/msm_serial.c
>
> That doesn't help explain why it is a good idea to open code this in
> individual drivers.  I was asking why it's a good idea to do this in a
> single driver rather than at a higher level.

Oops!!, I should have looked at spi.c which already does exactly same 
thing. I think the logic did not get triggered because (int)-1 
overflowed into s16 busnum.

--srini

>

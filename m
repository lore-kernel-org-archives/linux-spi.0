From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: Potential NULL pointer deference in spi
Date: Fri, 11 Oct 2019 09:01:10 -0700
Message-ID: <214886b4-ec40-3959-35ff-f9b5a2507300@gmail.com>
References: <CABvMjLToYzmCue-TiDhR4Yu4v3+Z+-UV9WhixV7uvwoMh2m5Lw@mail.gmail.com>
 <f3ce1620-c421-b41f-440b-efe3ff6e91fe@gmail.com>
 <CABvMjLTrGprdgFTP-+2XC_p+vE+tVWeYvyuLGkKj1dY7KR+JDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
To: Yizhuo Zhai <yzhai003@ucr.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABvMjLTrGprdgFTP-+2XC_p+vE+tVWeYvyuLGkKj1dY7KR+JDg@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 10/10/19 10:31 PM, Yizhuo Zhai wrote:
> Hi Eric:
> 
> My apologies for bothering, we got those report via static analysis
> and haven't got a good method to verify the path to trigger them.
> Therefore I sent those email to you maintainers first since you
> know much better about the details. Sorry again for your time and
> I take your suggestions.

My suggestion is that you need to make deep investigations on your own,
before sending mails to lkml@, reaching thousands of people on the planet.

Static analysis tools having too many false positive are not worth
the time spent by humans.

I knew nothing about drivers/spi/spi.c, but after few minutes reading the code,
it was clear your report was wrong.

Do not ask us to do what you should do yourself.

Thanks.

> 
> On Wed, Oct 9, 2019 at 10:48 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>>
>>
>>
>> On 10/9/19 10:37 PM, Yizhuo Zhai wrote:
>>> Hi All:
>>>
>>> drivers/spi/spi.c:
>>>
>>> The function to_spi_device() could return NULL, but some callers
>>> in this file does not check the return value while directly dereference
>>> it, which seems potentially unsafe.
>>>
>>> Such callers include spidev_release(),  spi_dev_check(),
>>> driver_override_store(), etc.
>>>
>>>
>>
>>
>> Many of your reports are completely bogus.
>>
>> I suggest you spend more time before sending such emails to very large audience
>> and risk being ignored at some point.
>>
>> Thanks.
> 
> 
> 

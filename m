From: Eric Dumazet <eric.dumazet@gmail.com>
Subject: Re: Potential NULL pointer deference in spi
Date: Wed, 9 Oct 2019 22:48:32 -0700
Message-ID: <f3ce1620-c421-b41f-440b-efe3ff6e91fe@gmail.com>
References: <CABvMjLToYzmCue-TiDhR4Yu4v3+Z+-UV9WhixV7uvwoMh2m5Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: Yizhuo Zhai <yzhai003@ucr.edu>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Chengyu Song <csong@cs.ucr.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABvMjLToYzmCue-TiDhR4Yu4v3+Z+-UV9WhixV7uvwoMh2m5Lw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 10/9/19 10:37 PM, Yizhuo Zhai wrote:
> Hi All:
> 
> drivers/spi/spi.c:
> 
> The function to_spi_device() could return NULL, but some callers
> in this file does not check the return value while directly dereference
> it, which seems potentially unsafe.
> 
> Such callers include spidev_release(),  spi_dev_check(),
> driver_override_store(), etc.
> 
> 


Many of your reports are completely bogus.

I suggest you spend more time before sending such emails to very large audience
and risk being ignored at some point.

Thanks.

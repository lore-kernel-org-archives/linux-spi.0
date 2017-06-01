From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: [PATCH linux-next v3 1/1] spi: imx: dynamic burst length adjust
 for PIO mode
Date: Thu, 1 Jun 2017 00:55:53 -0700
Message-ID: <592FC889.3020001@mentor.com>
References: <1495774962-2981-1-git-send-email-jiada_wang@mentor.com> <CAOMZO5D4O38M3ZQYxcT2w+oW=HBuk2WPMN7Ue4Va_gz3zbKZ=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5D4O38M3ZQYxcT2w+oW=HBuk2WPMN7Ue4Va_gz3zbKZ=Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hello Fabio

On 05/29/2017 04:07 AM, Fabio Estevam wrote:
> Hi Jiada,
>
> On Fri, May 26, 2017 at 2:02 AM,<jiada_wang@mentor.com>  wrote:
>> From: Jiada Wang<jiada_wang@mentor.com>
>>
>> previously burst length (BURST_LENGTH) is always set to equal
>> to bits_per_word, causes a 10us gap between each word in
>> transfer, which significantly affects performance.
>>
>> This patch uses 32 bits transfer to simulate lower bits transfer,
>> and adjusts burst length runtimely to use biggeest burst length
>> as possible to reduce the gaps in transfer for PIO mode.
> Just curious: what is the performance gain you observe with this patch?
I did some performance test with 576/384/192 bytes data,
following is the result between the test w & w/o this patch
(ecspi controller works in PIO and loopback mode)

with this patch:
bytes      bpw      time (ms)
576         8           9.2
576         16         9.2
384         8            6.2
192          8           3.1

without this patch
bytes      bpw      time(ms)
576           8           14.4
576           16          11.6
384           8            9.6
384           16          7.8
192           8            4.8
192           16          3.9


Thanks,
Jiada

From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller documentation
Date: Wed, 8 Aug 2018 10:26:42 +0800
Message-ID: <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180807134121.GA7958@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        lanqing.liu@spreadtrum.com, linux-spi@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180807134121.GA7958@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On 7 August 2018 at 21:41, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 07, 2018 at 06:43:37PM +0800, Baolin Wang wrote:
>
>> +Optional properties:
>> +- sprd,spi-interval: Specify the intervals of two SPI frames, which can be
>> +     converted to the delay clock cycles = interval number * 4 + 10.
>
> What's a frame here, and does it overlap with any of the existing delay
> configuration we have?  In general it's better for this stuff to be
> configured at runtime by the device rather than at DT time by the
> controller since that way if the device needs the delays we always do
> them if we can and if they are only needed some of the time (eg, for
> only one device on the bus or for only some operations) then we don't
> take the performance hit when we don't need to.

Sorry for confusing. Let me try to explain it explicitly.
We can set the word size (bits_per_word) for each transmission, for
our SPI controller,  after every word size transmission, we need one
interval time (hardware automatically) to make sure the slave has
enough time to receive the whole data.

Yes, I agree we should configure it at runtime by the device, but we
did not find one member to use in 'struct spi_transfer', we just find
one similar 'delay_usecs' member in 'struct spi_transfer' but not
same. We can use  'delay_usecs' to set our hardware interval value,
but we should clean it when transfer is done, since we do not need to
delay after the transfer in spi_transfer_one _message(). Or can we add
one new member maybe named 'word_interval' to indicate the interval
time between word size transmission?

What do you prefer or other better solution? Thanks.

-- 
Baolin Wang
Best Regards

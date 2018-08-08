From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller documentation
Date: Wed, 8 Aug 2018 18:35:28 +0800
Message-ID: <CAMz4kuKZHxYiJaMHnqdAGth8XkfGnq3-Tsfc59cGjsHQHZaY7A@mail.gmail.com>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180807134121.GA7958@sirena.org.uk> <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
 <20180808095025.GB9346@sirena.org.uk>
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
In-Reply-To: <20180808095025.GB9346@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 8 August 2018 at 17:50, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 08, 2018 at 10:26:42AM +0800, Baolin Wang wrote:
>
>> Sorry for confusing. Let me try to explain it explicitly.
>> We can set the word size (bits_per_word) for each transmission, for
>> our SPI controller,  after every word size transmission, we need one
>> interval time (hardware automatically) to make sure the slave has
>> enough time to receive the whole data.
>
> OK, so it's an inter word delay.  Some other controllers definitely have
> the same feature.
>
>> Yes, I agree we should configure it at runtime by the device, but we
>> did not find one member to use in 'struct spi_transfer', we just find
>> one similar 'delay_usecs' member in 'struct spi_transfer' but not
>> same. We can use  'delay_usecs' to set our hardware interval value,
>> but we should clean it when transfer is done, since we do not need to
>> delay after the transfer in spi_transfer_one _message(). Or can we add
>> one new member maybe named 'word_interval' to indicate the interval
>> time between word size transmission?
>
> Right, I don't think we added this yet (if we did I can't see it).  I'd
> add a new field to spi_transfer for this, then other controllers with
> the same support can implement it as well and drivers can start using
> it too.

OK. So I will name the new filed as 'word_delay', is it OK for you?

-- 
Baolin Wang
Best Regards

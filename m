From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Add Spreadtrum SPI controller documentation
Date: Wed, 8 Aug 2018 19:07:48 +0800
Message-ID: <CAMz4kuKzSc0SZjzt1OB2FW-v608AvTNk5X165EMLn5_e-JhPHw@mail.gmail.com>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <20180807134121.GA7958@sirena.org.uk> <CAMz4kuJsyKv_fvrqRR3pdfKsLVy53Uj0KX+m_9jLxpcVcMvs9g@mail.gmail.com>
 <20180808095025.GB9346@sirena.org.uk> <CAMz4kuKZHxYiJaMHnqdAGth8XkfGnq3-Tsfc59cGjsHQHZaY7A@mail.gmail.com>
 <20180808105451.GE9346@sirena.org.uk>
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
In-Reply-To: <20180808105451.GE9346@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 8 August 2018 at 18:54, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 08, 2018 at 06:35:28PM +0800, Baolin Wang wrote:
>> On 8 August 2018 at 17:50, Mark Brown <broonie@kernel.org> wrote:
>
>> > Right, I don't think we added this yet (if we did I can't see it).  I'd
>> > add a new field to spi_transfer for this, then other controllers with
>> > the same support can implement it as well and drivers can start using
>> > it too.
>
>> OK. So I will name the new filed as 'word_delay', is it OK for you?
>
> Sounds good, yes.

OK. Thanks.

-- 
Baolin Wang
Best Regards

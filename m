From: Baolin Wang <baolin.wang@linaro.org>
Subject: Re: [PATCH 2/2] spi: sprd: Add SPI driver for Spreadtrum SC9860
Date: Wed, 8 Aug 2018 17:33:27 +0800
Message-ID: <CAMz4ku+EgyjGR5Oo7FQPDUOYXnJ1=tAYBZfJwgfO+44Wkv6m1w@mail.gmail.com>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <99befd2badc4dffb59662fca1e11d79f18b64755.1533638405.git.baolin.wang@linaro.org>
 <20180807142408.GB7958@sirena.org.uk> <CAMz4kuL2=7mNHLoTg7hjA4NjfGgNQ-mBJBSE8uMb0oqwnU1=Yg@mail.gmail.com>
 <20180808093148.GA9346@sirena.org.uk>
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
In-Reply-To: <20180808093148.GA9346@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 8 August 2018 at 17:31, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 08, 2018 at 10:45:33AM +0800, Baolin Wang wrote:
>> On 7 August 2018 at 22:24, Mark Brown <broonie@kernel.org> wrote:
>> > On Tue, Aug 07, 2018 at 06:43:38PM +0800, Baolin Wang wrote:
>
>> >> +     bits_per_word = bits_per_word > 16 ? round_up(bits_per_word, 16) :
>> >> +             round_up(bits_per_word, 8);
>
>> > Please
>
>> Sorry I did not get your points here, could you elaborate on?
>
> Sorry, missed the actual comment there - use normal if statements rather
> than the ternery operator, it's easier to read.

Got it. Thanks.

-- 
Baolin Wang
Best Regards

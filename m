From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] spi: qup: Add DMA capabilities
Date: Sun, 8 Mar 2015 14:20:20 +0200
Message-ID: <CAHp75Vd7+GxT01+X5u4n=tXdBu-gcmdS-AETu0yK6PWFfjzDEA@mail.gmail.com>
References: <1425463325-25805-1-git-send-email-stanimir.varbanov@linaro.org>
	<20150307112109.GJ28806@sirena.org.uk>
	<CAHp75VeYanNJrEyTtcxb5g5DB8=609nebgZm8zVAeJdmSgHjkQ@mail.gmail.com>
	<54FC30BE.1070606@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>,
	Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Andy Gross <agross@codeaurora.org>,
	Sagar Dharia <sdharia@codeaurora.org>,
	Daniel Sneddon <dsneddon@codeaurora.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <54FC30BE.1070606@metafoo.de>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Mar 8, 2015 at 1:21 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 03/07/2015 08:43 PM, Andy Shevchenko wrote:
>>
>> On Sat, Mar 7, 2015 at 1:21 PM, Mark Brown <broonie@kernel.org> wrote:

>>> Applied, but why is there no devm_dma_request_slave_channel_reason()?
>>
>> I suppose the answer would be "we have a lot of slightly different
>> cases and we have to get rid of current mess with legacy API calls".
>> The most problematic stuff now inside DMA slave subsystem is so called
>> "filter function". It's a main impediment right now as I understand.
>
> dma_request_slave_channel_reason() is the sane API though and does not use
> the filter functions. Adding a devm version of it seems reasonable.

It would be dma_request_slave_channel() in the first place, but legacy
stuff didn't allow to do that, so here we are. I wouldn't like the
idea of creating devm_dma_* before we will have stable function names
without legacy involving.

-- 
With Best Regards,
Andy Shevchenko

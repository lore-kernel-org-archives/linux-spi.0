From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] spi: qup: Add DMA capabilities
Date: Sat, 7 Mar 2015 21:43:35 +0200
Message-ID: <CAHp75VeYanNJrEyTtcxb5g5DB8=609nebgZm8zVAeJdmSgHjkQ@mail.gmail.com>
References: <1425463325-25805-1-git-send-email-stanimir.varbanov@linaro.org>
	<20150307112109.GJ28806@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stanimir Varbanov <stanimir.varbanov@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Andy Gross <agross@codeaurora.org>,
	Sagar Dharia <sdharia@codeaurora.org>,
	Daniel Sneddon <dsneddon@codeaurora.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150307112109.GJ28806@sirena.org.uk>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Mar 7, 2015 at 1:21 PM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Mar 04, 2015 at 12:02:05PM +0200, Stanimir Varbanov wrote:
>> From: Andy Gross <agross@codeaurora.org>
>>
>> This patch adds DMA capabilities to the spi-qup driver.  If DMA channels are
>> present, the QUP will use DMA instead of block mode for transfers to/from SPI
>> peripherals for transactions larger than the length of a block.
>
> Applied, but why is there no devm_dma_request_slave_channel_reason()?

I suppose the answer would be "we have a lot of slightly different
cases and we have to get rid of current mess with legacy API calls".
The most problematic stuff now inside DMA slave subsystem is so called
"filter function". It's a main impediment right now as I understand.

-- 
With Best Regards,
Andy Shevchenko

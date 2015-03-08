From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v4] spi: qup: Add DMA capabilities
Date: Sun, 08 Mar 2015 12:21:34 +0100
Message-ID: <54FC30BE.1070606@metafoo.de>
References: <1425463325-25805-1-git-send-email-stanimir.varbanov@linaro.org>	<20150307112109.GJ28806@sirena.org.uk> <CAHp75VeYanNJrEyTtcxb5g5DB8=609nebgZm8zVAeJdmSgHjkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stanimir Varbanov <stanimir.varbanov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Daniel Sneddon <dsneddon-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VeYanNJrEyTtcxb5g5DB8=609nebgZm8zVAeJdmSgHjkQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 03/07/2015 08:43 PM, Andy Shevchenko wrote:
> On Sat, Mar 7, 2015 at 1:21 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> On Wed, Mar 04, 2015 at 12:02:05PM +0200, Stanimir Varbanov wrote:
>>> From: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>>
>>> This patch adds DMA capabilities to the spi-qup driver.  If DMA channels are
>>> present, the QUP will use DMA instead of block mode for transfers to/from SPI
>>> peripherals for transactions larger than the length of a block.
>>
>> Applied, but why is there no devm_dma_request_slave_channel_reason()?
>
> I suppose the answer would be "we have a lot of slightly different
> cases and we have to get rid of current mess with legacy API calls".
> The most problematic stuff now inside DMA slave subsystem is so called
> "filter function". It's a main impediment right now as I understand.

dma_request_slave_channel_reason() is the sane API though and does not use 
the filter functions. Adding a devm version of it seems reasonable.

- Lars
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

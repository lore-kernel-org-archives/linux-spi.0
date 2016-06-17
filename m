From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [RFC] regmap: Add regmap_pipe_read API
Date: Fri, 17 Jun 2016 10:05:49 +0200
Message-ID: <5763AF5D.4090309@metafoo.de>
References: <7ca3857aa8869a1e1f4709860f57f7d92abf1c6b.1466089603.git.leonard.crestez@intel.com>
 <CAMuHMdVSQd0z=fXmr9RJ7-DY_7pHbMQri1sx2=pXZfTS=_Qrzw@mail.gmail.com>
 <643b0e6a-49a0-00bb-7aed-6d36c1e0bb6b@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	Linux I2C <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <643b0e6a-49a0-00bb-7aed-6d36c1e0bb6b-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 06/17/2016 09:04 AM, Crestez Dan Leonard wrote:
> On 06/16/2016 06:43 PM, Geert Uytterhoeven wrote:
>> Hi Leonard,
>>
>> On Thu, Jun 16, 2016 at 5:24 PM, Crestez Dan Leonard
>> <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>>> The regmap API usually assumes that bulk read operations will read a
>>> range of registers but some I2C/SPI devices have certain registers for
>>> which a such a read operation will return data from an internal FIFO
>>> instead. Add an explicit API to support bulk read with pipe rather than
>>> range semantics.
>>
>> Please settle on either "fifo" or "pipe", instead of mixing both.
>> Personally, I prefer the former.
> 
> Well, it doesn't have to be a fifo. The device can return data from some
> other kind of buffer (maybe a stack). I can adjust the documentation to
> clarify.
> 
> I considered naming it something like regmap_multi_read_one_reg or
> something but regmap_pipe_read sounds reasonable and short.

stream might be another option, but pipe is ok in my opinion.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

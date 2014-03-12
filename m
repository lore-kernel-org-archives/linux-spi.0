From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: add xtfpga SPI controller driver
Date: Wed, 12 Mar 2014 05:43:49 +0400
Message-ID: <CAMo8BfL6dwgZitRBZQEU6HCRVMRoYhPkiJWW5QTpS-cu-njR5A@mail.gmail.com>
References: <1394541891-26469-1-git-send-email-jcmvbkbc@gmail.com>
	<1394541891-26469-2-git-send-email-jcmvbkbc@gmail.com>
	<20140311194959.GB28112@sirena.org.uk>
	<CAMo8BfLTn+pneF6_7XkP66+LzpZgcefnAo_FkwxpvtYdt9yduA@mail.gmail.com>
	<20140312003401.GE28112@sirena.org.uk>
	<CAMo8Bf+dePYf0jW6zaH-4Qiy5oF-bBzHjkfzL1u6pyTS1OE46w@mail.gmail.com>
	<20140312010858.GI28112@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>,
	Marc Gauthier <marc-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140312010858.GI28112-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Mar 12, 2014 at 5:08 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Mar 12, 2014 at 04:59:47AM +0400, Max Filippov wrote:
>> On Wed, Mar 12, 2014 at 4:34 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>
>> > This driver is not actually compatible with the tlv320aic23 driver since
>> > it needs 8 bit words, you need to at least support that.  You don't need
>
>> That's strange, because the codec datasheet says the following (section
>> 3.1.1):
>
>> A control word consists of 16 bits, starting with the MSB. The data bits are
>> latched on the rising edge of SCLK. A rising edge on CS after the 16th rising
>> clock edge latches the data word into the AIC (see Figure 3-1).
>
>> And tlv320aic23 has the following regmap:
>
>> const struct regmap_config tlv320aic23_regmap = {
>>         .reg_bits = 7,
>>         .val_bits = 9,
>
> Yes, and regmap will format that itself for transmission in 8 bit words
> so you don't want the SPI controller to also do byte swapping.
>
>> and its SPI interface accordingly does the following in .probe:
>
>>         spi->bits_per_word = 16
>>         spi->mode = SPI_MODE_0;
>>         ret = spi_setup(spi);
>
> That's buggy, drivers should never configure anything more than 8 bits
> per word with regmap.

Ok, so the driver should allow for 8 bit transfers and regmap will arrange
transfers as 8-bit pairs, making CS to be asserted for 16 bits, right?

Hmmm... I see the only way to support that with that hardware: advertise
8 bit support, buffer bytes up to 16 bits, send 16 bit words on CS deassertion
request, log violations verbosely. Other ideas?

>> > hardware in the controller to support a GPIO chip select, the whole
>> > point is that the controller chip select isn't wired up and a GPIO is
>> > used instead.
>
>> Actually it's not GPIO. The controller asserts CS line once we set the
>> start bit while the busy bit is cleared and deasserts it after 16 SCK
>> pulses.
>
> You're missing the point.  The controller chip select line can do what
> it likes, it's not connected to the target device if a GPIO is being
> used.

In my case SPI controller is wired directly to the codec with three
wires: SDIN, SCLK and CS. There are no registers that can control
either of these wires independently of others.

-- 
Thanks.
-- Max
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

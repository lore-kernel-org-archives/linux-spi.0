From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [RFC] regmap: Add regmap_pipe_read API
Date: Fri, 17 Jun 2016 10:04:27 +0300
Message-ID: <643b0e6a-49a0-00bb-7aed-6d36c1e0bb6b@intel.com>
References: <7ca3857aa8869a1e1f4709860f57f7d92abf1c6b.1466089603.git.leonard.crestez@intel.com>
 <CAMuHMdVSQd0z=fXmr9RJ7-DY_7pHbMQri1sx2=pXZfTS=_Qrzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	Linux I2C <linux-i2c@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdVSQd0z=fXmr9RJ7-DY_7pHbMQri1sx2=pXZfTS=_Qrzw@mail.gmail.com>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 06/16/2016 06:43 PM, Geert Uytterhoeven wrote:
> Hi Leonard,
> 
> On Thu, Jun 16, 2016 at 5:24 PM, Crestez Dan Leonard
> <leonard.crestez@intel.com> wrote:
>> The regmap API usually assumes that bulk read operations will read a
>> range of registers but some I2C/SPI devices have certain registers for
>> which a such a read operation will return data from an internal FIFO
>> instead. Add an explicit API to support bulk read with pipe rather than
>> range semantics.
> 
> Please settle on either "fifo" or "pipe", instead of mixing both.
> Personally, I prefer the former.

Well, it doesn't have to be a fifo. The device can return data from some
other kind of buffer (maybe a stack). I can adjust the documentation to
clarify.

I considered naming it something like regmap_multi_read_one_reg or
something but regmap_pipe_read sounds reasonable and short.

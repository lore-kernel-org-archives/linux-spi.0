From: Bert Vermeulen <bert@biot.com>
Subject: Re: [PATCH] spi: rb4xx: Fix set_cs logic.
Date: Tue, 21 Apr 2015 13:01:22 +0200
Message-ID: <55362E02.3070309@biot.com>
References: <1429538005-1985-1-git-send-email-bert@biot.com>	<20150420203703.GG14892@sirena.org.uk> <CAMuHMdW=_=CJENSqNSk6Lgt8-9Ea=TmWsKmLWUKGpbM0N8MXYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdW=_=CJENSqNSk6Lgt8-9Ea=TmWsKmLWUKGpbM0N8MXYg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/21/2015 11:46 AM, Geert Uytterhoeven wrote:
> On Mon, Apr 20, 2015 at 10:37 PM, Mark Brown <broonie@kernel.org> wrote:
>> On Mon, Apr 20, 2015 at 03:53:25PM +0200, Bert Vermeulen wrote:
>>> As it turns out, the set_cs() enable parameter refers to the logic level
>>> on the CS pin, not the state of chip selection.
>>
>>> This broke functionality of the LEDs behind the CPLD, or at least delayed
>>> the commands until another one came in to toggle CS.
>>
>> No, the enable parameter *should* refer to chip select assertion (see
>> how we handle GPIO chip selects).  However it's possible that this
>> device has an inverted chip select and should be registered with the
>> SPI_CS_HIGH flag?
> 
> It's logic level:
> 
>  * @set_cs: set the logic level of the chip select line.  May be called
>  *          from interrupt context.

Right It's the implementation which doesn't really make sense IMHO: it
always inverts the "enable" parameter (unless SPI_CS_HIGH is set), in
keeping with the default active-low.

So the docs are right, but "enable" doesn't match what it does. Chip select
assertion would be a better API here. Is it worth fixing?


-- 
Bert Vermeulen        bert@biot.com          email/xmpp

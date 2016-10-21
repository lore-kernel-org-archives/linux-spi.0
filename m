From: Milo Kim <woogyom.kim@gmail.com>
Subject: Re: [PATCH 3/3] spi: sun6i: Use the driver data to get the buffer
 size
Date: Fri, 21 Oct 2016 22:39:52 +0900
Message-ID: <7dbf6c9f-361b-9e31-8305-469ba4f274a8@gmail.com>
References: <20161019140234.13518-1-woogyom.kim@gmail.com>
 <20161019140234.13518-4-woogyom.kim@gmail.com>
 <20161020155641.b3erji5vrkk3wvia@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161020155641.b3erji5vrkk3wvia@lukather>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 10/21/2016 12:56 AM, Maxime Ripard wrote:
>> -static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi, int len)
>> > +static inline void sun6i_spi_drain_fifo(struct sun6i_spi *sspi)
>> >  {
>> > +	int len = sspi->fifo_depth;
>> >  	u32 reg, cnt;
>> >  	u8 byte;
> I'm not so sure about this one. This function was initially to drain
> any given number of bytes, which might be of interest at some point.
>
> Removing that argument also remove that ability... Any particular
> reason you want to change it?

I just wanted to remove duplicate variable but I agree with you. Let me 
drop this in the next patch-set. Thanks for your comments.

Best regards,
Milo

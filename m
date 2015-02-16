From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] spi: spidev: only use up TX/RX bounce buffer space when
 needed
Date: Mon, 16 Feb 2015 10:18:01 +0000
Message-ID: <54E1C3D9.2010406@mev.co.uk>
References: <1423743188-1821-1-git-send-email-abbotti@mev.co.uk> <20150214044910.GF9110@finisterre.sirena.org.uk> <54E0753E.30208@mev.co.uk> <20150216041321.GM9110@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150216041321.GM9110@finisterre.sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 16/02/15 04:13, Mark Brown wrote:
> On Sun, Feb 15, 2015 at 10:30:22AM +0000, Ian Abbott wrote:
>> On 14/02/15 04:49, Mark Brown wrote:
>
>>> This is a bit hard to parse.  I think you're talking about buffers in
>>> spidev here but it's unclear and you've not described in what way you're
>>> changing the code and we do currently only seem to copy data when the
>>> user has asked for it.
>
>> Yes, I was talking about spidev. I did tag it in the subject line of the
>> commit message, though I'm sorry if the rest of it is difficult to parse.
>
> Right, but it's not clear if you mean that this is something to do with
> the device drivers for SPI controllers or spidev itself.

Okay, how about if I used the term "spidev device" to distinguish it 
from the lower-level SPI device?

>> Yes, the patch limits the total user-specified TX data and the total
>> user-specified RX data to the pre-allocated buffer size individually rather
>> than limiting the total sum of user RX and TX data.
>
> Your commit message needs to say this rather than requiring the user to
> reverse engineer it from the code - a key part of reviewing a code
> change is making sure that it does what the commit message says that it
> does to make sure that it is having the indended effect.

I thought it said that (somewhat clumsily) in the first paragraph.

>> The check against INT_MAX is there because a struct spi_ioc_transfer might
>> have rx_buf==NULL, tx_buf==NULL and len!=0, in which case it would no longer
>> use up space in either of the pre-allocated buffers so neither rx_total nor
>> tx_total would increase.  Checking the sum of the len fields against INT_MAX
>> prevents arithmetic overflow in the return value of the function.
>
> If that's what the code is supposed to do then someone reading the code
> needs to be able to tell that without too much effort, I'd not expect
> that to be possible as things are.  Maintainability is very important.

There was a whole paragraph about that in the commit message, but maybe 
it was too concise.

I'll have another attempt at the commit message to make it less concise 
and hopefully easier to follow!

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-

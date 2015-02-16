From: Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] spi: spidev: only use up TX/RX bounce buffer space when
 needed
Date: Mon, 16 Feb 2015 14:33:37 +0000
Message-ID: <54E1FFC1.60104@mev.co.uk>
References: <1423743188-1821-1-git-send-email-abbotti@mev.co.uk> <20150214044910.GF9110@finisterre.sirena.org.uk> <54E0753E.30208@mev.co.uk> <20150216041321.GM9110@finisterre.sirena.org.uk> <54E1C3D9.2010406@mev.co.uk> <20150216132302.GO9110@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150216132302.GO9110@finisterre.sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 16/02/15 13:23, Mark Brown wrote:
> On Mon, Feb 16, 2015 at 10:18:01AM +0000, Ian Abbott wrote:
>> On 16/02/15 04:13, Mark Brown wrote:
 >>> On Sun, Feb 15, 2015 at 10:30:22AM +0000, Ian Abbott wrote:
>>>> The check against INT_MAX is there because a struct spi_ioc_transfer might
>>>> have rx_buf==NULL, tx_buf==NULL and len!=0, in which case it would no longer
>>>> use up space in either of the pre-allocated buffers so neither rx_total nor
>>>> tx_total would increase.  Checking the sum of the len fields against INT_MAX
>>>> prevents arithmetic overflow in the return value of the function.
>
>>> If that's what the code is supposed to do then someone reading the code
>>> needs to be able to tell that without too much effort, I'd not expect
>>> that to be possible as things are.  Maintainability is very important.
>
>> There was a whole paragraph about that in the commit message, but maybe it
>> was too concise.
>
> The commit message is not the code.  The code itself needs to be clear,
> and even based on what's in the commit message it's not terribly obvious
> (and with the above the return value that will be overflowed doesn't
> jump out).

Good point.  I'll add some comments to the code.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk> )=-
-=(                          Web: http://www.mev.co.uk/  )=-

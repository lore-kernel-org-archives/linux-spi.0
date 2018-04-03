From: Sergey Suloev <ssuloev@orpaltech.com>
Subject: Re: [PATCH 2/6] spi: sun4i: restrict transfer length in PIO-mode
Date: Tue, 3 Apr 2018 14:08:43 +0300
Message-ID: <4390604e-092b-a89d-3581-b57ee9cbb6a1@orpaltech.com>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-3-ssuloev@orpaltech.com>
 <20180403081041.3ully6bcyfwx2cx6@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180403081041.3ully6bcyfwx2cx6@flea>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On 04/03/2018 11:10 AM, Maxime Ripard wrote:
> On Thu, Mar 29, 2018 at 09:59:03PM +0300, Sergey Suloev wrote:
>> There is no need to handle 3/4 empty/full interrupts as the maximum
>> supported transfer length in PIO mode is 64 bytes for sun4i-family
>> SoCs.
> That assumes that you'll be able to treat the FIFO full interrupt and
> drain the FIFO before we have the next byte coming in. This would
> require a real time system, and we're not in one of them.
>
> Maxime
>
AFAIK in SPI protocol we send and receive at the same time. As soon as 
the transfer length

is <= FIFO depth then it means that at the moment we get TC interrupt 
all data for this transfer

sent/received already.

Is your point here that draining FIFO might be a long operation and we 
can lose next portion of data ?

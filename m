From: kernel@martin.sperl.org
Subject: Re: [PATCH 3/3] spi: bcm2835: add module parameter to configure
 minimum length for dma
Date: Sun, 24 Mar 2019 09:52:15 +0100
Message-ID: <51785E57-E503-439B-AC68-90AA265D51A4@martin.sperl.org>
References: <20190224162311.23899-1-kernel@martin.sperl.org>
 <20190224162311.23899-3-kernel@martin.sperl.org>
 <146076124.93355.1551035437078@email.ionos.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Eric Anholt <eric@anholt.net>, Mark Brown <broonie@kernel.org>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <146076124.93355.1551035437078@email.ionos.de>
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


> On 24.02.2019, at 20:10, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> 
> Hi Martin,
> 
>> kernel@martin.sperl.org hat am 24. Februar 2019 um 17:23 geschrieben:
>> 
>> 
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> Allow setting the length of the transfer at which dma is used by
>> setting a module parameter.
> 
> please provide the motivation of this change.
As we provide control over the selection of polling vs. interrupt mode
we should - for consistency - also provide control over selection of 
DMA mode.

DMA mapping is quite expensive and with higher SPI clock speeds it
may be more economic CPU wise to run in polling mode instead of DMA
mode.

Also DMA mode has one specific difference to Polling mode:
there is no idle clock cycle between bytes transferred.

This may have negative impact when transferring lots of bytes to
some mcus without SPI buffers at the fastest possible clock speed,
where it helps when there is a gap after each byte.

Martin

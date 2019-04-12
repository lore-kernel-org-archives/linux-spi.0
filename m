From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH v4 2/4] spi: Split spi message into max_dma_len size chunks
Date: Fri, 12 Apr 2019 13:34:48 +0200
Message-ID: <2B363C38-CDAF-4720-B43F-784CFA05716E@martin.sperl.org>
References: <20190412102206.GG6909@sirena.org.uk>
 <20190412094721.GE6909@sirena.org.uk>
 <20190412105448.6xamxj2wtuu3yxvt@wunner.de>
 <20190412110934.GH6909@sirena.org.uk>
 <20190412111615.25iogtr6qwc5zbx7@wunner.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
 dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
 meghana.madhyastha-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190412111615.25iogtr6qwc5zbx7-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


> On 12.04.2019, at 13:16, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> 
> On Fri, Apr 12, 2019 at 12:09:34PM +0100, Mark Brown wrote:
>> On Fri, Apr 12, 2019 at 12:54:48PM +0200, Lukas Wunner wrote:
>>> On Fri, Apr 12, 2019 at 10:47:21AM +0100, Mark Brown wrote:
>>>> I *think* we managed to fix all the architectures to at least stub out
>>>> the DMA interfaces, it's such a pointless thing to have conditional -
>>>> it really only makes a difference for build coverage.
>> 
>>> My point was that the call to spi_split_transfers_maxsize() shouldn't
>>> be called on non-DMA-capable platforms in the first place (because it's
>>> DMA-specific).
>> 
>> It's not a DMA specific problem - there can be SPI controller
>> limitations on transfer sizes too.
> 
> The call does pass in ctlr->max_dma_len though, so is clearly motivated
> by a DMA limitation.
The limitation is in this register: BCM2835_SPI_DLEN

Where the bcm2835-SDK (Brcm_Android_ICS_Graphics_Stack.tar.gz)defines:
bit 0-15 for DLEN

See transformed data at:
https://github.com/msperl/rpi-registers/blob/master/md/Region_SPI.md

Or the Arm Periperial Document on page 156 with regards to DLEN register.

This is where the DMA length limit comes from - so it is NOT
really DMA block related but SPI block related.

More specifically to DMA requests are only triggered when this counter
is > 0.

That is unless the Documentation has another errata and more bits are
actually allowed.

Martin

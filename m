From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH v4 2/4] spi: Split spi message into max_dma_len size chunks
Date: Fri, 12 Apr 2019 12:03:35 +0200
Message-ID: <B40B4313-3965-42D9-9228-92E275A7D2AA@martin.sperl.org>
References: <20190411164235.49771-1-noralf@tronnes.org>
 <20190411164235.49771-3-noralf@tronnes.org>
 <20190411181836.t2vuutqhjglsxsaz@wunner.de>
 <98571639-840a-494c-9e41-29ff89a22a8e@tronnes.org>
 <20190412094721.GE6909@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 =?iso-8859-1?Q?Noralf_Tr=F8nnes?= <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>,
 linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
 meghana.madhyastha-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190412094721.GE6909-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
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


> On 12.04.2019, at 11:47, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> 
>> In a previous version of this I suggested to Meghana to put this in the
>> driver, but Mark wanted it in the core.
> 
> If we want to do this at a lower level the DMA code could hide this
> limitation from the upper layers; presumably the SPI driver isn't the
> only thing that might run into this.

For clarification:
There is a register of the SPI controller where you have to configure the
number of bytes that it will request via DMA (primarily support transfers
that are not a multiple of 4 - the data is transferred by DMA as words).
So it is not really related to the general DMA implementation but to the
DMA (request) support of the SPI controller.

Martin

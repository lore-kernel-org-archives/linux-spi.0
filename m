From: Flavio Suligoi <f.suligoi@asem.it>
Subject: RE: [PATCH 1/1] spi: pxa2xx: add driver enabling message
Date: Wed, 10 Apr 2019 08:47:53 +0000
Message-ID: <358f26bc47bd4aa289971f0a763b27cb@asem.it>
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
 <51e9e073-625d-f5c0-6b2e-410f6ddb6346@linux.intel.com>
 <6cef52a73fb547bb9c0dd84efca8f7f8@asem.it>
 <2c853342-f937-30e6-ce6f-010e06f7376c@linux.intel.com>
 <2a8b7e65d1334a5491b8bc9e9a96a685@asem.it>
 <400467d8-19d6-1796-5fa9-cb5b37d61792@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Daniel Mack
 <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, "Robert
 Jarzmik" <robert.jarzmik@free.fr>, Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <400467d8-19d6-1796-5fa9-cb5b37d61792@linux.intel.com>
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

> On 4/10/19 11:13 AM, Flavio Suligoi wrote:
> >> [    9.506895] pxa2xx-spi pxa2xx-spi.13: no DMA channels available,
> >> using PIO
> >> [    9.516770] pxa2xx-spi pxa2xx-spi.13: registered master spi2
> >> [    9.518527] pxa2xx-spi pxa2xx-spi.13: PXA2xx SPI master controller
> >> (PIO mode)
> >
> > I have added this message because, using an x86 machine, the message:
> >
> > "pxa2xx-spi pxa2xx-spi.13: registered master spi2"
> >
> > doesn't appear in the kernel messages!
> >
> Yeah, it needs CONFIG_SPI_DEBUG.
> 
> >> Actually this info message doesn't necessarily tell will the driver end
> >> up using DMA for transfers. See pxa2xx_spi_can_dma() and
> >> pxa2xx_spi_transfer_one().
> >>
> >> How about replacing "no DMA channels available, using PIO" and have
> >> instead single info message telling is the DMA available or does the
> >> driver use PIO only?
> >
> > Ok, it's a good idea, to avoid to many similar messages.
> > So I can simply remove the:
> >
> > "no DMA channels available, using PIO"
> >
> > and leave only the new:
> >
> > " pxa2xx-spi pxa2xx-spi.13: PXA2xx SPI master controller (PIO mode)"
> >
> Yes, something like that.
> 
> Now I remember, please also take into account driver is dual role since
> commit ec93cb6f827b ("spi: pxa2xx: Add slave mode support").

Ok, right, I have to consider the slave mode, too.

Thanks Jarkko!

Flavio

From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH] spi: atmel: Remove AVR32 leftover
Date: Thu, 19 Sep 2019 21:13:08 +0200
Message-ID: <20190919211308.56c9503e@windsurf>
References: <20190919154034.7489-1-gregory.clement@bootlin.com>
        <20190919172453.GA21254@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190919172453.GA21254@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, 19 Sep 2019 19:24:53 +0200
Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> On 19/09/2019 17:40:34+0200, Gregory CLEMENT wrote:
> > AV32 support has been from the kernel a few release ago, but there was  
> AVR32 and  missing word^
> 
> > still some specific macro for this architecture in this driver. Lets
> > remove it.

If you want to actually be pedantic, there are a few other typos in the
commit. Hopefully the below text has all of them fixed (and does not
introduce any new one):

==

AVR32 support has been removed from the kernel a few releases ago, but
there were still some specific macros for this architecture in this
driver. Let's remove them.

==

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

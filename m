From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH 3/8] spi: spi-ep93xx: always handle transfer specific
 settings
Date: Mon, 1 Jul 2013 13:15:40 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DAC38FFB9@AUSP01VMBX24.collaborationhost.net>
References: <201306281143.35130.hartleys@visionengravers.com>
 <20130701102757.GF27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	Ryan Mallon <rmallon@gmail.com>,
	"mika.westerberg@iki.fi" <mika.westerberg@iki.fi>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130701102757.GF27646@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Monday, July 01, 2013 3:28 AM, Mark Brown wrote:
> On Fri, Jun 28, 2013 at 11:43:34AM -0700, H Hartley Sweeten wrote:
>> __spi_async(), which starts every SPI message transfer, initializes
>> the bits_per_word and max speed for every transfer in the message.
>> Since the conditional test in ep93xx_spi_process_transfer() will
>> always succeed just remove it and always call ep93xx_spi_chip_setup()
>> to configure the hardware for each transfer in the message.
>
> Applied, thanks.

Mark,

I was going to redo this series based on the comments I have received
so far. Did you already apply this one? Should I push it to the front of my
patchset?

Regards,
Hartley

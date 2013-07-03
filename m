From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH v2 05/11] spi: spi-ep93xx: use devm_clk_get()
Date: Wed, 3 Jul 2013 14:00:22 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DAC390360@AUSP01VMBX24.collaborationhost.net>
References: <201307021008.22347.hartleys@visionengravers.com>
 <20130703182125.GZ27646@sirena.org.uk>
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
In-Reply-To: <20130703182125.GZ27646@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wednesday, July 03, 2013 11:21 AM, Mark Brown wrote:
> On Tue, Jul 02, 2013 at 10:08:21AM -0700, H Hartley Sweeten wrote:
>> Use devm_clk_get() so that the clk_put() happens automatically when
>> the last reference to this driver is dropped.
>
> This doesn't apply against current code - always submit against the
> relevant development tree, in this case topic/ep93xx.  I've applied it
> with a manual fixup.

Sorry about the trouble. Thanks for fixing it.

Regards,
Hartley

From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: RE: [PATCH v2 05/11] spi: spi-ep93xx: use devm_clk_get()
Date: Wed, 3 Jul 2013 16:12:39 -0500
Message-ID: <ADE657CA350FB648AAC2C43247A983F0021DAC39039F@AUSP01VMBX24.collaborationhost.net>
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

Hello Mark,

It appears your topic/ep93xx branch is missing this:

commit 24778be20f87d5aadb19624fc768b3159fa43efc
Author: Stephen Warren <swarren@wwwdotorg.org>
Date:   Tue May 21 20:36:35 2013 -0600

    spi: convert drivers to use bits_per_word_mask

This commit is in linux-next which is what the patch series was based on.
I'm not sure what branch you applied that patch to.

If you need to drop my previous patches that you applied to topic/ep93xx
in order to sync things up please let me know how to proceed. There are
four more patches pending for spi-ep93xx to finish the cleanup and convert
it to the SPI queued driver infrastructure.

These are the relevant commits in topic/spi-ep93xx:

kernel / pub/scm/linux/kernel/git/broonie/spi / topic/ep93xx / drivers / spi / spi-ep93xx.c

3051c43  spi: spi-ep93xx: use devm_clk_get() by H Hartley Sweeten - 28 hours ago topic/ep93xx
e5ae625  spi: spi-ep93xx: remove 'dss' from per chip private data by H Hartley Sweeten - 28 hours ago
4af59ef  spi: spi-ep93xx: remove dev_err() for kzalloc() failure by H Hartley Sweeten - 28 hours ago
8b9d957  spi: spi-ep93xx: get platform resources early in (*probe) by H Hartley Sweeten - 28 hours ago
c6b7f14  spi: spi-ep93xx: remove bits_per_word() helper by H Hartley Sweeten - 28 hours ago
75c7444  spi: spi-ep93xx: use read,write instead of __raw_* variants by H Hartley Sweeten - 28 hours ago
eb41eeb  spi: spi-ep93xx: always handle transfer specific settings by H Hartley Sweeten - 5 days ago

Sorry about the trouble. I don't have your tree pulled so I was starting
from linux-next under the assumption that it was current to your tree.

Regards,
Hartley

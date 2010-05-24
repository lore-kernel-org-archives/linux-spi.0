From: Scott Ellis <scott@jumpnowtek.com>
Subject: Re: [PATCH 5/6] SPI omap2_mcspi.c: Use num chipselects from
 platform data
Date: Mon, 24 May 2010 11:14:01 -0400
Message-ID: <1274714041.2888.39.camel@quad>
References: <1268407329.14445.54.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	Tony Lindgren <tony@atomide.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Roman Tereshonkov <roman.tereshonkov@nokia.com>,
	linux-omap@vger.kernel.org,
	Aaro Koskinen <Aaro.Koskinen@nokia.com>,
	Kevin Hilman <khilman@deeprootsystems.com>
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1268407329.14445.54.camel@quad>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This was convenient in conjunction with some of the previous patches
since platform_device data was already getting read for max_clk_div and
num_cs was there too. Since max_clk_div is no more, maybe this patch
isn't worthwhile.

It's not a bug fix, so no harm ignoring.

I'll regenerate it if asked. 




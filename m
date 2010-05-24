From: Scott Ellis <scott@jumpnowtek.com>
Subject: Re: [PATCH 4/6] SPI omap2_mcspi.c: Use the transfer speed_hz value
 if provided
Date: Mon, 24 May 2010 10:44:38 -0400
Message-ID: <1274712278.2888.28.camel@quad>
References: <1268407324.14445.53.camel@quad>
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
In-Reply-To: <1268407324.14445.53.camel@quad>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Please ignore this patch.

The changes already in 2.6.34-rc7 are sufficient.

They made it there because I initially submitted to the wrong list.

This patch was expanded from that one to also using the modified clock
divider values from patches 2 and 3 of this series which I have found
aren't needed.



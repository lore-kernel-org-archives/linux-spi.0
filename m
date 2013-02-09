From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] gpio: mcp23s08: convert driver to DT
Date: Sat, 09 Feb 2013 14:31:20 +0000
Message-ID: <20130209143120.AA32B3E30EC@localhost>
References: <1360170118-11937-1-git-send-email-larsi@wh2.tu-dresden.de> <1360170118-11937-3-git-send-email-larsi@wh2.tu-dresden.de>
Cc: w.sang@pengutronix.de, ben-linux@fluff.org,
	linux-i2c@vger.kernel.org
To: Lars Poeschel <larsi@wh2.tu-dresden.de>, poeschel@lemonage.de,
	rob.herring@calxeda.com, rob@landley.net, linus.walleij@linaro.org,
	devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1360170118-11937-3-git-send-email-larsi@wh2.tu-dresden.de>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed,  6 Feb 2013 18:01:58 +0100, Lars Poeschel <larsi@wh2.tu-dresden.de> wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> 
> This converts the mcp23s08 driver to be able to be used with device
> tree.
> There is a special "mcp,chips" property, that correspond to the chips
> member of the struct mcp23s08_platform_data. It can be used for
> multiple mcp23s08/mc23s17 on the same spi chipselect.
> 
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

Ah, ignore my previous email. You did convert the driver. I've applied
the two patches. Actually I squashed them together since they really
were one logical change.

g.


From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 5/6] of_spi: Add fetching of of_gpio flags to of_spi_register_master
Date: Mon, 11 Feb 2013 00:22:20 +0000
Message-ID: <20130211002220.AFCA83E0C13@localhost>
References: <1359471223-4794-1-git-send-email-andreas@gaisler.com> <1359471223-4794-6-git-send-email-andreas@gaisler.com>
Cc: Rob Herring <rob.herring@calxeda.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	devicetree-discuss@lists.ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, software@gaisler.com
To: Andreas Larsson <andreas@gaisler.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359471223-4794-6-git-send-email-andreas@gaisler.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 29 Jan 2013 15:53:42 +0100, Andreas Larsson <andreas@gaisler.com> wrote:
> When using a gpio chip select with a OF_GPIO_ACTIVE_LOW flag, this needs to be
> known to the controller driver.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>

Out of curiosity, what do you need the flags for? Polarity of the CS
signal? I think it is long past time to revisit baking polarity control
into core of gpiolib. Would you mind investigating doing that instead of
having to manage it manually in each and every driver?

g.

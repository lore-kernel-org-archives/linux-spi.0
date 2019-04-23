From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 1/2] spi: Micrel eth switch: declare missing of table
Date: Tue, 23 Apr 2019 14:28:57 +0200
Message-ID: <20190423122857.GB3371@lunn.ch>
References: <1555960084-8462-1-git-send-email-dagmcr@gmail.com>
 <d4376323-36b7-d463-dc75-56970f750d35@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Gomez <dagmcr@gmail.com>, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org, javier@dowhile0.org,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d4376323-36b7-d463-dc75-56970f750d35@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> I wonder why this SPI driver is under drivers/net/phy. Just because
> the SPI IP is found on an ethernet switch chip? And even then it
> would be wrong, I see no link to a PHY at all. I'd say the driver
> belongs to drivers/spi. Shouldn't we move it?

This driver is old. It is probably from before the time of DSA. At
least in the OpenWRT world, switches have been thought of as PHY
devices, since they connect to a MAC. All the OpenWRT switch drivers
are in the phy directory.

There is no good place for this. It is not a PHY, but it is a network
driver so should be somewhere under driver/net. There are no other net
drivers in driver/spi, etc.

Since there is not a good place for it, not moving it is the easiest
thing to do.

      Andrew

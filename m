From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/2] spi: Micrel eth switch: declare missing of table
Date: Tue, 23 Apr 2019 19:33:10 +0200
Message-ID: <0d2f503f-bd45-0009-343c-e6d47d7d6fe1@gmail.com>
References: <1555960084-8462-1-git-send-email-dagmcr@gmail.com>
 <d4376323-36b7-d463-dc75-56970f750d35@gmail.com>
 <20190423122857.GB3371@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Daniel Gomez <dagmcr@gmail.com>, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org, javier@dowhile0.org,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190423122857.GB3371@lunn.ch>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 23.04.2019 14:28, Andrew Lunn wrote:
>> I wonder why this SPI driver is under drivers/net/phy. Just because
>> the SPI IP is found on an ethernet switch chip? And even then it
>> would be wrong, I see no link to a PHY at all. I'd say the driver
>> belongs to drivers/spi. Shouldn't we move it?
> 
> This driver is old. It is probably from before the time of DSA. At
> least in the OpenWRT world, switches have been thought of as PHY
> devices, since they connect to a MAC. All the OpenWRT switch drivers
> are in the phy directory.
> 
> There is no good place for this. It is not a PHY, but it is a network
> driver so should be somewhere under driver/net. There are no other net
> drivers in driver/spi, etc.
> 
Except having "switch" in the name this driver is solely a SPI driver
and it uses no network code at all. And it has no dependency on any
network driver. Therefore I wouldn't consider it a network driver.
Else any functionality found on a SoC would need to be under drivers/soc ;)

> Since there is not a good place for it, not moving it is the easiest
> thing to do.
> 
>       Andrew
> 
Heiner

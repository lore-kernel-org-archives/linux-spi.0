From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 1/2] spi: Micrel eth switch: declare missing of table
Date: Tue, 23 Apr 2019 08:04:48 +0200
Message-ID: <d4376323-36b7-d463-dc75-56970f750d35@gmail.com>
References: <1555960084-8462-1-git-send-email-dagmcr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: davem@davemloft.net, netdev@vger.kernel.org, javier@dowhile0.org,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
To: Daniel Gomez <dagmcr@gmail.com>, andrew@lunn.ch,
        f.fainelli@gmail.com
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1555960084-8462-1-git-send-email-dagmcr@gmail.com>
Content-Language: en-US
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 22.04.2019 21:08, Daniel Gomez wrote:
> Add missing <of_device_id> table for SPI driver relying on SPI
> device match since compatible is in a DT binding or in a DTS.
> 
> Before this patch:
> modinfo drivers/net/phy/spi_ks8995.ko | grep alias
> alias:          spi:ksz8795
> alias:          spi:ksz8864
> alias:          spi:ks8995
> 
> After this patch:
> modinfo drivers/net/phy/spi_ks8995.ko | grep alias
> alias:          spi:ksz8795
> alias:          spi:ksz8864
> alias:          spi:ks8995
> alias:          of:N*T*Cmicrel,ksz8795C*
> alias:          of:N*T*Cmicrel,ksz8795
> alias:          of:N*T*Cmicrel,ksz8864C*
> alias:          of:N*T*Cmicrel,ksz8864
> alias:          of:N*T*Cmicrel,ks8995C*
> alias:          of:N*T*Cmicrel,ks8995
> 
> Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
> Signed-off-by: Daniel Gomez <dagmcr@gmail.com>
> ---
>  drivers/net/phy/spi_ks8995.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
I wonder why this SPI driver is under drivers/net/phy. Just because
the SPI IP is found on an ethernet switch chip? And even then it
would be wrong, I see no link to a PHY at all. I'd say the driver
belongs to drivers/spi. Shouldn't we move it?

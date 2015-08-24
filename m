From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH linux-next v4 1/5] mtd: spi-nor: notify (Q)SPI controller about protocol change
Date: Mon, 24 Aug 2015 12:16:20 +0200
Message-ID: <201508241216.20506.marex@denx.de>
References: <cover.1440410236.git.cyrille.pitchen@atmel.com> <9649a13a50c33ef38045342353fc487a914ae337.1440410236.git.cyrille.pitchen@atmel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: nicolas.ferre@atmel.com, broonie@kernel.org,
	linux-spi@vger.kernel.org, dwmw2@infradead.org,
	computersforpeace@gmail.com, zajec5@gmail.com, beanhuo@micron.com,
	juhosg@openwrt.org, shijie.huang@intel.com, ben@decadent.org.uk,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, linux-mtd@lists.infradead.org
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9649a13a50c33ef38045342353fc487a914ae337.1440410236.git.cyrille.pitchen@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Monday, August 24, 2015 at 12:13:56 PM, Cyrille Pitchen wrote:
> Once the Quad SPI mode has been enabled on a Micron flash memory, this
> device expects ALL the following commands to use the SPI 4-4-4 protocol.
> The (Q)SPI controller needs to be notified about the protocol change so it
> can adapt and keep on dialoging with the Micron memory.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Awesome,

Acked-by: Marek Vasut <marex@denx.de>

If this could be applied separately (since I want to use the same functionality
for the Cadence QSPI driver), I'd be really happy too :)

Best regards,
Marek Vasut

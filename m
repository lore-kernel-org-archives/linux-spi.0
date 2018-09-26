From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] arm64: dts: rockchip: Enable SPI NOR flash on Rock64
Date: Wed, 26 Sep 2018 13:38:53 +0200
Message-ID: <2872521.VFYVRVU0oA@phil>
References: <20180926045357.20722-1-wens@csie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180926045357.20722-1-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Am Mittwoch, 26. September 2018, 06:53:57 CEST schrieb Chen-Yu Tsai:
> The Pine64 Rock64 board comes with a GigaDevice GD25Q128CSIG
> or GD25Q127CSIG chip, which is a 128 Mbit SPI NOR flash chip
> that supports the JEDEC read-ID command.
> 
> This patch enables the SPI controller and adds a device node
> for the flash chip using the generic "jedec,spi-nor" comaptible.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

applied for 4.20

Thanks
Heiko

From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH] ARM: dts: imx6q: Use correct SDMA script for SPI5 core
Date: Mon, 11 Jun 2018 14:41:06 +0800
Message-ID: <20180611064104.GD16091@dragon>
References: <20180522174509.18154-1-sean.nyekjaer@prevas.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: s.hauer@pengutronix.de, linux-spi@vger.kernel.org,
 anton.bondarenko.sama@gmail.com, broonie@kernel.org, stable@kernel.vger.org,
 linux-arm-kernel@lists.infradead.org
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180522174509.18154-1-sean.nyekjaer@prevas.dk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Tue, May 22, 2018 at 07:45:09PM +0200, Sean Nyekjaer wrote:
> According to the reference manual the shp_2_mcu / mcu_2_shp
> scripts must be used for devices connected through the SPBA.
> 
> This fixes an issue we saw with DMA transfers.
> Sometimes the SPI controller RX FIFO was not empty after a DMA
> transfer and the driver got stuck in the next PIO transfer when
> it read one word more than expected.
> 
> commit dd4b487b32a35 ("ARM: dts: imx6: Use correct SDMA script
> for SPI cores") is fixing the same issue but only for SPI1 - 4.
> 
> Fixes: 677940258dd8e ("ARM: dts: imx6q: enable dma for ecspi5")
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>

Applied, thanks.

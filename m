From: Marek Vasut <marex@denx.de>
Subject: Re: [LINUX RFC v2 0/4] spi: add dual parallel mode support in Zynq
 MPSoC GQSPI controller
Date: Wed, 26 Aug 2015 08:56:22 +0200
Message-ID: <201508260856.22258.marex@denx.de>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: harinik@xilinx.com, juhosg@openwrt.org, ben@decadent.org.uk,
 zajec5@gmail.com, linux-spi@vger.kernel.org, michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org, b32955@freescale.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 knut.wohlrab@de.bosch.com, punnaia@xilinx.com, computersforpeace@gmail.com,
 dwmw2@infradead.org, soren.brinkmann@xilinx.com, beanhuo@micron.com
To: Ranjit Waghmode <ranjit.waghmode@xilinx.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
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

On Wednesday, August 26, 2015 at 08:26:03 AM, Ranjit Waghmode wrote:
> This series adds dual parallel mode support for Zynq Ultrascale+
> MPSoC GQSPI controller driver.
> 
> What is dual parallel mode?
> ---------------------------
> ZynqMP GQSPI controller supports Dual Parallel mode with following
> functionalities: 1) Supporting two SPI flash memories operating in
> parallel. 8 I/O lines. 2) Chip selects and clock are shared to both the
> flash devices
> 3) This mode is targeted for faster read/write speed and also doubles the
> size 4) Commands/data can be transmitted/received from both the
> devices(mirror), or only upper or only lower flash memory devices.
> 5) Data arrangement:
>    With stripe enabled,
>    Even bytes i.e. 0, 2, 4,... are transmitted on Lower Data Bus
>    Odd bytes i.e. 1, 3, 5,.. are transmitted on Upper Data Bus.

This might be a dumb question, but why don't you just treat this as an
SPI NOR flash with 8-bit bus ?

Best regards,
Marek Vasut

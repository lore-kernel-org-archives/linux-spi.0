From: Amelie DELAUNAY <amelie.delaunay@st.com>
Subject: Re: [PATCH 0/5] Add support for STM32F4 SPI
Date: Mon, 10 Dec 2018 12:37:56 +0000
Message-ID: <ede8544f-c71d-0901-5522-e97215d23f85@st.com>
References: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: "cezary.gapinski@gmail.com" <cezary.gapinski@gmail.com>, Mark Brown
 <broonie@kernel.org>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1544363636-12161-1-git-send-email-cezary.gapinski@gmail.com>
Content-Language: en-US
Content-ID: <3AC5027D79CC5B45A933F00D59740D08@st.com>
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

Hi Cezary,

On 12/9/18 2:53 PM, cezary.gapinski@gmail.com wrote:
> From: Cezary Gapinski <cezary.gapinski@gmail.com>
> 
> This series of patches adds support for first generation of SPI interface
> for STM32F4 family.
> 

First of all, thanks for adding STM32F4 SPI support.

> This version of driver is mostly different to STM32H7 one. Based on linux
> kernel I2C drivers for STM32 where drivers were splited into STM32F4 and
> STM32F7 family the same approach seems to be sufficient for SPI STM32
> drivers. Therefore STM32H7 driver was moved to spi-stm32h7.c file and
> register and functions were renamed to be more specific to STM32H7.
> 

You're right, STM32F4 SPI is slightly different from STM32H7 one: 
register map/bits offsets are different and STM32H7 has an RX and TX FIFO.
But if you have a look on STM32F7 SPI [1], you'll see that STM32F7 SPI 
is based on STM32F4 SPI with new features (data frames & FIFOs) also 
available on STM32H7 SPI.

That's why STM32H7 SPI driver was called spi-stm32. The goal was to use 
compatible & match data to differentiate each STM32Fx specificities.

You can have a look on how it is managed in drivers/rtc/rtc-stm32.c (the 
same driver covers 2 HW version of STM32 RTC), or in 
drivers/iio/dac/stm32-dac-core.c and stm32-dac.c (the same driver also 
covers 2 HW version of STM32 DAC).

As your spi-stm32f4.c file is highly based on the existing spi-stm32.c 
file, I think that common code could be factored and specificities could 
be handled with compatible and match data.

Regards,
Amelie


[1] 
https://www.st.com/content/ccc/resource/technical/document/reference_manual/c5/cf/ef/52/c0/f1/4b/fa/DM00124865.pdf/files/DM00124865.pdf/jcr:content/translations/en.DM00124865.pdf

> For current version master mode with full-duplex and 8/16 bit data frame
> format are supported. There is no TX and RX FIFOs like in STM32H7.
> DMA capabilility is supported for messages longer than arbitrary number
> of bytes (that is set already to 16 bytes) when TX and RX channels are
> set at the same time.
> 
> Cezary Gapinski (5):
>    spi: stm32: rename STM32 SPI registers and functions to STM32H7
>    spi: stm32: rename spi-stm32 to spi-stm32h7
>    spi: stm32: add driver for STM32F4 controller
>    ARM: dts: stm32: add SPI support on STM32F429 SoC
>    spi: stm32: add description about STM32F4 bindings
> 
>   .../devicetree/bindings/spi/spi-stm32.txt          |    9 +-
>   arch/arm/boot/dts/stm32f429.dtsi                   |   60 +
>   drivers/spi/Kconfig                                |   18 +-
>   drivers/spi/Makefile                               |    3 +-
>   drivers/spi/spi-stm32.c                            | 1322 -------------------
>   drivers/spi/spi-stm32f4.c                          | 1002 +++++++++++++++
>   drivers/spi/spi-stm32h7.c                          | 1340 ++++++++++++++++++++
>   7 files changed, 2424 insertions(+), 1330 deletions(-)
>   delete mode 100644 drivers/spi/spi-stm32.c
>   create mode 100644 drivers/spi/spi-stm32f4.c
>   create mode 100644 drivers/spi/spi-stm32h7.c
>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [RFC/PATCH 0/2] spi: spi-dw: Select 16b or 32b register access
Date: Wed, 04 Mar 2015 23:02:06 +0200
Message-ID: <1425502926.14897.187.camel@linux.intel.com>
References: <1425501075-17081-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, grant.likely@linaro.org, jkosina@suse.cz,
	pawel.moll@arm.com, robh+dt@kernel.org, mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk, dinguyen@opensource.altera.com,
	linux-doc@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, tthayer.linux@gmail.com,
	axel.lin@ingics.com, baruch@tkos.co.il, jg1.han@samsung.com,
	galak@codeaurora.org
To: tthayer@opensource.altera.com
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1425501075-17081-1-git-send-email-tthayer@opensource.altera.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 2015-03-04 at 14:31 -0600, tthayer@opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> The Altera Arria10 SoC requires 32 bit accesses to peripherals.

Accordingly to what I can read here [1] the IP block is DW_apb_ssi. So,
I don't see any needs for those patches.

The thing which might be needed is to implement DMA support for that
chip.

[1] http://www.altera.com/literature/hb/arria-10/hps.html


>  The
> DesignWare SPI peripheral registers are on 32bit boundaries so this
> patch is minimal. Function pointers are used to select 32bit access
> or 16bit accesses.
> 
> Thor Thayer (2):
>   dt-binding: spi: spi-dw: Select 16b or 32b access for Designware SPI
>   spi: dw-spi: Pointers select 16b vs. 32b DesignWare access
> 
>  Documentation/devicetree/bindings/spi/spi-dw.txt |    1 +
>  drivers/spi/spi-dw-mmio.c                        |    7 +++-
>  drivers/spi/spi-dw.c                             |   38 +++++++++++++---------
>  drivers/spi/spi-dw.h                             |   10 +++---
>  4 files changed, 35 insertions(+), 21 deletions(-)
> 


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy


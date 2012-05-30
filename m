From: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH 0/9 v3] MIPS: BCM63XX: add support for SPI
Date: Wed, 30 May 2012 12:04:14 +0200
Message-ID: <3262201.kIFrIcTNNo@flexo>
References: <1328019048-5892-1-git-send-email-florian@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1328019048-5892-1-git-send-email-florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Ralf,

On Tuesday 31 January 2012 15:10:39 Florian Fainelli wrote:
> This patch set depend on the serie "MIPS: BCM63XX: misc cleanup" and
> adds support for the SPI controller found in BCM63xx SoCs.
> 
> Grant, it probably makes sense to get this merged via the MIPS tree
> since it mostly depends on it.

Grant merged the SPI driver a while ago during 3.4, and now we can't build 
this driver because the platform-specific knobs have not been merged.

The only complains where from Maxime about the SPI driver itself, not the 
other changes, can you merge this series without the latest patch?

Thanks!

> 
> Florian Fainelli (9):
>   MIPS: BCM63XX: add IRQ_SPI and CPU specific SPI IRQ values
>   MIPS: BCM63XX: define BCM6358 SPI base address
>   MIPS: BCM63XX: add BCM6368 SPI clock mask
>   MIPS: BCM63XX: define SPI register sizes.
>   MIPS: BCM63XX: remove SPI2 register
>   MIPS: BCM63XX: define internal registers offsets of the SPI
>     controller
>   MIPS: BCM63XX: add stub to register the SPI platform driver
>   MIPS: BCM63XX: make board setup code register the spi platform device
>   spi: add Broadcom BCM63xx SPI controller driver
> 
>  arch/mips/bcm63xx/Makefile                         |    3 +-
>  arch/mips/bcm63xx/boards/board_bcm963xx.c          |    3 +
>  arch/mips/bcm63xx/clk.c                            |    6 +-
>  arch/mips/bcm63xx/dev-spi.c                        |  119 +++++
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   |   23 +-
>  .../include/asm/mach-bcm63xx/bcm63xx_dev_spi.h     |   89 ++++
>  arch/mips/include/asm/mach-bcm63xx/bcm63xx_regs.h  |  119 +++++
>  drivers/spi/Kconfig                                |    6 +
>  drivers/spi/Makefile                               |    1 +
>  drivers/spi/spi-bcm63xx.c                          |  486 
++++++++++++++++++++
>  10 files changed, 842 insertions(+), 13 deletions(-)
>  create mode 100644 arch/mips/bcm63xx/dev-spi.c
>  create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_spi.h
>  create mode 100644 drivers/spi/spi-bcm63xx.c
> 
> -- 
> 1.7.5.4
> 

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/

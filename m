From: Jason Wang <jason77.wang@gmail.com>
Subject: Re: [PATCH 3/6] mx5: add support to dynamically register spi_imx
	devices (imx51 3ds)
Date: Fri, 03 Sep 2010 14:22:56 +0800
Message-ID: <4C809440.1070602@gmail.com>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-3-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-4-git-send-email-jason77.wang@gmail.com>
	<20100902150258.GN14214@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Cc: Jason Wang <jason77.wang@gmail.com>, s.hauer@pengutronix.de,
	grant.likely@secretlab.ca, amit.kucheria@canonical.com,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org
To: =?ISO-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20100902150258.GN14214@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Uwe Kleine-K=F6nig wrote:
> Hi Jason,
>
> On Thu, Sep 02, 2010 at 03:52:01PM +0800, Jason Wang wrote:
>   =

>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>> ---
>>  arch/arm/mach-mx5/Kconfig         |    1 +
>>  arch/arm/mach-mx5/devices-imx51.h |   20 ++++++++++++++++++++
>>  2 files changed, 21 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/mach-mx5/devices-imx51.h
>>
>> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
>> index 0848db5..898fb47 100644
>> --- a/arch/arm/mach-mx5/Kconfig
>> +++ b/arch/arm/mach-mx5/Kconfig
>> @@ -18,6 +18,7 @@ config MACH_MX51_BABBAGE
>>  config MACH_MX51_3DS
>>  	bool "Support MX51PDK (3DS)"
>>  	select MXC_DEBUG_BOARD
>> +	select IMX_HAVE_PLATFORM_SPI_IMX
>>  	help
>>  	  Include support for MX51PDK (3DS) platform. This includes specific
>>  	  configurations for the board and its peripherals.
>> diff --git a/arch/arm/mach-mx5/devices-imx51.h b/arch/arm/mach-mx5/devic=
es-imx51.h
>> new file mode 100644
>> index 0000000..d04c7eb
>> --- /dev/null
>> +++ b/arch/arm/mach-mx5/devices-imx51.h
>> @@ -0,0 +1,20 @@
>> +/*
>> + * Copyright (C) 2010 Jason Wang <jason77.wang@gmail.com>
>> + *
>> + * based on mach-mx3/devices-imx35.h which is
>> + * Copyright (C) 2010 Pengutronix
>> + * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
>> + *
>> + * This program is free software; you can redistribute it and/or modify=
 it under
>> + * the terms of the GNU General Public License version 2 as published b=
y the
>> + * Free Software Foundation.
>> + */
>> +#include <mach/mx51.h>
>> +#include <mach/devices-common.h>
>> +
>> +#define imx51_add_spi_imx0(pdata)	\
>> +	imx_add_spi_imx(0, MX51_CSPI1_BASE_ADDR, SZ_4K, MX51_MXC_INT_CSPI1, pd=
ata)
>> +#define imx51_add_spi_imx1(pdata)	\
>> +	imx_add_spi_imx(1, MX51_CSPI2_BASE_ADDR, SZ_4K, MX51_MXC_INT_CSPI2, pd=
ata)
>> +#define imx51_add_spi_imx2(pdata)	\
>> +	imx_add_spi_imx(1, MX51_CSPI3_BASE_ADDR, SZ_4K, MX51_MXC_INT_CSPI, pda=
ta)
>>     =

> I like my new approach better.  See my patch 3.
>
>   =

OK, i will drop this patch.

From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v2 00/12] tnetv107x ssp driver stack
Date: Thu, 21 Oct 2010 12:09:43 -0700
Message-ID: <87fwvzuzuw.fsf@deeprootsystems.com>
References: <1287429922-18870-1-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
        grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
To: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1287429922-18870-1-git-send-email-cyril-l0cyMroinI0@public.gmane.org> (Cyril
	Chemparathy's message of "Mon, 18 Oct 2010 15:25:10 -0400")
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org> writes:

> TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of serial port
> device.  It has a built-in programmable execution engine that can be programmed
> to operate as almost any serial bus (I2C, SPI, EasyScale, and others).

Hi Cyril,

Can you do one more posting, including the acks from the subsystem
maintainers so far, and posting also to LKML and
linux-arm-kernel-IAPFreCvJWM7uuMidbF8XZu6nac5fYnt@public.gmane.org

Also the backlight driver needs a review/ack from Richard Purdie (search
for drivers/video/backlight in MAINTAINERS).

With acks from all the subsystem maintainers, I think it makes sense to
merge all of these together via the davinci tree.   At the moment, I'm
not sure who the final authority on the drivers/misc stuff is, but I
will ask in response to your updated posting.

Thanks,

Kevin


> This patch series implements a driver stack that looks like the following:
>
>                              +--------+
>                              | eeprom | . . .
>                              +--------+
>    +-----------+             +--------------+ +---------+
>    | regulator | . . .       |   i2c-gpio   | | 1-wire  | . . .
>    +-----------+             +--------------+ +---------+
>    +----------------------+  +--------------------------------+
>    |       ssp-spi        |  |           ssp-gpio             |
>    +----------------------+  +--------------------------------+
>    +----------------------------------------------------------+
>    |                            ssp                           |
>    +----------------------------------------------------------+
>
>
> Changes between v1 and v2 of this series:
>
>   - Replaced open()/close() semantics with dynamic platform_device
>     registration on SSP probe.
>
>   - Removed user-land interface to regulator registers
>
>   - More sensible regulator constraints
>
>   - Other minor cleanups
>
>
> Cyril Chemparathy (12):
>   misc: add driver for sequencer serial port
>   davinci: add tnetv107x ssp platform device
>   davinci: add ssp config for tnetv107x evm board
>   spi: add ti-ssp spi master driver
>   davinci: add spi devices on tnetv107x evm
>   regulator: add driver for tps6524x regulator
>   davinci: add tnetv107x evm regulators
>   gpio: add ti-ssp virtual gpio driver
>   davinci: add tnetv107x evm ti-ssp gpio device
>   backlight: add support for tps6116x controller
>   davinci: add tnetv107x evm backlight device
>   davinci: add tnetv107x evm i2c eeprom device
>
>  arch/arm/mach-davinci/board-tnetv107x-evm.c    |  199 +++++++
>  arch/arm/mach-davinci/devices-tnetv107x.c      |   25 +
>  arch/arm/mach-davinci/include/mach/ti_ssp.h    |   99 ++++
>  arch/arm/mach-davinci/include/mach/tnetv107x.h |    2 +
>  arch/arm/mach-davinci/tnetv107x.c              |    2 +-
>  drivers/gpio/Kconfig                           |   10 +
>  drivers/gpio/Makefile                          |    1 +
>  drivers/gpio/ti-ssp-gpio.c                     |  200 +++++++
>  drivers/misc/Kconfig                           |   11 +
>  drivers/misc/Makefile                          |    1 +
>  drivers/misc/ti_ssp.c                          |  436 +++++++++++++++
>  drivers/regulator/Kconfig                      |   10 +
>  drivers/regulator/Makefile                     |    1 +
>  drivers/regulator/tps6524x-regulator.c         |  692 ++++++++++++++++++++++++
>  drivers/spi/Kconfig                            |    6 +
>  drivers/spi/Makefile                           |    1 +
>  drivers/spi/spi_ti_ssp.c                       |  397 ++++++++++++++
>  drivers/video/backlight/Kconfig                |    7 +
>  drivers/video/backlight/Makefile               |    2 +-
>  drivers/video/backlight/tps6116x.c             |  340 ++++++++++++
>  20 files changed, 2440 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/mach-davinci/include/mach/ti_ssp.h
>  create mode 100644 drivers/gpio/ti-ssp-gpio.c
>  create mode 100644 drivers/misc/ti_ssp.c
>  create mode 100644 drivers/regulator/tps6524x-regulator.c
>  create mode 100644 drivers/spi/spi_ti_ssp.c
>  create mode 100644 drivers/video/backlight/tps6116x.c
>
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source

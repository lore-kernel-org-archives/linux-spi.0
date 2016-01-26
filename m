From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 0/4] spi: pxa2xx: Chip select fixes for Intel Baytrail and
 Braswell
Date: Tue, 26 Jan 2016 14:52:39 +0200
Message-ID: <56A76C17.5070309@linux.intel.com>
References: <1453807111-103111-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Bastien Nocera <bugzilla@hadess.net>,
	linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453807111-103111-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 01/26/2016 01:18 PM, Mika Westerberg wrote:
> It turns out that in Windows SPI drivers are responsible for handling ACPI
> DeviceSelection field themselves.  Furthermore there has been separate
> drivers for big core and atom SPI host controllers. For atom (including
> Baytrail and Braswell) the driver starts DeviceSelection from 1 instead of 0
> as expected by the Linux SPI core.
>
> As an example Microsoft Surface 3 has touch screen connected to SPI bus
> described in ACPI DSDT like this:
>
>      Scope (_SB.PCI0.SPI1)
>      {
>          Device (NTRG)
>          {
>              Name (_HID, "MSHW0037")  // _HID: Hardware ID
>              ...
>              Name (CRS1, ResourceTemplate ()
>              {
>                  SpiSerialBus (0x0001, // SPI DeviceSelection
>                      PolarityLow, FourWireMode, 0x10,
>                      ControllerInitiated, 0x007A1200, ClockPolarityLow,
>                      ClockPhaseFirst, "\\_SB.PCI0.SPI1",
>                      0x00, ResourceConsumer, ,
>                      )
>
> This fails to enumerate because ACPI DeviceSelection of 1 is greater than
> number of chip selects the driver supports [1].
>
> This series adds a new hook to struct spi_master ->fw_translate_cs() that
> allows a driver to translate the chip select number from firmware to the
> numbering scheme expected by the Linux SPI core and implement that for both
> Baytrail and Braswell.
>
> In addition to that we add support for the second chip select found on
> Braswell.
>
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=104291
>
> Mika Westerberg (4):
>    spi: Let drivers translate ACPI DeviceSelection to suitable Linux chip select
>    spi: pxa2xx: Translate ACPI DeviceSelection to Linux chip select on Baytrail
>    spi: pxa2xx: Move chip select control bits into lpss_config structure
>    spi: pxa2xx: Add support for both chip selects on Intel Braswell
>
>   drivers/spi/spi-pxa2xx.c   | 106 ++++++++++++++++++++++++++++++++++-----------
>   drivers/spi/spi.c          |  19 +++++++-
>   include/linux/pxa2xx_ssp.h |   1 +
>   include/linux/spi/spi.h    |   5 +++
>   4 files changed, 105 insertions(+), 26 deletions(-)
>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>

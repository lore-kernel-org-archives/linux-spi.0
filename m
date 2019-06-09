From: "Life is hard, and then you die" <ronald@innovation.ch>
Subject: Re: [PATCH v2] spi/acpi: enumerate all SPI slaves in the namespace
Date: Sun, 9 Jun 2019 16:44:27 -0700
Message-ID: <20190609234427.GA16597@innovation.ch>
References: <20190530111634.32209-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
 andy.shevchenko@gmail.com, broonie@kernel.org,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, masahisa.kojima@linaro.org,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190530111634.32209-1-ard.biesheuvel@linaro.org>
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


On Thu, May 30, 2019 at 01:16:34PM +0200, Ard Biesheuvel wrote:
> Currently, the ACPI enumeration that takes place when registering a
> SPI master only considers immediate child devices in the ACPI namespace,
> rather than checking the ResourceSource field in the SpiSerialBus()
> resource descriptor.
> 
> This is incorrect: SPI slaves could reside anywhere in the ACPI
> namespace, and so we should enumerate the entire namespace and look for
> any device that refers to the newly registered SPI master in its
> resource descriptor.
> 
> So refactor the existing code and use a lookup structure so that
> allocating the SPI device structure is deferred until we have identified
> the device as an actual child of the controller. This approach is
> loosely based on the way the I2C subsystem handles ACPI enumeration.
> 
> Note that Apple x86 hardware does not rely on SpiSerialBus() resources
> in _CRS but uses nested devices below the controller's device node in
> the ACPI namespace, with a special set of device properties. This means
> we have to take care to only parse those properties for device nodes
> that are direct children of the controller node.
> 
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: linux-spi@vger.kernel.org
> Cc: broonie@kernel.org
> Cc: andy.shevchenko@gmail.com
> Cc: masahisa.kojima@linaro.org
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Cc: linux-acpi@vger.kernel.org
> Cc: Lukas Wunner <lukas@wunner.de>
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/spi/spi.c | 103 ++++++++++++++------
>  1 file changed, 72 insertions(+), 31 deletions(-)
[snip]

FYI, I tested this on a MacBook Pro where the (SPI) keyboard driver
depends on those special device properties, and verified this patch
doesn't break anything there.


  Cheers,

  Ronald

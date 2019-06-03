From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2] spi/acpi: enumerate all SPI slaves in the namespace
Date: Mon, 3 Jun 2019 14:08:32 +0300
Message-ID: <20190603110832.GA2781@lahna.fi.intel.com>
References: <20190530111634.32209-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-spi@vger.kernel.org, linux-acpi@vger.kernel.org,
 andy.shevchenko@gmail.com, broonie@kernel.org,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>, masahisa.kojima@linaro.org,
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
> @@ -1948,7 +1988,8 @@ static void acpi_register_spi_devices(struct spi_controller *ctlr)
>  	if (!handle)
>  		return;
>  
> -	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> +	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,

Would it be simpler to differentiate here between Apple and non-Apple
systems? Then we don't need all that special code and the above becomes:

	depth = x86_apple_system ? 1 : SPI_ACPI_ENUMERATE_MAX_DEPTH;
	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, depth,
	..

Probably requires a comment explaining why we do it like that, though.

From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/4] spi/davinci: add DT binding documentation
Date: Mon, 04 Mar 2013 17:29:16 +0100
Message-ID: <6918845.dALXSKksQd@wuerfel>
References: <1362401955-9616-1-git-send-email-prakash.pm@ti.com>
 <1362401955-9616-2-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source@linux.davincidsp.com, linux@arm.linux.org.uk,
 linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, nsekhar@ti.com,
 rob.herring@calxeda.com, grant.likely@secretlab.ca, "Manjunathappa,
 Prakash" <prakash.pm@ti.com>, Murali Karicheri <m-karicheri2@ti.com>,
 rob@landley.net, spi-devel-general@lists.sourceforge.net, hs@denx.de
To: linux-arm-kernel@lists.infradead.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1362401955-9616-2-git-send-email-prakash.pm@ti.com>
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

On Monday 04 March 2013 18:29:12 Manjunathappa, Prakash wrote:
> diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
> new file mode 100644
> index 0000000..a62d7a8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
> @@ -0,0 +1,51 @@
> +Davinci SPI controller device bindings
> +
> +Required properties:
> +- #address-cells: number of cells required to define a chip select
> +	address on the SPI bus. Should be set to 1.
> +- #size-cells: should be zero.
> +- compatible:
> +	- "ti,dm644x-spi" for SPI used similar to that on DM644x SoC family
> +	- "ti,da8xx-spi" for SPI used similar to that on DA8xx SoC family

In general, you should avoid wildcards in "compatible" properties.
Better use the number of the first chip that introduced the specific
version of the device.

> +- reg: Offset and length of SPI controller register space
> +- num-cs: Number of chip selects
> +- ti,davinci-spi-intr-line: interrupt line used to connect the SPI
> +	IP to the interrupt controller withn the SoC. Possible values
> +	are 0 and 1. Manual says one of the two possible interrupt
> +	lines can be tied to the interrupt controller. Set this
> +	based on a specifc SoC configuration.
> +- interrupts: interrupt number offset at the irq parent

I would not call this an "offset". It is an interrupt descriptor
which may be something other than a simple number.

Unfortunately, there is no way to provide an "invalid" interrupt,
otherwise you could just list both interrupts, out of which at
least one should be valid, and drop the ti,davinci-spi-intr-line
property.

One thing you could do instead though is to use the "interrupt-names"
property to define "irq0" and "irq1" interrupts, and in the
implementation use the first one you find.

	Arnd

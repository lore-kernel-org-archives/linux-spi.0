From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM PL022 SSP/SPI driver v1
Date: Sun, 31 May 2009 11:22:44 +0100
Message-ID: <20090531102244.GC18650@n2100.arm.linux.org.uk>
References: <63386a3d0905271519x1afc6c4bo8d40315e2e387b63@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.arm.linux.org.uk,
	David Brownell <dbrownell@users.sourceforge.net>,
	Linus Walleij <linus.walleij@stericsson.com>,
	Alessandro Rubini <rubini-list@gnudd.com>,
	STEricsson_nomadik_linux@list.st.com, andrea.gallo@stericsson.com,
	Catalin Marinas <catalin.marinas@arm.com>, sachin.verma@st.com
To: Linus Walleij <linus.ml.walleij@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <63386a3d0905271519x1afc6c4bo8d40315e2e387b63@mail.gmail.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
List-Id: linux-spi.vger.kernel.org

On Thu, May 28, 2009 at 12:19:15AM +0200, Linus Walleij wrote:
> This adds a driver for the ARM PL022 PrimeCell SSP/SPI
> driver found in the U300 platforms as well as in some
> ARM reference hardware, and in a modified version on the
> Nomadik board.
> 
> Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
> ---
>  drivers/spi/Kconfig        |    9 +
>  drivers/spi/Makefile       |    1 +
>  drivers/spi/amba-pl022.c   | 1887 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/amba/pl022.h |  264 ++++++
>  4 files changed, 2161 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/spi/amba-pl022.c
>  create mode 100644 include/linux/amba/pl022.h
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 83a185d..39cb8cf 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -171,6 +171,15 @@ config SPI_ORION
>  	help
>  	  This enables using the SPI master controller on the Orion chips.
> 
> +config SPI_PL022
> +	tristate "ARM AMBA PL022 SSP controller"
> +	depends on ARM_AMBA && EXPERIMENTAL

Normally, if something depends on EXPERIMENTAL, we put (EXPERIMENTAL) in
the option description.

> +#ifdef CONFIG_PM
> +static int suspend_devices(struct device *dev, void *pm_message)
> +{
> +	pm_message_t *state = pm_message;
> +
> +	if (dev->power.power_state.event != state->event) {
> +		dev_warn(dev, "pm state does not match request\n");
> +		return -EPERM;
> +	}
> +	return 0;
> +}
> +
> +static int pl022_suspend(struct amba_device *adev, pm_message_t state)
> +{
> +	struct pl022 *pl022 = amba_get_drvdata(adev);
> +	int status = 0;
> +
> +	/* Check all children (connected SPI chips) for current power state */
> +	status = device_for_each_child(&adev->dev, &state, suspend_devices);
> +	if (status) {
> +		dev_warn(&adev->dev,
> +			 "children (SPI chips) not in the same power "
> +			 "state, suspend aborted\n");
> +		return status;

Hmm, not sure about this.  The device model guarantees that the children
will have their suspend callbacks called before the parents.  If a child
returns an error from their suspend callback, suspend will be aborted
and the parent's suspend callback won't happen.

Lastly, dev->power.power_state is scheduled for removal...

> +	}
> +
> +	status = stop_queue(pl022);
> +	if (status) {
> +		dev_warn(&adev->dev, "suspend cannot stop queue\n");
> +		return status;
> +	}
> +
> +	clk_enable(pl022->clk);
> +	load_ssp_default_config(pl022);
> +	clk_disable(pl022->clk);
> +	dev_dbg(&adev->dev, "suspended\n");
> +	return 0;
> +}
> +
> +static int pl022_resume(struct amba_device *adev)
> +{
> +	struct pl022 *pl022 = amba_get_drvdata(adev);
> +	int status = 0;
> +
> +	/* Start the queue running */
> +	status = start_queue(pl022);
> +	if (status)
> +		dev_err(&adev->dev, "problem starting queue (%d)\n", status);
> +	else
> +		dev_dbg(&adev->dev, "resumed\n");
> +
> +	return status;
> +}
> +
> +#else
> +#define pl022_suspend NULL
> +#define pl022_resume NULL
> +#endif				/* CONFIG_PM */
> +
> +static struct vendor_data vendor_arm = {
> +	.fifodepth = 8,
> +	.max_bpw = 16,
> +	.unidir = false,
> +};
> +
> +
> +static struct vendor_data vendor_st = {
> +	.fifodepth = 32,
> +	.max_bpw = 32,
> +	.unidir = false,
> +};
> +
> +static struct amba_id pl022_ids[] __initdata = {

This shouldn't be __initdata - it can be referenced at runtime.

> +#ifndef _SSP_PL022_H
> +#define _SSP_PL022_H
> +
> +#include <linux/device.h>

Instead, use a forward declaration:

struct device;

to shut up the warnings about that missing.  Including header files to
shut those warnings up eventually gets us into treacherous water.

I've not reviewed the SSP code itself - it's something I'm far from
knowledgeable of.

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php

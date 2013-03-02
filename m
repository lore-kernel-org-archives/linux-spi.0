From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: Driver for GPIO controlled SPI multiplexer
Date: Sat, 02 Mar 2013 17:32:44 +0000
Message-ID: <20130302173244.41A2B3E1089@localhost>
References: <1361973519-30633-1-git-send-email-peter.korsgaard@barco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
To: Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1361973519-30633-1-git-send-email-peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 27 Feb 2013 14:58:39 +0100, Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org> wrote:
> From: Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
> 
> This patch contains a driver for a gpio controlled multiplexer on an
> SPI bus. This can be useful if a board requires more SPI devices,
> and thus more chip selects, than the SPI controller on the processor
> has available.
> 
> The mux device is added in the device tree as a child node of the
> SPI master. Then, devices can be added as children of the mux node.
> The mux will appear as if it was a SPI master device, and child
> nodes will appear as chip selects on the mux bus. A bindings file is
> provided for the device tree bindings.
> 
> Since at least some SPI master drivers queue messages from the
> attached devices, the mux can only send 1 message at a time from its
> own queue to the master, because otherwise there would not be a
> guarantee that the mux settings will be correct when the real master
> does the transfer.

Hi Peter,

Nice, pass on thanks to Dries for looking at this please. I've got other
hardware that wants to do what you've got here. It's a nice tightly
written driver too. Well done! Comments below...

> Signed-off-by: Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>

Peter, you forgot to add your s-o-b line here. If you're passing on a
patch, you are responsible to it meets the sign-off critiria in
Documentation/SubmittingPatches which is what your s-o-b line is meant
to assert.

> ---
>  .../devicetree/bindings/spi/spi-mux-gpio.txt       |  113 +++++++
>  drivers/spi/Kconfig                                |    9 +
>  drivers/spi/Makefile                               |    1 +
>  drivers/spi/spi-mux-gpio.c                         |  319 ++++++++++++++++++++
>  4 files changed, 442 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-mux-gpio.txt
>  create mode 100644 drivers/spi/spi-mux-gpio.c
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt b/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt
> new file mode 100644
> index 0000000..534a667
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/spi-mux-gpio.txt
> @@ -0,0 +1,113 @@
> +GPIO-based SPI Chip Select Mux
> +
> +This binding describes a SPI bus multiplexer that uses GPIOs to route
> +the SPI chip select signals. This can be used when you need more
> +devices than the SPI controller has chip selects available.
> +
> +      MOSI /---------------------------+--------+--------+--------\
> +      MISO |/-------------------------+|-------+|-------+|-------\|
> +       SCL ||/-----------------------+||------+||------+||------\||
> +           |||                       |||      |||      |||      |||
> +    +------------+                   |||      |||      |||      |||
> +    | SoC  |||   |                 +-+++-+  +-+++-+  +-+++-+  +-+++-+
> +    |      |||   |                 | dev |  | dev |  | dev |  | dev |
> +    |   +--+++-+ |  +------+\      +--+--+  +--+--+  +--+--+  +--+--+
> +    |   | SPI  +-|--| Mux  |\\   CS-0 |        |        |        |
> +    |   +------+ |  +--++--+\\\-------/   CS-1 |        |        |
> +    |            |     ||   \\\----------------/   CS-2 |        |
> +    |   +------+ |     ||    \\-------------------------/   CS-3 |
> +    |   | GPIO |-|-----/|     \----------------------------------/
> +    |   |      |-|------/
> +    |   +------+ |
> +    +------------+

Other variants would be an second spi device with a register for the
active CS to use instead of GPIOs. Something to keep in mind as to how
it could be extended for other methods of setting the CS. I've got
hardware exactly like that.

> +
> +Required properties:
> +- compatible: "spi-mux-gpio"

As already commented on, please use a more specific compatible string
here.

> +- #address-cells: <1> (as for any SPI master device)
> +- #size-cells: <0> (as for any SPI master device)
> +- reg: chip select of the mux on the parent SPI master
> +- spi-max-frequency: the maximum frequency allowed for any devices on
> +  this mux
> +- mux-gpios: list of gpios used to control the muxer

Simply 'gpios' is sufficient here I think

> +* SPI child nodes, as if the mux is a real spi master
> +
> +A new SPI bus will be created. Then for each child node, a SPI device
> +is created, with a virtual chip select on this bus according to the
> +reg property.
> +
> +Whenever an access is made to a child device, the value set in the
> +revelant node's reg property is interpreted as a bitmask defining the
> +state of the mux-gpios gpio pins, with the least significant bit
> +defining the state of first gpio, the next bit the state of the second
> +gpio and so forth.
> +
> +The property spi-max-frequency is conceptually not needed, as each
> +child node holds the maximum frequency specific to that
> +device. However, the SPI core code wants every device in the tree to
> +specify a maximum frequency. So because the mux is a device to a
> +parent SPI master, you need to set a maximum frequency.  It's best to
> +set this high, as the driver will take the minimum of this value and
> +the child's maximum frequency value when doing a transfer to that
> +child device.

It would be worth having an exception that takes the speed from the spi
child device. I'm not requiring you to do this, but it would be helpful
if you could check if it can be done.

> diff --git a/drivers/spi/spi-mux-gpio.c b/drivers/spi/spi-mux-gpio.c
> new file mode 100644
> index 0000000..983565b
> --- /dev/null
> +++ b/drivers/spi/spi-mux-gpio.c
> @@ -0,0 +1,319 @@

> +static int spi_mux_gpio_select(struct spi_device *spi)
> +{
> +	struct spi_mux_gpio *mux = spi_master_get_devdata(spi->master);
> +	int i;
> +
> +	for (i = 0; i < mux->n_gpios; i++) {
> +		gpio_set_value(mux->gpios[i],
> +			       mux->values[spi->chip_select] & (1 << i));
> +	}
> +
> +	return 0;
> +}

The spi_mux_gpio_select() function could be a callback allowing other
mechanisms for setting the muxed CS#. In doing so, you can also rename
the driver simply "spi_mux". I think that makes more sense for what you're
doing.

> +static void spi_mux_gpio_complete_cb(void *context)
> +{
> +	struct spi_mux_gpio *mux = (struct spi_mux_gpio *)context;
> +
> +	/* allow transfer function to continue */
> +	mux->xfer_complete = true;
> +	wake_up_interruptible(&mux->xfer_complete_wq);
> +}
> +
> +static int spi_mux_gpio_transfer_one_message(struct spi_master *master,
> +						struct spi_message *m)
> +{
> +	struct spi_mux_gpio *mux = spi_master_get_devdata(master);
> +	struct spi_device *spi = m->spi;
> +
> +	void (*child_mesg_complete)(void *context);
> +	void *child_mesg_context;
> +	struct spi_device *child_mesg_dev;
> +
> +	int ret = 0;
> +
> +	ret = spi_mux_gpio_setup_mux(spi);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Replace the complete callback, context and spi_device with our own
> +	 * pointers. Save originals
> +	 */
> +	child_mesg_complete = m->complete;
> +	child_mesg_context = m->context;
> +	child_mesg_dev = m->spi;
> +
> +	m->complete = spi_mux_gpio_complete_cb;
> +	m->context = mux;
> +	m->spi = mux->spi;
> +
> +	/* do the transfer + wait until it is done */
> +	mux->xfer_complete = false;
> +	spi_async(mux->spi, m);
> +
> +	ret = wait_event_interruptible(mux->xfer_complete_wq,
> +				       mux->xfer_complete);
> +
> +	/*
> +	 * restore callback, context, spi_device and do finalize, even if
> +	 * ret != 0. In that case, m->actual_length will hold the bytes
> +	 * actually transferred.
> +	 */
> +	m->complete = child_mesg_complete;
> +	m->context = child_mesg_context;
> +	m->spi = child_mesg_dev;
> +	spi_finalize_current_message(master);
> +
> +	return ret;
> +}

I think it has gotten two complex here.  spi_mux_gpio_transfer_one_message()
is doing a bunch of work to set up a wait event to finish up with the
transfer. However, it really doesn't need to do this. It can return
immediately after accepting and passing on the transfer.
spi_finalize_current_message() can be called directly in
spi_mux_gpio_complete_cb(). The spi core will make sure transfer doesn't
get called again if there is already a transfer in-flight.

Mark commented on this too, but I disagree with him on one point; it
will actually be simpler if you finish up the transfer in the callback,
and that it really should be implemented that way from day one.

xfer_complete and xfer_complete_wq can be dropped, and
child_mesg_complete, child_mesg_context and child_mesg_dev will move
into struct spi_mux_gpio.

> +
> +static int spi_mux_gpio_probe_dt(struct spi_mux_gpio *mux)

There really isn't any good reason other than function length to have
this separate from the spi_mux_gpio_probe(). Probe functions are a bit
linear sequence of setups anyway. Just roll it into the main function.

> +{
> +	struct device_node *np = mux->spi->dev.of_node;
> +	struct device_node *child;
> +
> +	int n_values, i;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	n_values = of_get_child_count(np);
> +
> +	mux->values = devm_kzalloc(&mux->spi->dev,
> +			      sizeof(*mux->values) * n_values,
> +			      GFP_KERNEL);
> +	if (!mux->values) {
> +		dev_err(&mux->spi->dev, "Cannot allocate values array");
> +		return -ENOMEM;
> +	}

Whoops! this is a bug. The CS#s may be sparse, ie 1, 2, 5, and 7 may be
valid CS# numbers, but that would be only a count of 4.

Instead of a values array, can the CS# itself in the child spi_client be
used as the bitmapped GPIO value here? You're already storing that value
directly into the values array anyway.  :-)

> +
> +	i = 0;
> +	for_each_child_of_node(np, child) {
> +		of_property_read_u32(child, "reg", mux->values + i);
> +		i++;
> +	}
> +
> +	mux->n_gpios = of_gpio_named_count(np, "mux-gpios");
> +	if (mux->n_gpios < 0) {
> +		dev_err(&mux->spi->dev,
> +			"Missing mux-gpios property in the DT.\n");
> +		return -EINVAL;
> +	}
> +
> +	mux->gpios = devm_kzalloc(&mux->spi->dev,
> +			     sizeof(*mux->gpios) * mux->n_gpios,
> +			     GFP_KERNEL);
> +	if (!mux->gpios) {
> +		dev_err(&mux->spi->dev, "Cannot allocate gpios array");
> +		return -ENOMEM;
> +	}
> +
> +	for (i = 0; i < mux->n_gpios; i++)
> +		mux->gpios[i] = of_get_named_gpio(np, "mux-gpios", i);
> +
> +	/*
> +	 * when we register our mux as an spi master, it will parse the
> +	 * the children of this node and add them as devices.
> +	 * So we don't need to parse the child nodes here.
> +	 */
> +
> +	return 0;
> +}
> +
> +static int spi_mux_gpio_probe(struct spi_device *spi)
> +{
> +	struct spi_master *master;
> +	struct spi_mux_gpio *mux;
> +	int ret = 0, i;
> +	unsigned int initial_state;
> +
> +	master = spi_alloc_master(&spi->dev, sizeof(*mux));
> +	if (master == NULL) {
> +		dev_dbg(&spi->dev, "master allocation failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	dev_set_drvdata(&spi->dev, master);
> +	mux = spi_master_get_devdata(master);
> +	mux->spi = spi;
> +
> +	ret = spi_mux_gpio_probe_dt(mux);
> +	if (ret < 0)
> +		goto err_probe_dt;
> +
> +	initial_state = mux->values[0];
> +	mux->current_cs = 0;
> +
> +	for (i = 0; i < mux->n_gpios; i++) {
> +		devm_gpio_request(&spi->dev, mux->gpios[i], "spi-mux-gpio");
> +		gpio_direction_output(mux->gpios[i], initial_state & (1 << i));
> +	}
> +
> +	mux->xfer_complete = true;
> +	init_waitqueue_head(&mux->xfer_complete_wq);
> +
> +	/* supported modes are the same as our parent's */
> +	master->mode_bits = mux->spi->master->mode_bits;
> +
> +	master->setup = spi_mux_gpio_setup;
> +	master->transfer_one_message = spi_mux_gpio_transfer_one_message;
> +
> +	/* the mux can have 2 ^ <nr_gpio_used_for_muxing> chip selects */
> +	master->num_chipselect = 1 << mux->n_gpios;
> +	master->dev.of_node = spi->dev.of_node;
> +
> +	/* register master -> this also adds the devices behind the mux */
> +	ret = spi_register_master(master);
> +	if (ret < 0)
> +		goto err_register_master;
> +
> +	return ret;
> +
> +err_register_master:
> +err_probe_dt:
> +	spi_master_put(master);
> +
> +	return ret;
> +}
> +
> +static int spi_mux_gpio_remove(struct spi_device *spi)
> +{
> +	struct spi_master *master = spi_get_drvdata(spi);
> +
> +	spi_unregister_master(master);
> +	spi_master_put(master);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id spi_mux_gpio_of_match[] = {
> +	{ .compatible = "spi-mux-gpio", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, spi_mux_gpio_of_match);
> +
> +static struct spi_driver spi_mux_gpio_driver = {
> +	.probe	= spi_mux_gpio_probe,
> +	.remove	= spi_mux_gpio_remove,
> +	.driver	= {
> +		.owner	= THIS_MODULE,
> +		.name	= "spi-mux-gpio",
> +		.of_match_table = of_match_ptr(spi_mux_gpio_of_match),

This is a DT-only driver. The of_match_ptr() bit isn't needed.

g.

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb

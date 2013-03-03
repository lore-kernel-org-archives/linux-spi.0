From: Peter Korsgaard <jacmet-OfajU3CKLf1/SzgSGea1oA@public.gmane.org>
Subject: Re: [PATCH] spi: Driver for GPIO controlled SPI multiplexer
Date: Sun, 03 Mar 2013 09:08:44 +0100
Message-ID: <876218ykfn.fsf@dell.be.48ers.dk>
References: <1361973519-30633-1-git-send-email-peter.korsgaard@barco.com>
	<20130302173244.41A2B3E1089@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>,
	Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>,
	broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130302173244.41A2B3E1089@localhost> (Grant Likely's message of
	"Sat, 02 Mar 2013 17:32:44 +0000")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

>>>>> "Grant" == Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> writes:

Hi,

 >> Since at least some SPI master drivers queue messages from the
 >> attached devices, the mux can only send 1 message at a time from its
 >> own queue to the master, because otherwise there would not be a
 >> guarantee that the mux settings will be correct when the real master
 >> does the transfer.

 Grant> Hi Peter,

 Grant> Nice, pass on thanks to Dries for looking at this please. I've
 Grant> got other hardware that wants to do what you've got here. It's a
 Grant> nice tightly written driver too. Well done! Comments below...

Thanks for the kind words and review!


 >> Signed-off-by: Dries Van Puymbroeck <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>

 Grant> Peter, you forgot to add your s-o-b line here. If you're passing
 Grant> on a patch, you are responsible to it meets the sign-off
 Grant> critiria in Documentation/SubmittingPatches which is what your
 Grant> s-o-b line is meant to assert.

Ok, will add it on v2.


 >> +The property spi-max-frequency is conceptually not needed, as each
 >> +child node holds the maximum frequency specific to that
 >> +device. However, the SPI core code wants every device in the tree to
 >> +specify a maximum frequency. So because the mux is a device to a
 >> +parent SPI master, you need to set a maximum frequency.  It's best to
 >> +set this high, as the driver will take the minimum of this value and
 >> +the child's maximum frequency value when doing a transfer to that
 >> +child device.

 Grant> It would be worth having an exception that takes the speed from
 Grant> the spi child device. I'm not requiring you to do this, but it
 Grant> would be helpful if you could check if it can be done.

Yes, We'll change it to use iterate over the children and return the
hightest max-frequency of them for v2.



 >> diff --git a/drivers/spi/spi-mux-gpio.c b/drivers/spi/spi-mux-gpio.c
 >> new file mode 100644
 >> index 0000000..983565b
 >> --- /dev/null
 >> +++ b/drivers/spi/spi-mux-gpio.c
 >> @@ -0,0 +1,319 @@

 >> +static int spi_mux_gpio_select(struct spi_device *spi)
 >> +{
 >> +	struct spi_mux_gpio *mux = spi_master_get_devdata(spi->master);
 >> +	int i;
 >> +
 >> +	for (i = 0; i < mux->n_gpios; i++) {
 >> +		gpio_set_value(mux->gpios[i],
 >> +			       mux->values[spi->chip_select] & (1 << i));
 >> +	}
 >> +
 >> +	return 0;
 >> +}

 Grant> The spi_mux_gpio_select() function could be a callback allowing
 Grant> other mechanisms for setting the muxed CS#. In doing so, you can
 Grant> also rename the driver simply "spi_mux". I think that makes more
 Grant> sense for what you're doing.

Ok, so something similar to the i2c mux infrastructure?


 >> +static void spi_mux_gpio_complete_cb(void *context)
 >> +{
 >> +	struct spi_mux_gpio *mux = (struct spi_mux_gpio *)context;
 >> +
 >> +	/* allow transfer function to continue */
 >> +	mux->xfer_complete = true;
 >> +	wake_up_interruptible(&mux->xfer_complete_wq);
 >> +}
 >> +
 >> +static int spi_mux_gpio_transfer_one_message(struct spi_master *master,
 >> +						struct spi_message *m)
 >> +{
 >> +	struct spi_mux_gpio *mux = spi_master_get_devdata(master);
 >> +	struct spi_device *spi = m->spi;
 >> +
 >> +	void (*child_mesg_complete)(void *context);
 >> +	void *child_mesg_context;
 >> +	struct spi_device *child_mesg_dev;
 >> +
 >> +	int ret = 0;
 >> +
 >> +	ret = spi_mux_gpio_setup_mux(spi);
 >> +	if (ret)
 >> +		return ret;
 >> +
 >> +	/*
 >> +	 * Replace the complete callback, context and spi_device with our own
 >> +	 * pointers. Save originals
 >> +	 */
 >> +	child_mesg_complete = m->complete;
 >> +	child_mesg_context = m->context;
 >> +	child_mesg_dev = m->spi;
 >> +
 >> +	m->complete = spi_mux_gpio_complete_cb;
 >> +	m->context = mux;
 >> +	m->spi = mux->spi;
 >> +
 >> +	/* do the transfer + wait until it is done */
 >> +	mux->xfer_complete = false;
 >> +	spi_async(mux->spi, m);
 >> +
 >> +	ret = wait_event_interruptible(mux->xfer_complete_wq,
 >> +				       mux->xfer_complete);
 >> +
 >> +	/*
 >> +	 * restore callback, context, spi_device and do finalize, even if
 >> +	 * ret != 0. In that case, m->actual_length will hold the bytes
 >> +	 * actually transferred.
 >> +	 */
 >> +	m->complete = child_mesg_complete;
 >> +	m->context = child_mesg_context;
 >> +	m->spi = child_mesg_dev;
 >> +	spi_finalize_current_message(master);
 >> +
 >> +	return ret;
 >> +}

 Grant> I think it has gotten two complex here.  spi_mux_gpio_transfer_one_message()
 Grant> is doing a bunch of work to set up a wait event to finish up with the
 Grant> transfer. However, it really doesn't need to do this. It can return
 Grant> immediately after accepting and passing on the transfer.
 Grant> spi_finalize_current_message() can be called directly in
 Grant> spi_mux_gpio_complete_cb(). The spi core will make sure transfer doesn't
 Grant> get called again if there is already a transfer in-flight.

 Grant> Mark commented on this too, but I disagree with him on one point; it
 Grant> will actually be simpler if you finish up the transfer in the callback,
 Grant> and that it really should be implemented that way from day one.

 Grant> xfer_complete and xfer_complete_wq can be dropped, and
 Grant> child_mesg_complete, child_mesg_context and child_mesg_dev will move
 Grant> into struct spi_mux_gpio.

Thanks. We weren't quite sure about the logic here, but will change for
v2.



 >> +
 >> +static int spi_mux_gpio_probe_dt(struct spi_mux_gpio *mux)

 Grant> There really isn't any good reason other than function length to have
 Grant> this separate from the spi_mux_gpio_probe(). Probe functions are a bit
 Grant> linear sequence of setups anyway. Just roll it into the main function.

Ok, will do.


 >> +static struct spi_driver spi_mux_gpio_driver = {
 >> +	.probe	= spi_mux_gpio_probe,
 >> +	.remove	= spi_mux_gpio_remove,
 >> +	.driver	= {
 >> +		.owner	= THIS_MODULE,
 >> +		.name	= "spi-mux-gpio",
 >> +		.of_match_table = of_match_ptr(spi_mux_gpio_of_match),

 Grant> This is a DT-only driver. The of_match_ptr() bit isn't needed.


Ok, will fix for v2.

-- 
Bye, Peter Korsgaard

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb

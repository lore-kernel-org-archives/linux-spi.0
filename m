From: Aaron Wu <aaronwu06-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi:add support for slave function in current spi
	framework
Date: Thu, 10 Feb 2011 10:25:04 +0800
Message-ID: <AANLkTikh3XpMpTqk+=R+==6oDr6hjMq68pzyu5si+WeX@mail.gmail.com>
References: <1296463611-18764-1-git-send-email-Aaron.Wu06@gmail.com>
	<20110202040522.GD29148@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	"Aaron.Wu" <Aaron.Wu06-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20110202040522.GD29148-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

Just come back from the long holiday. Thanks very much for the comment and
hints. Following your idea here is some update of our plan:

Yes the slave can not predict when the transaction is going to happen, and
it takes time before the slave is ready for the transaction after the system
power on, so maybe as a slave we should assert an GPIO to inform the master
that we are ready once we finished the initialization? Then from the
application level, we issue a blockable read, waitting for the master
to initiate the transaction.

It's also true that what we do next is highly up to what we get from the
master, so we plan to put this protocal related strategy to the userspace.
The application is in charge of analyzing each unit of data the slave
receives, and take the proper action by calling the slave driver operations.

So basically the slave driver will reside in a sub-directory as you
suggested, export the read/write and a couple of IOCTLs, it is capable of:
-- assert an GPIO once it's ready
-- being configured to operate at different speed, spi_mode 0~3, word
length, etc.
-- read from the master
-- write to the master
-- duplex data transaction with the master

It will make use of some of the existing data structures for spi master,
without cooperating with them. In the board file, there will be a
slave_spi_board_info, the slave framework will alloc and create related spi
slave device by scanning this table, much the same like how we did for spi
master.

Apart for the common slave driver mentioned above, there will be one spi
slave controller driver file for each of the specific slave controller,
where the slave operations is implemented for different actual slave
controller according to their ASIC IP module specification.

The main reason that we plan to through the strategy to user space
application is because there is no existing standard for the transacted data
interpretation, this application decide the transaction protocol on behalf
of the slave device, representing the master side programmer a
specification defining the charactor of the slave device.

Need your feed back before moving forward.

Best regards,
Aaron



On Wed, Feb 2, 2011 at 12:05 PM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>wrote:

> On Mon, Jan 31, 2011 at 04:46:51PM +0800, Aaron.Wu wrote:
> > This is for the current git trunk and it's basically from  the patch once
> post by Ken Mills.  It's a draft version showing how we plan to implement
> the spi slave funtion by introducing some changes on the current spi
> framework, if this style of implementation is going to be accepted then we
> will go on to do more work on it.
> >
> > Signed-off-by: Aaron.Wu <Aaron.Wu06-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/spi/spi.c       |  401
> ++++++++++++++++++++++++++++++++++++++++-------
> >  include/linux/spi/spi.h |   97 ++++++++++--
> >  2 files changed, 432 insertions(+), 66 deletions(-)
>
> Hi Aaron,
>
> I made a few comments about the patch itself, but there is something
> more fundamental that needs to be addressed first, so I'll move it to
> the top...
>
> > diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> > index a3059c2..8663947 100644
> > --- a/include/linux/spi/spi.h
> > +++ b/include/linux/spi/spi.h
> > @@ -24,15 +24,18 @@
> >  #include <linux/slab.h>
> >
> >  /*
> > - * INTERFACES between SPI master-side drivers and SPI infrastructure.
> > - * (There's no SPI slave support for Linux yet...)
> > - */
> > + * INTERFACES between SPI Master/Slave side drivers and
> > + * SPI infrastructure.
> > + * SPI Slave Support added : It uses few new APIs and
> > + * a new spi_slave struct
> > +*/
> >  extern struct bus_type spi_bus_type;
> >
> >  /**
> >   * struct spi_device - Master side proxy for an SPI slave device
> >   * @dev: Driver model representation of the device.
> > - * @master: SPI controller used with the device.
> > + * @master: SPI Master controller used with the device.
> > + * @slave: SPI Slave Controller used with the device
>
> Absolutely not.  Handling SPI slave mode is fundamentally different
> from spi master mode.  In master mode, Linux is scheduling
> transactions and gets the final say about who talks when.  It is able
> to completely prepare the transactions ahead of time and knows exactly
> how long each one is going to be and what it will contain in the
> outgoing direction.
>
> However, spi slave mode must sit on the bus and wait for some external
> entity to initiate a transfer.  Worse than that, it possibly needs to
> read the first part of the input data, act on it, and change the
> outgoing bits depending on the input /within the same transfer/.
> Conceptually it is entirely different from SPI master mode.  I will
> not accept a solution that co-opts the master-mode infrastructure for
> implementing a slave mode.  Heck, the spi_message/spi_transfer
> structures don't even make sense for slave mode since you don't know
> how long the transfer is going to be or how it will be broken up into
> buffers.
>
> If you want to implement slave mode, then it is a separate sub system.
> You are welcome to use some of the master mode structures and routines
> provided that it does not create additional complexity to the
> master-mode code paths.  You're also welcome to create a slave
> subdirectory under the drivers/spi directory.  I'm not opposed to
> implementing spi-slave support, but it needs to be a subsystem that
> reflects the conceptual model of slave mode, and doesn't try to
> shoehorn into master mode.
>
> When you do write the spi_slave subsystem, also make sure that you
> write a good dollop of documentation to help me get my brain around
> the mental modal that you're proposing for slave support.  Doing so
> will make review and understanding easy.
>
> Some general patch etiquette comments below...
>
> >
> > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > index b02d0cb..b2757d4 100644
> > --- a/drivers/spi/spi.c
> > +++ b/drivers/spi/spi.c
> > @@ -29,19 +29,39 @@
> >  #include <linux/spi/spi.h>
> >  #include <linux/of_spi.h>
> >
> > +
> > +/* SPI bustype, spi_master and spi_slave class are registered after
> board
> > + * init code provides the SPI device tables, ensuring that both are
> present
> > + * by the time controller driver registration causes spi_devices
> > + * to "enumerate".
> > + */
> > +
> > +/* SPI Slave Support is added for new spi slave devices: It uses common
> APIs,
> > + * apart from few new APIs and a spi_slave structure.
> > + */
> > +
> >  static void spidev_release(struct device *dev)
> >  {
> >       struct spi_device       *spi = to_spi_device(dev);
> >
> > -     /* spi masters may cleanup for released devices */
> > -     if (spi->master->cleanup)
> > -             spi->master->cleanup(spi);
> > +     if (spi->master) {
> > +             /* spi masters may cleanup for released devices */
> > +             if (spi->master->cleanup)
> > +                     spi->master->cleanup(spi);
> > +
> > +             spi_master_put(spi->master);
> > +     } else {
> > +             /* spi slave controller */
> > +             if (spi->slave->cleanup)
> > +                     spi->slave->cleanup(spi);
> > +
> > +             spi_slave_put(spi->slave);
> > +     }
> >
> > -     spi_master_put(spi->master);
> >       kfree(spi);
> >  }
> >
> > -static ssize_t
> > +     static ssize_t
>
> Unrelated whitespace change.  Be careful about stuff like this.  It
> says to me you don't know the full impact of what your patch is
> changing.  Always eyeball the diff output before posting a patch.
>
> >  modalias_show(struct device *dev, struct device_attribute *a, char *buf)
> >  {
> >       const struct spi_device *spi = to_spi_device(dev);
> > @@ -59,7 +79,7 @@ static struct device_attribute spi_dev_attrs[] = {
> >   */
> >
> >  static const struct spi_device_id *spi_match_id(const struct
> spi_device_id *id,
> > -                                             const struct spi_device
> *sdev)
> > +             const struct spi_device *sdev)
>
> Ditto
>
> >  {
> >       while (id->name[0]) {
> >               if (!strcmp(sdev->modalias, id->name))
> > @@ -194,7 +214,6 @@ EXPORT_SYMBOL_GPL(spi_register_driver);
> >   * Device registration normally goes into like
> arch/.../mach.../board-YYY.c
> >   * with other readonly (flashable) information about mainboard devices.
> >   */
> > -
>
> Ditto
>
> >  struct boardinfo {
> >       struct list_head        list;
> >       struct spi_board_info   board_info;
> > @@ -202,6 +221,7 @@ struct boardinfo {
> >
> >  static LIST_HEAD(board_list);
> >  static LIST_HEAD(spi_master_list);
> > +static LIST_HEAD(spi_slave_list);
> >
> >  /*
> >   * Used to protect add/del opertion for board_info list and
> > @@ -228,28 +248,70 @@ static DEFINE_MUTEX(board_lock);
> >   */
> >  struct spi_device *spi_alloc_device(struct spi_master *master)
> >  {
> > -     struct spi_device       *spi;
> > +     struct spi_device       *spi_m_dev;
>
> This is a local variable, and it doesn't measurable change
> the understanding of the routine.  By renaming it it causes a large
> amount of churn that is completely unrelated to the task at hand,
> makes the patch hard to review, and doesn't provide any real benefit.
>
> >       struct device           *dev = master->dev.parent;
> >
> >       if (!spi_master_get(master))
> >               return NULL;
> >
> > -     spi = kzalloc(sizeof *spi, GFP_KERNEL);
> > -     if (!spi) {
> > +     spi_m_dev = kzalloc(sizeof *spi_m_dev, GFP_KERNEL);
> > +     if (!spi_m_dev) {
> >               dev_err(dev, "cannot alloc spi_device\n");
> >               spi_master_put(master);
> >               return NULL;
> >       }
> >
> > -     spi->master = master;
> > -     spi->dev.parent = dev;
> > -     spi->dev.bus = &spi_bus_type;
> > -     spi->dev.release = spidev_release;
> > -     device_initialize(&spi->dev);
> > -     return spi;
> > +     spi_m_dev->master = master;
> > +     spi_m_dev->slave = NULL;
> > +     spi_m_dev->dev.parent = dev;
> > +     spi_m_dev->dev.bus = &spi_bus_type;
> > +     spi_m_dev->dev.release = spidev_release;
> > +     device_initialize(&spi_m_dev->dev);
> > +     return spi_m_dev;
> >  }
> >  EXPORT_SYMBOL_GPL(spi_alloc_device);
> >
> > @@ -70,6 +73,7 @@ extern struct bus_type spi_bus_type;
> >  struct spi_device {
> >       struct device           dev;
> >       struct spi_master       *master;
> > +     struct spi_slave        *slave;
> >       u32                     max_speed_hz;
> >       u8                      chip_select;
> >       u8                      mode;
> > @@ -206,8 +210,8 @@ static inline void spi_unregister_driver(struct
> spi_driver *sdrv)
> >  /**
> >   * struct spi_master - interface to SPI master controller
> >   * @dev: device interface to this driver
> > - * @list: link with the global spi_master list
> >   * @bus_num: board-specific (and often SOC-specific) identifier for a
> > + * @list: link with the global spi_master list
>
> Another unrelated change hunk.  Be careful about these.
>
> g.
>
------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb

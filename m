From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: spi32766.1 when probing via dt
Date: Fri, 27 Apr 2012 11:32:07 -0600
Message-ID: <20120427173207.1B16F3E0B4D@localhost>
References: <CAOMZO5DH96X8i=UWL5fj4vwg8cskHK6arq3Nizz6fhnPkYGOzw@mail.gmail.com>
	<CAOMZO5BgubdvTVu2tz6khgGbsVKJ0BAEB_91BiDE37M5aQf86w@mail.gmail.com>
Content-Type: multipart/mixed; boundary="===============5956797578733088870=="
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAOMZO5BgubdvTVu2tz6khgGbsVKJ0BAEB_91BiDE37M5aQf86w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============5956797578733088870==

On Tue, 24 Apr 2012 22:52:36 -0300, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Apr 24, 2012 at 9:18 PM, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > Hi,
> >
> > When booting a non-DT kernel for (imx_v6_v7_defconfig)  I get:
> >
> > mtd_dataflash spi0.1: at45db321d (4096 KBytes) pagesize 512 bytes (OTP)
> >
> > Booting the same kernel via DT:
> >
> > mtd_dataflash spi32766.1: at45db321d (4096 KBytes) pagesize 512 bytes (OTP)
> >
> > Where does the '32766' bus number come from? Is this a bug?

No, it is not a bug.

SPI bus number *should not matter*.  In the DT case, the bus number is
dynamically allocated, but this should be fine since any SPI clients
will have direct access to the bus.  The reason the number is so large
is to avoid any possible conflict with statically assigned SPI bus
numbers and therefore problems with getting the wrong spi board info
attached to a bus.  It's a stupid numbering scheme, but it is a safe
stupid scheme.

> Ok, if I patch it like this:
> 
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -966,7 +966,6 @@ EXPORT_SYMBOL_GPL(spi_alloc_master);
>   */
>  int spi_register_master(struct spi_master *master)
>  {
> -       static atomic_t         dyn_bus_id = ATOMIC_INIT((1<<15) - 1);
>         struct device           *dev = master->dev.parent;
>         struct boardinfo        *bi;
>         int                     status = -ENODEV;
> @@ -986,7 +985,7 @@ int spi_register_master(struct spi_master *master)
>                 /* FIXME switch to an IDR based scheme, something like
>                  * I2C now uses, so we can't run out of "dynamic" IDs
>                  */
> -               master->bus_num = atomic_dec_return(&dyn_bus_id);
> +               master->bus_num = dev->id;
>                 dynamic = 1;
>         }
> 
> Then the spi bus number becomes the same in dt and non-dt cases.

... and is also unsafe.

> So maybe the current behavior is expected because the usage of  dyn_bus_id ?

Yes, that is the exact reason for the current behaviour.

Now, having said all that, I am open to solutions.  Ideally, both
userspace and kernel space should not care.  Kernelspace already has
access to the information it needs to decode an spi bus number, and
userspace can get the information by looking in sysfs for the spi bus
device that is associated with the device tree node (look at the
uevent data).

However, if you *really* want to assign a specific spi bus number,
then it needs to be remembered that spi bus numbering is a global
resource and needs to be handled carefully to avoid conflicts.  An
appropriate way to do this could be to add "spi#" properties to the
/alias node and have the spi core code look for an spi alias when
dynamically assigning a bus number.  If an alias exists, then it is
safe to use that as the bus number.

g.


-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.


--===============5956797578733088870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============5956797578733088870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============5956797578733088870==--

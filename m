From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: SPI Framework in Linux
Date: Tue, 6 Jul 2010 17:22:46 -0600
Message-ID: <AANLkTimFzHdY6luh2UQOLoTlI8kjdwIeiazT6YSdWdMU@mail.gmail.com>
References: <AANLkTimMpQXQyj4bmsIDxu-OtK15532g5ArjGIfQSMwy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: ananth <ananth86coolguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTimMpQXQyj4bmsIDxu-OtK15532g5ArjGIfQSMwy-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jul 1, 2010 at 9:10 AM, ananth <ananth86coolguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi
>
> =A0 I am learning the SPI framework in linux. I read the spi-summary and
> documentation. I couldn't get a clear picture of what's happening. Is the=
re
> any other document or article which gives a overview of the SPI framework=
 in
> linux?Also could you give me any driver which uses SPI for communicating
> with devices like touchscreen or other SPI compatible sensors?

The SPI subsystem uses the Linux device model much the same way as
other bus types in the Linux kernel.  SPI master controller drivers
create instances of spi busses.  one or more spi_devices is registered
on the spi_bus_type as children of the spi_master bus.  spi_drivers
also get registered onto the spi_bus_type.  Whenever the spi subsystem
code finds an spi_device and an spi_driver that match (a driver that
is able to driver the device) it calls the probe() routine on the
spi_driver with a pointer to the spi_device structure.

So, for your spi bus controller, you need to have an spi master driver.
For each spi device, you need to have a matching spi_driver loaded
into the kernel.

Take a look at the book Linux Device Drivers 3rd edition for
information on the device model.  Read the source code for detailed
information about the spi bus type.

Cheers,
g.

>
> Thanks
> Ananth
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first

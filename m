From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/3] spi/qspi: Add memory mapped read support.
Date: Wed, 9 Oct 2013 22:24:33 +0530
Message-ID: <52558A49.5090904@ti.com>
References: <1381332284-21822-1-git-send-email-sourav.poddar@ti.com>
	<1381332284-21822-2-git-send-email-sourav.poddar@ti.com>
	<20131009160759.GQ21581@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20131009160759.GQ21581-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 09 October 2013 09:37 PM, Mark Brown wrote:
> On Wed, Oct 09, 2013 at 08:54:42PM +0530, Sourav Poddar wrote:
>
>> Qspi controller also supports memory mapped read. Patch
>> adds support for the same.
>> In memory mapped read, controller need to be switched to a
>> memory mapped port using a control module register and a qspi
>> specific register or just a qspi register.
>> Then the read need to be happened from the memory mapped
>> address space.
> Can you provide more details on what exactly this means?  Looking at the
> code it looks awfully like this has the same problem that the Freescale
> code had with needing to know the commands the flash needs?
Here is the exact feature usecase..
TI qspi controller supports memory mapped read. These memory
mapped read configuration depends on the set_up_register, which
can be configured once during in setup apis based on the dt node
specifying whether the qspi controller supports memory mapped read
or not.
Once, the qspi controller is configured for a memory mapped read, the qspi
controller does not depend on the flash command that comes from the mtd 
layer.
Because, this command are already configured in QSPI set up register.

To use qspi in memory mapped mode, we need to switch to memory mapped port
using certain registers(for am43x its only qspi register, while for 
dra7x its qspi register
as well as control module register) and once the memory mapped read is 
done, switch
back to configuration mode register.

Basically, its not the commands which need to be communicated from the 
mtd layer,its just
the buffer to fill, len of buffer, offset from where to fill need to be 
communicated.

> I'm also concerned about the interface here, it looks like this is being
> made visible to SPI devices (via a dependency on patch 3/3...) but only
> as a flag they can set - how would devices know to enable this and why
> would they want to avoid it?
Set  spi->mode in qspi driver based on dt entry and use that in mtd layer to
decide whether to use memory mapped or not.

The idea is whenever, we call mtd_read api from mtd layer, if memory 
mapped is set
then sending the commands does not matter, what matters is the len to 
read, buffer to fill and
"from" offset to read. Then, the intention was to use the memory_map 
transfer parameter to
communicate to the driver that memory mapped read is used so that we can 
just use memcopy and
return without going through the entire SPI based xfer function.




------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk

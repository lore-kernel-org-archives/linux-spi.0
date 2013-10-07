From: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Subject: Adding/changing SPI device registrations on the fly via the load
	of a module
Date: Mon, 07 Oct 2013 13:47:30 +0200
Message-ID: <52529F52.8030703@sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi!

A lot of people have been trying to get their preferred SPI devices 
working on a Raspberry Pi (and probably some other development boards as 
well).
Most (newbies) of them have failed because it requires a recompile of 
the kernel to change the default config from SPIDEV to any other device 
of your choice - at least for non-device tree devices.

This is quite "burdensome" for people new to Linux, who just want to 
access their device - most of the time just changing modinfo, 
max_speed_hz and maybe assigning an irq-line for the driver.

As far as my experience goes, the ability to change the SPI device 
registration on the fly on development board (beagle-board, openwrt 
routers,...) would be of great advantage to the users.

Device tree would provide the "config" part, but would not allow to 
change settings on the fly. Also Device-tree requires a lot of 
"knowledge" (especially to newbies, that just want to add an ADC, or 
access a CAN bus board they just bought) to get it right and then a 
reboot hoping for the device-tree to work...

So here a proposal for a "simple" module that does only register SPI 
devices based on arguments passed to it when loading the module (and 
releasing the devices when removing the module).

You can find it in the form of an out of tree module at: 
https://github.com/msperl/spi-config

I agree, that this module provides some means to shoot yourself into the 
foot resulting in a crashed kernel.
But at least after a reboot we are back to "normal" again without any 
additional recovery procedures to boot the kernel.
So it is not an optimal solution, but at least it fills the niche for 
quick modifications to a system when the parts in question are not 
needed to get the system up and running in the first place.

The other benefit is that it also reduces support overhead for people 
who create and sell extension modules/capes/..., who then have to 
provide a separately patched kernel to make the extension work. With the 
above approach they just need to provide the command "modprobe 
spi-config device=..." and then load the relevant SPI driver module to 
get the people started with the default kernel that comes with the 
OS/board (assuming the OS has the module compiled).

Please review this out-of-tree-module and give some feedback.
Maybe you find it valuable enough to get it included with the kernel itself?

Thanks,
             Martin

P.s: the module has an option to replace an existing SPI 
board-registration that comes with the default kernel. But - for now -  
such an action will taint the kernel, as this action might produce 
unexpected results... (besides memory that does not get freed)


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134791&iu=/4140/ostg.clktrk

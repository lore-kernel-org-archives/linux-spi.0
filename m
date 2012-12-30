From: Juha Lumme <juha.lumme-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Trying to use spidev to send an spi message, result from spidev_test.c
	"Illegal argument" . (i.mx23, kernel 3.7)
Date: Sun, 30 Dec 2012 18:14:55 +0900
Message-ID: <50E0060F.8060604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

Hi,

I am having issues communicating with a micro controller connected to 
SPI bus, using spidev.
I would like to send messages to my MSP430 from user land, but so far no 
luck.

At least I know that my SPI bus should be ok, since in the same bus I 
have a SPI flash chip that works.
In my DTS I have added my 2 SPI devices as such:

ssp1: ssp@80034000 {
                 #address-cells = <1>;
                 #size-cells = <0>;
                 compatible = "fsl,imx23-spi";
                 pinctrl-names = "default";
                 pinctrl-0 = <&spi2_pins_a &spi2_pin_cs1>;
                 status = "okay";

                 flash: m25p80@0 {
                     #address-cells = <1>;
                     #size-cells = <1>;
                     compatible = "sst,sst25vf064b";
                     spi-max-frequency = <10000000>;
                     reg = <0>;

                 };
                 ucontroller: spidev@1 {
                     compatible = "linux,spidev";
                     spi-max-frequency = <1000000>;
                     reg = <1>;
                 };

My pin configuration is like this:
spi2_pins_a: spi2@0 {
                     reg = <0>;
                     fsl,pinmux-ids = <
                         0x0182 /* MX23_PAD_GPMI_WRN__SSP2_SCK */
                         0x0142 /* MX23_PAD_GPMI_RDY1__SSP2_CMD */
                         0x0002 /* MX23_PAD_GPMI_D00__SSP2_DATA0 */
                         0x0032 /* MX23_PAD_GPMI_D03__SSP2_DATA3 */
                     >;
                     fsl,drive-strength = <1>;
                     fsl,voltage = <1>;
                     fsl,pull-up = <1>;
                 };

                 //Added for chip select in SPI2
                 spi2_pin_cs1: spi2@1 {
                     reg = <0>;
                     fsl,pinmux-ids = <
                         0x0042 /* MX23_PAD_GPMI_D03__SSP2_DATA4 */
                     >;
                     fsl,drive-strength = <1>;
                     fsl,voltage = <1>;
                     fsl,pull-up = <1>;
                 };

Now, after boot when I mount devtmpfs, spidev is shown under /dev.
The whole system has this SPI stuff:
# find / -name "spi*"
/sys/bus/spi
/sys/bus/spi/devices/spi32766.0
/sys/bus/spi/devices/spi32766.1
/sys/bus/spi/drivers/spidev
/sys/bus/spi/drivers/spidev/spi32766.1
/sys/bus/platform/drivers/spi_gpio
/sys/devices/80000000.apb/80000000.apbh/80034000.ssp/spi_master
/sys/devices/80000000.apb/80000000.apbh/80034000.ssp/spi_master/spi32766
/sys/devices/80000000.apb/80000000.apbh/80034000.ssp/spi_master/spi32766/spi32766.0
/sys/devices/80000000.apb/80000000.apbh/80034000.ssp/spi_master/spi32766/spi32766.1
/sys/devices/80000000.apb/80000000.apbh/80034000.ssp/spi_master/spi32766/spi32766.1/spidev
/sys/devices/80000000.apb/80000000.apbh/80034000.ssp/spi_master/spi32766/spi32766.1/spidev/spidev32766.1
/sys/class/spi_master
/sys/class/spi_master/spi32766
/sys/class/spidev
/sys/class/spidev/spidev32766.1
/sys/module/spidev
/home/default/spitest
/dev/spidev32766.1

The error: I compiled the spidev_test.c application under 
Documentation/spi, but I keep getting "Invalid argument", when I try to 
send a message to my MSP430:

#./spidev
spi mode: 0
bits per word: 8
max speed: 500000 Hz (500 KHz)
can't send spi message: Invalid argument
Aborted
#
In dmesg, I have added some traces to spidev and mxs-spi to see that 
something seems to be happening in both:
[  986.590000] spidev/spidev_open >>
[  986.590000] spidev/spidev_ioctl >>
[  986.600000] spi-mxs/mxs_spi_setup >> bpw: (8)
[  986.610000] spi-mxs/mxs_spi_setup_transfer >>
[  986.610000] spi-mxs/mxs_spi_setup_transfer <<
[  986.620000] spidev spi32766.1: setup mode 0, 8 bits/w, 500000 Hz max 
--> 0
[  986.620000] spidev spi32766.1: spi mode 00
[  986.620000] spidev/spidev_ioctl >>
[  986.630000] spidev/spidev_ioctl >>
[  986.630000] spi-mxs/mxs_spi_setup >> bpw: (8)
[  986.640000] spi-mxs/mxs_spi_setup_transfer >>
[  986.650000] spi-mxs/mxs_spi_setup_transfer <<
[  986.650000] spidev spi32766.1: setup mode 0, 8 bits/w, 500000 Hz max 
--> 0
[  986.650000] spidev spi32766.1: 8 bits per word
[  986.650000] spidev/spidev_ioctl >>
[  986.650000] spidev/spidev_ioctl >>
[  986.670000] spi-mxs/mxs_spi_setup >> bpw: (8)
[  986.670000] spi-mxs/mxs_spi_setup_transfer >>
[  986.670000] spi-mxs/mxs_spi_setup_transfer <<
[  986.680000] spidev spi32766.1: setup mode 0, 8 bits/w, 500000 Hz max 
--> 0
[  986.680000] spidev spi32766.1: 500000 Hz (max)
[  986.690000] spidev/spidev_ioctl >>
[  986.690000] spidev/spidev_ioctl >>
[  986.690000] spidev/spidev_message >>
[  986.710000] spidev spi32766.1:   xfer len 12 rx tx 8bits 0 usec 500000Hz
[  986.710000] spidev/spidev_sync >>
[  986.710000] spidev/spidev_message/ sync status was: (-22)
[  986.720000] spidev/spidev_release >>

Any ideas why I get the illegal argument ?


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_123012

From: llandre <r&d2-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org>
Subject: Re: Protocol driver probe function never invoked
Date: Tue, 24 Jul 2007 08:38:50 +0200
Message-ID: <46A59E7A.8010204@dave-tech.it>
References: <46A46CCA.7010303@dave-tech.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46A46CCA.7010303-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The probe function is not invoked because the controller does not allow 
to reach the max_speed_hz.
I did not realize this before because, even if the debug messages were 
enabled, I did not see any warning message about this.

-- 
llandre

DAVE Electronics System House - R&D Department
web:   http://www.dave-tech.it
email: r&d2-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org


> Hi all,
> 
> I'm working with kernel 2.6.21.3 on Freescale iMXL-based platform.
> I have to write a SPI protocol driver for Quantum QT510 touch controller.
> As starting point for board-init code I used the driver released by 
> Pavel Pisa:
> http://rtime.felk.cvut.cz/repos/ppisa-linux-devel/kernel-patches/current/pimx1-board-spi.patch
> 
> In protocol driver I defined spi_driver like this:
> 
> static struct spi_driver qt510_driver = {
> 	.driver = {
> 		.name		= QT510_MODALIAS,
> 		.owner		= THIS_MODULE,
> 	},
> 	.probe		= qt510_probe,
> 	.remove		= __devexit_p(qt510_remove),
> };
> 
> static int __init qt510_init(void)
> {
> 	return spi_register_driver(&qt510_driver);
> }
> module_init(qt510_init);
> 
> 
> In board-init code I used the same name for modalias field:
> 
> 
> static struct spi_board_info parsy_spi_board_infos[] __initdata = {
> 	{
> 	 .modalias = "loopback",
> 	 .max_speed_hz = 1600000,
> 	 .bus_num = 1,
> 	 .chip_select = 0x00,
> 	 .mode = SPI_MODE_0,
> 	 .controller_data = &spi_controller_data[0],
> 	 },
> 	{
> 	 .modalias = QT510_MODALIAS,
> 	 .max_speed_hz = QT510_SPI_CLK_MAX,
> 	 .bus_num = 1,
> 	 .chip_select = 0x01,
> 	 .mode = SPI_MODE_3,
> 	 .controller_data = &spi_controller_data[1],
> 	 },
> 	{
> 	 .modalias = "tbd",
> 	 .max_speed_hz = 1600000,
> 	 .bus_num = 1,
> 	 .chip_select = 0x2,
> 	 .mode = SPI_MODE_0,
> 	 .controller_data = &spi_controller_data[2],
> 	 },
> };
> 
> 
> However the probe function (qt510_probe) is never invoked.
> In my understanding this is due to the fact that there are no devices 
> associated to the bus:
> 
> bash-3.00# ls -la /sys/bus/spi/devices/
> total 0
> drwxr-xr-x  2 root root 0 Jan  1  1970 .
> drwxr-xr-x  4 root root 0 Jan  1  1970 ..
> bash-3.00# ls -la /sys/bus/spi/drivers/
> total 0
> drwxr-xr-x  4 root root 0 Jan  1  1970 .
> drwxr-xr-x  4 root root 0 Jan  1  1970 ..
> drwxr-xr-x  2 root root 0 Jan  1  1970 qt510
> drwxr-xr-x  2 root root 0 Jan  1  1970 spidev
> bash-3.00#
> 
> Am I missing something?
> 
> TIA,
> llandre
> 
> DAVE Electronics System House - R&D Department
> web:   http://www.dave-tech.it
> email: r&d2-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org
> 
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
> 
> 



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/

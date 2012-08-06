From: Jack Mitchell <ml-YbFJW3Hi15w4V3TWAi07hPXRex20P6io@public.gmane.org>
Subject: Turning off dev_dbg in spi_setup
Date: Mon, 06 Aug 2012 10:45:03 +0100
Message-ID: <501F921F.5060607@communistcode.co.uk>
Reply-To: ml-YbFJW3Hi15w4V3TWAi07hPXRex20P6io@public.gmane.org
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

I hope this appropriate on this mailing list, please let me know if it 
isn't.

I have developed an SPI driver which needs to toggle the SPI_MODE in 
between reads and writes (I know, supporting legacy hardware right?). To 
do this I do the following:

    axonSPI_dev.spi_device->mode = SPI_MODE_0;
    spi_setup(axonSPI_dev.spi_device);

This works fine, however I cannot for the life in me stop the dev_dbg 
function in spi_setup from printing to the kernel log at every call. So,

1) Is this the best way to toggle the SPI_MODE on the fly?

2) Does anyone have any suggestions to why dev_dbg refuses to stop 
outputting every time I call spi_setup.

This is a kernel module and the spi master is registered dynamically on 
ismod.

Kind Regards,

-- 

   Jack Mitchell (jack-psbXN780rFT10XsdtD+oqA@public.gmane.org)
   Embedded Systems Engineer
   http://www.embed.me.uk

--


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/

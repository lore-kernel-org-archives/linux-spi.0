From: "J.I. Cameron" <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Subject: Spi slave devices with two chip selects, how best to handle?
Date: 25 Nov 2010 22:08:21 +0000
Message-ID: <Prayer.1.3.3.1011252208210.17045@hermes-2.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: drivers-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

I've just been looking through some recent drivers from Analog Devices that 
are in staging-next (and hence linux-next 
http://git.kernel.org/?p=linux/kernel/git/next/linux-next.git;a=blob;f=drivers/staging/iio/gyro/adis16060_core.c;h=fc48aca04bd3420b705b79d3cbb5c0117e187568;hb=HEAD 
) and ran into something I haven't seen before.

The adis16060
http://www.analog.com/static/imported-files/data_sheets/ADIS16060.pdf
uses two chip selects. One is for writing to the device and one
is for reading.

At the moment, the adis16060 driver registers a pair of spi drivers, 
adis16060_r and adis16060_w. The problem comes in how these two get 
information about each other. Currently there is a global pointer in that 
file. Obviously this means that we can only have one of these devices 
running at a time and should be removed. So what I'm basically asking is if 
anyone else has run into a similar situation and what their solution was. 
We could put a magic code in the platform data for the two devices and use 
that to link them together but that's ugly and would mean having the driver 
handle lists of the drivers that are currently registered but not paired so 
as to be able to pair them up. Anyone have a better idea or an example of 
what someone else has done in similar circumstances?

Thanks,

Jonathan 

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev

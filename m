From: Sergio Donati <sergio_donati-whZMOeQn8C0@public.gmane.org>
Subject: Linux SPI newbie ST M25P16
Date: Wed, 16 Dec 2009 18:24:15 +0000 (GMT)
Message-ID: <137450.30492.qm@web24207.mail.ird.yahoo.com>
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

Good morning,

I run into a big trouble:
I am very new to linux embedded , and i have to interface an ST M25p16 to a MPC8313E cpu.
I am working on a demoboard MPC8313E-RDB REVA2, with the ltib-mpc8313erdb-20081222 coming from Freescale.
~ # uname -a
Linux mpc8313erdb 2.6.23 #12 Tue Dec 15 14:21:22 CET 2009 ppc unknown

  i have connected the M25P16 to the SPI controller but now i am very very confused.
I know quite well how the SPI signals works, but:

I don't know how to access the memory and how to use the functions and/or the driver resources.

I have activated into the kernel configuration the following items: 

----Memory Technology Device (MTD) support
     <*>   MTD concatenating support
     [*]   MTD partitioning support
     [*]     Command line partition table parsing
     <*>   Direct char device access to MTD devices
     <*>   Caching block device access to MTD devices

---- SPI support
     [*] SPI support
     <*> Freescale MPC83xx SPI controller
     <*> SPI EEPROMs from most vendors

- The /dev directory doesn't show any device referring to the memory.
- The SPI signals except of one dummy byte during the startup phase are stucked into the idle state.

I take a look to the file "m25p80.c" but i have not clear how to use it.
Have i to declare something into the .dts file? in wich way?
Someone knows if there is some example about it?
Same story with "spidev.c".
Which log can help you to help me?  

100000 Thanks to everyone that will help me.

                                   Sergio Donati








      

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 

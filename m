From: Fabio Tosetto <tosettofabio83-VGgt2q2+T+FeoWH0uzbU5w@public.gmane.org>
Subject: SD-MMC over SPI on PSC6
Date: Thu, 22 May 2008 12:42:51 +0200
Message-ID: <48354E2B.8010003@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, garyj-ynQEQJNshbs@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, g.liakhovetski-Mmb7MZpHnFY@public.gmane.org,
	drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org
To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hello, I have an embedded system with an on-board processor powerpc 
MPC5200B
and Linux kernel 2.6.22,
I must turn over to MMC SPI on the PSC6.

The MMC over SPI is connected to MPC5200b, here's how:

  MPC5200B
----------------                                        
                       
|                                                                 
|------------------
         PSC1_2 |--->------------Chip_Select (out)---------|      
                       
|                                                                 |
                       |                        
                                         |     SD CARD
         ETH_17 |---<------------IRQ (in)------------------|   MMC over SPI
                       |                                                
                 |
                       
|                                                                 |
         PSC6_0 |---<------------SPI_RXD (in)------------|
                       
|                                                                 |
                       
|                                                                 |
         PSC6_2 |--->------------SPI_TXD (out)-----------|
                       |                                                 
                |
                       |                                                 
                |
         PSC6_3 |--->------------SPI_CLK (out)-----------|
                       
|                                                                 
|------------------
----------------

Now on the menuconfig enabling these options:

$ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- menuconfig

Platform support  --->
   [*] MPC5200 (L25R) bugfix support
   [*] Freescale Lite5200 Eval Board

Device Drivers  ---> SPI Support --->
   [*] SPI support
  <*> Freescale MPC52xx PSC SPI controller

Now I have applied those patch:
http://www.mail-archive.com/spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org/msg00150.html

Now on the menuconfig enabling these options:

$ make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu- menuconfig

Device Drivers  --->  MMC/SD card support --->
 [*] MMC debugging
<*> MMC block device driver
<*> MMC host test driver
<*> MMC/SD over SPI

Is correct applied those patch and enable those options into menuconfig?

thanks Fabio

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

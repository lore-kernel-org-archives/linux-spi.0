From: "Stephen Neuendorffer" <stephen.neuendorffer-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Simple driver for Xilinx SPI
	controler.
Date: Wed, 6 Jun 2007 12:06:38 -0700
Message-ID: <20070606190640.B7028900053@mail104-cpk.bigfish.com>
References: <fa686aa40706061200u1141fcc9k73b7cc80c07240d1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrei Konovalov <akonovalov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>,
	Wolfgang Reissnegger <wre-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linuxppc-embedded-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: "Grant Likely" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <fa686aa40706061200u1141fcc9k73b7cc80c07240d1-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


> > config XILINX_EDK
> >         bool
> >         depends on XILINX_VIRTEX || XILINX_MICROBLAZE
> >         default y
> 
> I don't have any problem with adding XILINX_EDK (or 
> whatever), but think particular layout is back-assward.  
> Rather than XILINX_EDK depending on XILINX_VIRTEX/MICROBLAZE, 
> XILINX_VIRTEX/MICROBLAZE should 'select' XILINX_EDK and you 
> need to drop the 'default y' line.
> Otherwise the XILINX_EDK option shows up in non-edk config files.

Good point...
 
> Why still have XILINX_EDK?  I thought you meant replace 
> XILINX_EDK with XILINX_DRIVERS.

Yes, that's what I was suggesting.
But I think that Andrei still wants to use XILINX_EDK to pull in the
stuff in drivers/xilinx_common.

# The Xilinx OS common code 
obj-$(CONFIG_XILINX_EDK) += xbasic_types.o xpacket_fifo_l_v2_00_a.o \
			    xpacket_fifo_v2_00_a.o xversion.o \
			    xdma_channel.o xdma_channel_sg.o

Which you wouldn't want if you were able to build a kernel completely
from 'non-edk' drivers.

Steve



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

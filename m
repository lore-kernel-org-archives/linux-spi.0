From: Brian Niebuhr <BNiebuhr-JaPwekKOx1yaMJb+Lgu22Q@public.gmane.org>
Subject: RE: [spi-devel-general] [PATCH 0/3] davinci: spi: replace existingSPI
	driver
Date: Wed, 16 Jun 2010 10:57:29 -0500
Message-ID: <BA34378D1528D04CB3C865B8BAB2472B024D3D@transmx01.transcrypt.local>
References: <1275923348-8533-1-git-send-email-bniebuhr@efjohnson.com><004201cb0878$eaff2ac0$c0fd8040$@raj@ti.com><BA34378D1528D04CB3C865B8BAB2472B024CC7@transmx01.transcrypt.local>
	<012801cb0c7a$4e1f5210$ea5df630$@raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Sudhakar Rajashekhara" <sudhakar.raj-l0cyMroinI0@public.gmane.org>,
        <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Class: urn:content-classes:message
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> On Tue, Jun 15, 2010 at 00:43:06, Brian Niebuhr wrote:
> > > > I have compiled with the davinci_all_defconfig, but I don't 
> > > have EVMs
> > > > for the other davinci platforms to test with.
> > > > 
> > > 
> > > I was testing this series on OMAP-L137, OMAP-L138 and 
> DM365 EVMs and I
> > > found that on all these EVMS, Interrupt mode has problems. 
> > > Driver works
> > > fine in DMA and POLL modes. Some problems which I had 
> > > observed with the
> > > old driver are gone now.
> > 
> > Do you have any idea what errors you're seeing in interrupt mode?  I
> > went and retested interrupt mode with several devices on my 
> custom board
> > and it still appeared to be working fine.  It may be an 
> interaction with
> > code outside the driver because I'm running the identical 
> driver code
> > but I'm not running the latest kernel from the davinci git 
> repository.
> > I'm trying to figure out if I can get my DA850 EVM back into a state
> > where I can debug this.  Thanks for any hints you can give!  
> > 
> 
> You may be knowing that on OMAP-L138 EVM, we have M25P64 
> Flash on SPI. When
> the driver is configured in Interrupt mode, kernel booting 
> just hangs. I
> noticed that the SPI probe function is not coming out of 
> spi_bitbang_start()
> call.

I configured the M25P64 on the DA850 EVM for both DMA and interrupt mode
and my kernel still booted correctly.  I wonder if your setting for
intr_level is correct?  For the DA850 it should be set to 1.  I'm
following up with a response to Nicolas showing the changes I made to
the kernel to test this.  Can you check if the changes you made match
mine?

Thanks,

Brian

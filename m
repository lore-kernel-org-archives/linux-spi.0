From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 2/3] [SPI] Add new mode: SPI_LOOP
Date: Wed, 1 Aug 2007 11:25:47 -0700
Message-ID: <200708011125.47934.david-b@pacbell.net>
References: <20070726134754.GA3539@localhost.localdomain>
	<200707262007.07537.david-b@pacbell.net> <46A967D5.30606@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	Stephen Street <stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46A967D5.30606-/d+BM93fTQY@public.gmane.org>
Content-Disposition: inline
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

On Thursday 26 July 2007, Ned Forrester wrote:
> David Brownell wrote:
> > On Thursday 26 July 2007, Anton Vorontsov wrote:
> >> Loopback mode is supported by various controllers, this mode
> >> is useful for testing, especially in conjunction with spidev
> >> driver.
> > 
> > ISTR that Stephen Street provided a loopback mode for debug
> > in his pxa2xx_spi code.  And I know you're fight that this
> > mode shows up in a lot of hardware.
> > 
> > Comments, anyone?  This seems like a fair way to expose this
> > mechanism.  And I tend to agree that it'd mostly be useful in
> > conjunction with "spidev".
> 
> Yes, it is in pxa2xx_spi.  It is passed in a structure that is attached 
> to spi_board_info.controller_data.  I have used it to great effect to 
> test data modes in the driver for which I have no external hardware 
> support: various bits/word, clock frequencies, fifo thresholds, dma 
> burst sizes, etc.

Well, the SPI_LOOP stuff is now in kernel.org GIT and 2.6.23-rc2,
so if someone wants to update pxa2xx_spi to support this through
spi->mode instead of controller data, now is a good time to start
working on that.

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/

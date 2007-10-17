From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Status of Linux SPI slave
Date: Wed, 17 Oct 2007 17:36:41 -0400
Message-ID: <47168069.4000208@whoi.edu>
References: <01b001c810c6$053fdea0$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: 'David Brownell' <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Girish <girishsg-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <01b001c810c6$053fdea0$6a8918ac-tAZopdYwApTQT0dZR+AlfA@public.gmane.org>
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

Girish wrote:
> 
>> -----Original Message-----
>> From: David Brownell [mailto:david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org]
>> Sent: Tuesday, October 16, 2007 11:29 PM
>> To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; roger-UslnteNVNtIXWF+eFR7m5Q@public.gmane.org;
>> girishsg-l0cyMroinI0@public.gmane.org
>> Subject: Re: [spi-devel-general] Status of Linux SPI slave
> 

> And ya, It would be better if I list down some points from top of my head,
> it will make me clear. Following things done for slave;

This is a good starting summary.

> 1. Make SPI controller work in Master and Slave. There won't be any
> separate controller driver for slave. (As of now there is no support from
> stack, so stack will be blind about slave transaction)

This is exactly how I have implemented my slave device.  Major 
modifications to the controller driver, but the rest of the stack is 
blind to that, as you say.  I'm not sure that such a simple scheme will 
work for a generalized slave.

> 2. Protocol driver will still register as spi_driver. No change here, only
> difference is that the underlying device would be a master device and in
> spi_board_info table it will populate a SPI controller info which will be
> working as slave.

This is exactly the way I register my device, with minor changes to the 
board setup code, to compile in the new spi_board_info table.

> 3. One more thing I wanted to ask was about spi_setup(). How about
> supporting selecting/deselecting SPI mode (master/slave) through
> spi_setup()? We can make protocol driver free enough to override selection
> of SPI mode(master/slave).

I have also implemented full control of master/slave, clock 
source/direction, etc. through the setup() call to pxa2xx_spi, so this 
is certainly possible.

> 4. If only single controller driver is used for Master/Slave, then by
> default it should be registering as Master/slave with stack?

I guess the need to register as master or slave depends on whether there 
will be any demands on the stack that differ for the two modes.  In my 
data streaming application, there is no impact on the stack, and so 
there is no need to differentiate whether the controller is acting as 
master or slave. If, on the other hand, slave functions eventually need 
to do something new, such as allocate, populate and pass a message 
autonomously, that might require changes the stack, and thus require the 
stack to know if the controller driver is registering as master or slave.

There is an interesting point o consider regarding the protocol driver. 
  If my previous assertion is true that a Linux slave is never a master, 
because there can be only one master on any SPI bus, then perhaps this 
extension is also true: that there is only one protocol driver also. 
This is certainly what I have implemented with my streaming data 
application, but I had not considered that a single protocol driver 
might be a consequence of slave operation.  I suppose that if some SPI 
buses are implemented with multiple masters that are externally 
arbitrated, then the idea of a single protocol driver in slave mode 
would not be valid.

> Actually, I have couple of slave model floating in my mind with lots of
> questions :). I think I'll go back and try to understand more about
> transaction model required in slave, so that I can consolidate things upon
> that.

I still think that the timing issues for a generalized slave are going 
to be a fatal flaw, except when the actions of the external master are 
completely predictable (like the data streaming case).  Can anyone think 
of an example of a non-predictable master, for which a useful 
interaction can still take place without the need for zero latency response?

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/

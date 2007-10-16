From: "Girish" <girishsg-l0cyMroinI0@public.gmane.org>
Subject: Re: Status of Linux SPI slave
Date: Tue, 16 Oct 2007 19:51:11 +0530
Message-ID: <014301c80fff$ceacd710$6a8918ac@ent.ti.com>
References: <47111665.7000005@whoi.edu>
Content-Type: multipart/mixed; boundary="===============1555113955=="
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "'Ned Forrester'" <nforrester-/d+BM93fTQY@public.gmane.org>,
	"'Roger Frøysaa'" <roger-UslnteNVNtIXWF+eFR7m5Q@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <47111665.7000005-/d+BM93fTQY@public.gmane.org>
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

--===============1555113955==



>-----Original Message-----
>Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>Subject: Re: [spi-devel-general] Status of Linux SPI slave
>
>Roger Frøysaa wrote:
>> Hi.
>>
>
>For example, I have an SPI master device that streams data to a Linux
>processor at 11Mbit/sec, but never expects any response from the
>processor; this data is written over the 100baseT network to an NFS
>file system at an effective 5GBytes/hour.  To make it work, I have
>heavily modified the pxa2xx-spi driver for the target Gumstix system so
>that it can accept data driven by an external clock, and so that it uses
>a queue of DMA descriptors to prevent interrupt latency from limiting
>service of the receive FIFO.  I did not have to modify a single line of
>code anywhere else in the SPI framework.  All other parts of the SPI
>framework, as well as my protocol driver and user-space code, still
>operate as if they were part of an SPI master; they just keep full a
>queue of SPI messages that request buffers to be filled by SPI reads.
>Basically, this is a VERY limited slave function, where the Linux system
>is not in control of the timing, but also there is never any sort of
>query/response between the master and slave.

Well, now I get the minimal use of slave side transfer. As David suggested
of having spi_slave struct wrapping the hardware, have you thought of
something like that and how would your existing pxa2xx-spi driver will be
impacted?
And thanks for starting this thread:).
Actually, in my case I had to modify controller driver to support SPI in
master and slave mode as well, with standard transfers (half/full duplex
communication).

Regards,
Girish

>
>-------------------------------------------------------------------------
>This SF.net email is sponsored by: Splunk Inc.
>Still grepping through log files to find problems?  Stop.
>Now Search log events and configuration files using AJAX and a browser.
>Download your FREE copy of Splunk now >> http://get.splunk.com/
>_______________________________________________
>spi-devel-general mailing list
>spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>https://lists.sourceforge.net/lists/listinfo/spi-devel-general




--===============1555113955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--===============1555113955==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============1555113955==--

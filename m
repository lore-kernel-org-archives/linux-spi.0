From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Status of Linux SPI slave
Date: Sat, 13 Oct 2007 15:03:01 -0400
Message-ID: <47111665.7000005@whoi.edu>
References: <1190880999.29726.5.camel@shuttle>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: =?ISO-8859-15?Q?Roger_Fr=F8ysaa?= <roger-UslnteNVNtIXWF+eFR7m5Q@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1190880999.29726.5.camel@shuttle>
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

Roger Fr=F8ysaa wrote:
> Hi.
> =

> I'm wondering if there are any plans to add SPI slave mode to the SPI
>  driver framework in the "near" future? Is anyone working on
> something like this?
> =

> If not, has anyone ever considered it - and estimated the amount of
> work it would be etc?

I have been waiting to respond until there was a response from someone
knowledgeable.  As David points out, true slave capability has serious
real time implications, and the standard Linux kernel is not a real-time
kernel, as I understand it.  However, if you don't need completely
general slave capability, there may be ways to accomplish some
slave-like tasks.

For example, I have an SPI master device that streams data to a Linux
processor at 11Mbit/sec, but never expects any response from the
processor; this data is written over the 100baseT network to an NFS
file system at an effective 5GBytes/hour.  To make it work, I have
heavily modified the pxa2xx-spi driver for the target Gumstix system so
that it can accept data driven by an external clock, and so that it uses
a queue of DMA descriptors to prevent interrupt latency from limiting
service of the receive FIFO.  I did not have to modify a single line of
code anywhere else in the SPI framework.  All other parts of the SPI
framework, as well as my protocol driver and user-space code, still
operate as if they were part of an SPI master; they just keep full a
queue of SPI messages that request buffers to be filled by SPI reads.
Basically, this is a VERY limited slave function, where the Linux system
is not in control of the timing, but also there is never any sort of
query/response between the master and slave.

-- =

Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=3D7212
http://www.whoi.edu/hpb/Site.do?id=3D1532
http://www.whoi.edu/page.do?pid=3D10079


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/

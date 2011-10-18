From: "Holdsworth, Joel" <Joel.Holdsworth-IHqVjY1oUdQYQ022hMJolFaTQe2KTcn/@public.gmane.org>
Subject: RE: SPI Slave Mode
Date: Tue, 18 Oct 2011 13:43:15 +0100
Message-ID: <A542D8ED20514C4E88DE6D8CF343C2D901227C43@uksrpblkexb01.detica.com>
References: <A542D8ED20514C4E88DE6D8CF343C2D901227C40@uksrpblkexb01.detica.com>
	<4E9D6CAE.6080001@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Beaumont,
	Charlie \(UK Gloucester\)" <Charlie.Beaumont-IHqVjY1oUdQYQ022hMJolFaTQe2KTcn/@public.gmane.org>
To: "Ned Forrester" <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
In-Reply-To: <4E9D6CAE.6080001-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Thanks for your quick answer Ned. It sounds like the best solution for
our bespoke application, would be to implement a half-duplex driver
designed to simply collect the data from the bespoke master, and then
process the packet offline when the slave select goes high.

-----Original Message-----
From: Ned Forrester [mailto:nforrester-/d+BM93fTQY@public.gmane.org] 
Sent: 18 October 2011 13:10
To: Holdsworth, Joel (UK Guildford)
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org; Beaumont, Charlie (UK
Gloucester)
Subject: Re: SPI Slave Mode

On 10/18/2011 06:13 AM, Holdsworth, Joel wrote:
> Hi All,
> 
> My team are working on an embedded system where we need our 
> application processor to be an SPI slave. The documentation that I 
> have read is very clear that this is currently not supported. I am 
> trying to find out if there is any work planned or underway to add 
> support for this feature, or what work would be required to add 
> support. Would this be the simple addition of a small family of 
> infrastructure functions? Or a major overhaul of the subsystem?

Or is it even possible?  It depends on what you want to accomplish.

> Does anyone have any information about these things?

There was considerable discussion of this several years ago.  
I don't think anything has changed since then.

http://www.mail-archive.com/spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org/msg0
0306.html

The short answer is that generalized slave operation requires
nearly-instant response from the slave, something that an OS is in
capable of.  However, it can work in specialized circumstances, such as
when it is possible to always predict the next request from the master.
Data streaming with a single master and slave is such an example.

> Best Regards
> Joel Holdsworth
> 
> ______________________________________________
> Joel Holdsworth - Engineer
> t +44 (0)1483 816052
> a Detica | Surrey Research Park | Guildford | GU2 7YP | UK 
> ______________________________________________
> www.detica.com <http://www.detica.com/>

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab       508-289-2226 Office / 774-392-5352 Cell
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/
http://www.whoi.edu/page.do?pid=29856
http://www.whoi.edu/hpb/Site.do?id=1532

Please consider the environment before printing this email.
 
This message should be regarded as confidential. If you have received this email in error please notify the sender and destroy it immediately.
 
Statements of intent shall only become binding when confirmed in hard copy by an authorised signatory. 
 
The contents of this email may relate to dealings with other companies under the control of BAE Systems plc details of which can be found at http://www.baesystems.com/Businesses/index.htm.
 
Detica Limited is a BAE Systems company trading as BAE Systems Detica.
Detica Limited is registered in England and Wales under No: 1337451.
Registered office: Surrey Research Park, Guildford, Surrey, GU2 7YP, England.


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct

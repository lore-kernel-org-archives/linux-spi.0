From: Tom <tom.spi.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: wait between bytes
Date: Tue, 15 Mar 2011 03:40:02 +0530
Message-ID: <AANLkTimYghAYwNQSW26=j4SnYkC_6d5frcAjkgNzF7kW@mail.gmail.com>
References: <AANLkTinPtp3h4uv_jvHjms02h9a-GbH=NtObQPEjVj2S@mail.gmail.com>
	<20110314191126.GB16096@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20110314191126.GB16096-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
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

I thought delay_usec is to create delay between transfers (i.e message
transfers ).
Can it be used to create delay between bytes of a single message transfer?

Regards,
Tom

On Tue, Mar 15, 2011 at 12:41 AM, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>wrote:

> On Mon, Mar 14, 2011 at 09:54:50AM +0530, Tom wrote:
> > Hi Everyone,
> >
> > Does SPI framework have a mechanism to insert a delay between the bytes
> of a
> > multi-byte message (transmission or reception).
> > i.e to handle scenarios where
> >
> >    1. the master is operating at a high frequency
> >    2. slave at a lesser frequency
> >    3. a gpio is used as a slave select
> >    4. and byte by byte transfer using multiple spi_write is not a choice.
>
> Yes.  See the delay_usec field in struct spi_transfer.
>
> g.
>
>
------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d

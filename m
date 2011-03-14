From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: wait between bytes
Date: Mon, 14 Mar 2011 16:17:59 -0600
Message-ID: <AANLkTimYoL5SnxfBbzv1d8JpeGkXMjiyKLi=Kaw7WaUJ@mail.gmail.com>
References: <AANLkTinPtp3h4uv_jvHjms02h9a-GbH=NtObQPEjVj2S@mail.gmail.com>
	<20110314191126.GB16096@angua.secretlab.ca>
	<AANLkTimYghAYwNQSW26=j4SnYkC_6d5frcAjkgNzF7kW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Tom <tom.spi.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTimYghAYwNQSW26=j4SnYkC_6d5frcAjkgNzF7kW-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Mar 14, 2011 at 4:10 PM, Tom <tom.spi.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Hi,
> I thought=A0delay_usec is to create delay between transfers (i.e message
> transfers ).

Between transfers; but a single spi message can contain multiple
transfers without twiddling the cs line.

> Can it be used to create delay between bytes of a single message transfer?

No, you'll have to construct a message of multiple single byte
transfers in that case.

g.

---------------------------------------------------------------------------=
---
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d

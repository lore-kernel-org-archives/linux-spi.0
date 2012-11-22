From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Thu, 22 Nov 2012 12:24:09 +0530
Message-ID: <CAM=Q2cszn_OoTyYiUVSj3NvpxJq+wSUnMJVcwWOdV2EzDviLVw@mail.gmail.com>
References: <1353464203.20353.6.camel@bichao>
	<CAM=Q2cvoEMScnCmfrhoAueZ8bfPCX90TxZmsSigfeRbGeXbzMA@mail.gmail.com>
	<253F3AA5ECB4EC43A2CA0147545F67F2102B5D40@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: "Chen, Jun D" <jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Mills,
	Ken K" <ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Centelles,
	Sylvain" <sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: "Bi, Chao" <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <253F3AA5ECB4EC43A2CA0147545F67F2102B5D40-0J0gbvR4kTiiAffOGbnezLfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Nov 22, 2012 at 8:56 AM, Bi, Chao <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

>               if (chip_info->enable_loopback)
> +                       chip->cr1 |=3D SSCR1_LBM;****
>
> Who sets the enable_loopback?****
>
> ** **
>
> [Chao] =91enable_loopback=92 could be configured by SPI Protocol driver b=
efore
> it setup SPI controller. Generally it is not set by default because it=92s
> used for test and validation.
>

Should it not then depend on  (spi mode ) SPI_LOOP ?

Or am I missing something.

> ****
>
> ** **
>
> Thanks
>
---------------------------------------------------------------------------=
---
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov

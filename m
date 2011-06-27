From: Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: fix omap2_mcspi_probe error handling
Date: Mon, 27 Jun 2011 12:23:59 +0800
Message-ID: <BANLkTi=7HEnt_SZjPV+-NOrQX=+XLbBGNg@mail.gmail.com>
References: <1308751077.4846.1.camel@phoenix>
	<BANLkTimQ55xBwzoxnSAKznG-GTHZ+LtShw@mail.gmail.com>
Reply-To: axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Juha Yrjola <juha.yrjola-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BANLkTimQ55xBwzoxnSAKznG-GTHZ+LtShw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2011/6/22 Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>:
> On Wed, Jun 22, 2011 at 7:57 AM, Axel Lin <axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> This patch includes below fixes for error handling:
>> 1. return proper error if kcalloc for mcspi->dma_channels fails
>> 2. return proper error if omap2_mcspi_master_setup fails
>> 3. properly release allocated resources in error paths and
>> =A0 improve the naming of goto labels.
>
> Is this to be applied immediately, or queued up in linux-next for v3.1?
>
It's not urgent. It's ok to queue up in linux-next for v3.1.

Axel

---------------------------------------------------------------------------=
---
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security =

threats, fraudulent activity, and more. Splunk takes this data and makes =

sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
